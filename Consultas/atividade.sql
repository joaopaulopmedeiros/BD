-- q1 Selecione o nome completo de todos os empregados.
SELECT CONCAT(pnome,' ', minicial,'. ', unome) AS nome_completo
FROM empregado;

-- q2 Selecione o número e nome de todos os departamentos
SELECT dnome
FROM departamento;

-- q3 Selecione o número, nome e a localização de todos os projetos.
SELECT pjnome, pnumero, plocalizacao
FROM projeto;

-- q4 Selecione o ssn, nome e a data de nascimento (dd-mm-yyyy) dos empregados do sexo masculino.
SELECT ssn, pnome, DATE_FORMAT(datanasc, '%d/%m/%y') AS data_nascimento
FROM empregado;

-- q5 Selecione o nome de todos os empregados que não possuem supervisor
SELECT pnome
FROM empregado
WHERE superssn IS NULL;

-- q6 Selecione o nome de todos os dependentes que são cônjuge
SELECT nome_dependente 
FROM dependente
WHERE parentesco = 'cônjuge';

-- q7 Selecione todos os empregados que têm salário maior que 30000.
SELECT pnome 
FROM empregado
WHERE salario > 30000;

-- q8 Selecione todos os empregados do sexo feminino e que ganham mais de 25000
SELECT pnome
FROM empregado
WHERE sexo = 'F' AND salario > 25000; 

-- q9  Selecione todos os empregados que iniciem o nome pela letra J.
SELECT pnome
FROM empregado
WHERE pnome LIKE 'j%';

-- q10  Selecione todos os empregados que possui endereço em Houston
SELECT pnome
FROM empregado
WHERE endereco LIKE '%Houston%';


-- q11 Selecione o nome e a data de nascimento (dd-mm-yyyy) de todos os dependentes que são cônjuge ou que são filho.
SELECT nome_dependente, datanasc
FROM dependente
WHERE parentesco = 'cônjuge' OR parentesco = 'filho';

-- q12 Selecione o nome de todos os projetos que estão localizados em Stafford.
SELECT pjnome 
FROM projeto
WHERE plocalizacao = 'Houston';

-- q13 Selecione o nome concatenado pelo último nome de todos os empregados do sexo feminino, que ganham mais de 30000 e que mora em Berry.
SELECT CONCAT(pnome,' ', unome) as nome_concatenado
FROM empregado
WHERE sexo = 'f' AND salario > 30000 AND endereco LIKE '%Berry%';

-- q14 Selecione todos os empregados que ganham salário entre 38000 e 43000.
SELECT pnome
FROM empregado
WHERE salario BETWEEN 38000 AND 43000;

-- q15 Selecione o número do departamento e a quantidade de empregados por sexo.
SELECT dno, COUNT(ssn) as qtd_empregado
from empregado
WHERE sexo = 'f'
GROUP BY dno;

-- q16. Selecione o número do departamento e a quantidade de empregados por departamento.
SELECT dno, COUNT(ssn)
FROM empregado
GROUP BY dno;

-- q17. Selecione o número do departamento e a quantidade de projetos por departamento.
SELECT dnum,COUNT(pnumero) as num_projetos 
FROM projeto
GROUP BY dnum;

-- q18. Selecione o número do departamento e a média salarial por departamento.
SELECT dno,AVG(salario) 
FROM empregado
GROUP by dno;

-- q19. Selecione o sexo e os maiores salário por sexo.
SELECT sexo,salario 
FROM empregado;

-- q20 
SELECT sum(salario) 
FROM empregado
WHERE dno = 4;

-- q21
SELECT AVG(salario)
FROM empregado
WHERE endereco LIKE '%houston%' AND sexo = 'M';

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



-- 34. Selecione o ssn, nome e data de nascimento de todos os empregados que tem mais de um
-- dependente, que trabalham mais de 5 horas e cujo departamento do projeto esteja em "Houston".

SELECT e.ssn, e.pnome, e.datanasc, depn.qtd_dependente, t.tot_horas,e.dno, dept.dnumero, dept.dlocalizacao

