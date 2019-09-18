-- 28
SELECT 
	e.pnome, 
	e.datanasc, 
	d.nome_dependente,
	d.datanasc
FROM empregado as e
	 INNER JOIN dependente as d
     ON (essn=ssn AND parentesco="cônjuge" AND e.datanasc<d.datanasc);

-- 29
SELECT e.pnome 
FROM empregado as e
	INNER JOIN trabalha_em AS t 
	ON (e.ssn=t.essn)
	INNER JOIN projeto as p 
	ON (t.pno=p.pnumero and e.dno<>p.dnum)
GROUP BY e.pnome;

-- 30
SELECT 
	e.pnome, 
	e.ssn,
	e.salario-media as dif
FROM empregado as e
INNER JOIN
(SELECT e.sexo,avg(e.salario) as media FROM empregado as e
 GROUP BY e.sexo
) as x
ON(e.sexo=x.sexo);

-- 31. Selecione o ssn e o nome todos os empregados que trabalham mais de 40 horas.
SELECT 
	e.ssn, e.pnome,t.total_horas
FROM 
	empregado as e
	INNER JOIN(
		SELECT essn, SUM(horas) AS total_horas
		FROM trabalha_em
		GROUP BY essn
	) as t on e.ssn = t.essn
WHERE t.total_horas > 40;

-- 32. Selecione o nome e a quantidades de dependentes de todos os funcionários.
SELECT 
	e.pnome, count(d.nome_dependente)
FROM 
	empregado as e
	LEFT JOIN dependente as d
	ON e.ssn = d.essn
	GROUP BY e.pnome;

-- 33. Selecione o ssn e o nome de todos os funcionários que trabalham apenas em 
-- projetos do próprio departamento.

-- 34. Selecione o ssn, nome e data de nascimento de todos os empregados que tem mais de um
-- dependente, que trabalham mais de 5 horas e cujo departamento do projeto esteja em "Houston".
SELECT 
	e.ssn, e.pnome, e.datanasc, x.qtd, y.tot_hora, p.plocalizacao
FROM 
	empregado as e
	INNER JOIN(
		SELECT essn, COUNT(essn) as qtd
		FROM dependente as d
		GROUP BY essn 
	) as x ON (e.ssn = x.essn AND qtd>1)
	INNER JOIN(
		SELECT essn, SUM(horas) as tot_hora
		FROM trabalha_em as t
		GROUP BY essn
	) as y ON (x.essn=y.essn AND y.tot_hora>5)
	INNER JOIN(
		SELECT essn,pno
		FROM trabalha_em
	) as t ON (t.essn = e.ssn)
	INNER JOIN(
		SELECT pnumero,plocalizacao FROM projeto
	) as p ON (t.pno = p.pnumero AND p.plocalizacao LIKE '%Houston%')
GROUP BY e.ssn;