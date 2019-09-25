-- 1. Selecione o nome completo de todos os empregados.
SELECT CONCAT(pnome,' ', minicial,'. ', unome) AS nome_completo
FROM empregado;

-- 2. Selecione o número e nome de todos os departamentos
SELECT dnome, dnumero
FROM departamento;

-- 3. Selecione o número, nome e a localização de todos os projetos.
SELECT pnumero, pjnome, plocalizacao
FROM projeto;

-- 4. Selecione o ssn, nome e a data de nascimento (dd-mm-yyyy) dos empregados do sexo masculino.
SELECT ssn, pnome, DATE_FORMAT(datanasc, '%d/%m/%y') AS data_nascimento
FROM empregado;

-- 5. Selecione o nome de todos os empregados que não possuem supervisor
SELECT pnome
FROM empregado
WHERE superssn IS NULL;

-- 6. Selecione o nome de todos os dependentes que são cônjuge
SELECT nome_dependente 
FROM dependente
WHERE parentesco = 'cônjuge';

-- 7. Selecione todos os empregados que têm salário maior que 30000.
SELECT pnome 
FROM empregado
WHERE salario > 30000;

-- 8. Selecione todos os empregados do sexo feminino e que ganham mais de 25000
SELECT pnome
FROM empregado
WHERE sexo = 'F' AND salario > 25000; 

-- 9.  Selecione todos os empregados que iniciem o nome pela letra J.
SELECT pnome
FROM empregado
WHERE pnome LIKE 'j%';

-- 10.  Selecione todos os empregados que possuem endereço em Houston
SELECT pnome
FROM empregado
WHERE endereco LIKE '%Houston%';


-- 11. Selecione o nome e a data de nascimento (dd-mm-yyyy) de todos os dependentes que são cônjuge ou que são filho.
SELECT nome_dependente, datanasc
FROM dependente
WHERE parentesco = 'cônjuge' OR parentesco = 'filho';

-- 12. Selecione o nome de todos os projetos que estão localizados em Stafford.
SELECT pjnome 
FROM projeto
WHERE plocalizacao = 'Stafford';

-- 13. Selecione o nome concatenado pelo último nome de todos os empregados do sexo feminino, que ganham mais de 30000 e que mora em Berry.
SELECT CONCAT(pnome,' ', unome) as nome_concatenado
FROM empregado
WHERE sexo = 'f' AND salario > 30000 AND endereco LIKE '%Berry%';

-- 14. Selecione todos os empregados que ganham salário entre 38000 e 43000.
SELECT pnome
FROM empregado
WHERE salario BETWEEN 38000 AND 43000;

-- q15 Selecione o número do departamento e a quantidade de empregados por sexo.
SELECT e.dno, e.sexo, count(*)
FROM empregado AS e
GROUP BY e.dno,e.sexo;


-- 16. Selecione o número do departamento e a quantidade de empregados por departamento.
SELECT dno, COUNT(ssn)
FROM empregado
GROUP BY dno;

-- 17. Selecione o número do departamento e a quantidade de projetos por departamento.
SELECT dnum,COUNT(pnumero) as num_projetos 
FROM projeto
GROUP BY dnum;

-- 18. Selecione o número do departamento e a média salarial por departamento.
SELECT dno,AVG(salario) 
FROM empregado
GROUP by dno;

-- 19. Selecione o sexo e os maiores salário por sexo.
SELECT sexo,MAX(salario) 
FROM empregado
GROUP BY sexo;

-- 20. Selecione a soma de todos salários dos empregados que são do departamento 4. 
SELECT sum(salario) 
FROM empregado
WHERE dno = 4;

-- 21. Selecione a média de todos os salários dos empregados que moram em Houston e que são do sexo masculino.
SELECT AVG(salario)
FROM empregado
WHERE endereco LIKE '%houston%' AND sexo = 'M';

-- 22. Selecione o nome dos empregados e a quantidade de vezes que cada nome se repete.
SELECT pnome, COUNT(*)
FROM empregado
GROUP BY pnome;

-- 23. Selecione o tipo de parentesco dos dependentes e a quantidade de vezes em que cada tipo aparece.
SELECT parentesco, count(*)
FROM dependente
GROUP BY parentesco;

-- 24. Selecione todos os empregados ordenados acesdentemente por nome.
SELECT pnome
FROM empregado
ORDER BY pnome ASC;

