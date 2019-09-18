-- q23
SELECT parentesco, COUNT(parentesco)
FROM dependente
GROUP BY parentesco;

-- q24
SELECT pnome
FROM empregado
ORDER BY pnome ASC;

-- q25
SELECT pnome
FROM empregado
ORDER BY datanasc ASC;

-- q26
SELECT pnome
FROM empregado
ORDER BY salario DESC, pnome ASC;

-- q27
SELECT pnome
FROM empregado 
INNER JOIN dependente ON (essn=ssn)
GROUP BY pnome;


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
SELECT e.ssn, e.pnome
FROM empregado as e;
-- 32
SELECT e.pnome, count(d.nome_dependente)
FROM empregado as e
LEFT JOIN dependente as d
ON e.ssn = d.essn
GROUP BY e.pnome;