FROM empregado as e 

    INNER JOIN (
        SELECT dependente.essn as essn, COUNT(*) as qtd_dependente
        FROM dependente
        GROUP BY dependente.essn
    ) as depn
    ON (e.ssn = depn.essn)
    
    INNER JOIN (
    	SELECT essn as essn, SUM(horas) as tot_horas
		FROM trabalha_em
		GROUP by essn
    ) as t
    ON (e.ssn = t.essn)
    
    INNER JOIN (
    	SELECT dnumero, dlocalizacao
		FROM dept_localizacoes
    ) as dept
    ON (e.dno = dept.dnumero)

WHERE depn.qtd_dependente > 1 and t.tot_horas > 5 and dept.dlocalizacao = 'Houston';


-- q35. Selecione o ssn, o nome dos empregados, o nome e total de horas trabalhadas por projeto.
SELECT e.ssn, e.pnome, p.pjnome, t.horas
FROM empregado as e
	INNER JOIN trabalha_em as t
	ON (e.ssn = t.essn)
	INNER JOIN projeto as p
	ON (t.pno = p.pnumero)
ORDER BY e.ssn;


-- q36. Selecione o ssn e o nome de todos os empregados que ganham mais que seu supervisor.
SELECT e.ssn, e.pnome
FROM empregado as e
	INNER JOIN (
		SELECT ssn, salario 
	    FROM empregado
	) as sup
	ON (e.superssn = sup.ssn)
WHERE e.salario > sup.salario;


-- q37. Selecione o nome e salário dos empregados, e o nome e salário do supervisor, e a diferença de
-- salários entre eles, para todos os empregados.

SELECT e.pnome as nome_empregado, 
	   e.salario as sal_empregado,
       sup.pnome as nome_supervisor,
       sup.salario as sal_chefe,
       ( e.salario-sup.salario) as dif_salarial
FROM empregado e
	INNER JOIN(
		SELECT ssn, pnome, salario 
	    FROM empregado
	) as sup
	ON (sup.ssn = e.superssn);

-- q38. Selecione o nome do projeto, o nome do departamento, sua localização e a quantidades de
-- empregados que trabalham nele.
SELECT p.pjnome, x.dnome, y.qtd_empregado, dept.dlocalizacao 
FROM projeto as p
	INNER JOIN(
		SELECT dnome, dnumero 
	    FROM departamento
	) as x
	ON (p.dnum = x.dnumero)
	INNER JOIN (
		SELECT e.ssn, e.dno, COUNT(e.ssn) as qtd_empregado
	    FROM empregado as e
	    GROUP BY dno
	) as y
	ON(y.dno = x.dnumero)
	INNER JOIN dept_localizacoes as dept
	ON(dept.dnumero = x.dnumero)
GROUP BY pjnome;

-- q39. Selecione o ssn e o nome de todos os empregados que gerenciam mais de um departamento.

SELECT e.ssn,e.pnome 
FROM empregado as e
	INNER JOIN (
		SELECT gerssn , COUNT(*) as qtd
	    FROM departamento as d
	    GROUP BY gerssn
	) as dept
	ON (e.ssn = dept.gerssn)
WHERE qtd>1;

-- q40. Selecione o ssn e nome dos empregados que gerenciam um departamento que não é o seu.
SELECT e.ssn,e.pnome
FROM empregado as e
	INNER JOIN (
		SELECT gerssn, dnumero , COUNT(*) as qtd
	    FROM departamento as d
	    GROUP BY gerssn
	) as dept
	ON (e.ssn = dept.gerssn)
WHERE  e.dno <> dept.dnumero;

-- q41. Selecione o ssn e nome dos empregados que têm um casal de filhos
SELECT e.ssn, e.pnome, depn.qtd_dependente
FROM empregado as e
	INNER JOIN (
		SELECT d.essn, d.parentesco, d.nome_dependente, d.sexo, COUNT(d.essn) AS qtd_dependente
	    FROM dependente as d
	    GROUP BY d.essn
	) as depn
	ON (e.ssn = depn.essn)
WHERE depn.parentesco <> 'cônjuge' AND qtd_dependente=2;