-- 25. Selecione todos os empregados ordenados decrescentemente por idade.
SELECT pnome
FROM empregado
ORDER BY datanasc ASC;

-- 26. Selecione todos os empregados ordenado decrescentemento por salário, e ascendente por nome.
SELECT pnome
FROM empregado
ORDER BY salario DESC, pnome ASC;

-- 27. Selecione todos os empregados que têm dependentes.
SELECT pnome
FROM empregado 
INNER JOIN dependente ON (essn=ssn)
GROUP BY pnome;

-- 28. Selecione o nome e a data de nascimento dos empregados e o nome e a data de nascimento do do dependente cônjugue, em que a data de 
-- nascimento do empregado for menor que a data de nascimento do seu cônjugue.
SELECT 
	e.pnome, 
	e.datanasc, 
	d.nome_dependente,
	d.datanasc
FROM empregado as e
	 INNER JOIN dependente as d
     ON (d.essn=e.ssn AND parentesco="cônjuge" AND e.datanasc<d.datanasc);


-- 29. Selecione todos os empregados que trabalham em um projeto cujo departamento não é o seu.
SELECT e.pnome 
FROM empregado as e
	INNER JOIN trabalha_em AS t 
	ON (e.ssn=t.essn)
	INNER JOIN projeto as p 
	ON (t.pno=p.pnumero and e.dno<>p.dnum)
GROUP BY e.pnome;


-- 30. Selecione o ssn, o nome, e a diferença salarial em relação à média por sexo dos funcionários.
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


-- 33. Selecione o ssn e o nome de todos os funcionários que trabalham apenas em projetos do próprio departamento.
SELECT e.ssn, e.pnome, e.dno,t.pno,p.pnumero, p.dnum 
FROM empregado as e
	INNER JOIN trabalha_em as t
	ON (e.ssn = t.essn)
	INNER JOIN projeto as p
	ON (t.pno = p.pnumero)
GROUP BY e.ssn
HAVING (e.dno = p.dnum)
ORDER BY e.ssn;


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


-- 35. Selecione o ssn, o nome dos empregados, o nome e total de horas trabalhadas por projeto.
SELECT e.ssn, e.pnome, p.pjnome, t.horas
FROM empregado as e
	INNER JOIN trabalha_em as t
	ON (e.ssn = t.essn)
	INNER JOIN projeto as p
	ON (t.pno = p.pnumero)
ORDER BY e.ssn;


-- 36. Selecione o ssn e o nome de todos os empregados que ganham mais que seu supervisor.
SELECT e.ssn, e.pnome
FROM empregado as e
	INNER JOIN (
		SELECT ssn, salario 
	    FROM empregado
	) as sup
	ON (e.superssn = sup.ssn)
WHERE e.salario > sup.salario;


-- 37. Selecione o nome e salário dos empregados, e o nome e salário do supervisor, e a diferença de
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

-- 38. Selecione o nome do projeto, o nome do departamento, sua localização e a quantidades de
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

-- 39. Selecione o ssn e o nome de todos os empregados que gerenciam mais de um departamento.

SELECT e.ssn,e.pnome 
FROM empregado as e
	INNER JOIN (
		SELECT gerssn , COUNT(*) as qtd
	    FROM departamento as d
	    GROUP BY gerssn
	) as dept
	ON (e.ssn = dept.gerssn)
WHERE qtd>1;

-- 40. Selecione o ssn e nome dos empregados que gerenciam um departamento que não é o seu.
SELECT e.ssn,e.pnome
FROM empregado as e
	INNER JOIN (
		SELECT gerssn, dnumero , COUNT(*) as qtd
	    FROM departamento as d
	    GROUP BY gerssn
	) as dept
	ON (e.ssn = dept.gerssn)
WHERE  e.dno <> dept.dnumero;

-- 41. Selecione o ssn e nome dos empregados que têm um casal de filhos
SELECT e.ssn, e.pnome 
FROM empregado as e
	INNER JOIN (
		SELECT essn, nome_dependente, sexo, parentesco, COUNT(*) as qtd_dependente
		FROM dependente 
		WHERE parentesco = 'FILHO' OR parentesco = 'FILHA'
		GROUP BY essn
	) as d
	ON(e.ssn = d.essn)
WHERE d.qtd_dependente = 2;
