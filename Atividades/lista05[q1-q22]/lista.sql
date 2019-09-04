/*
Autor: João Paulo P. de Medeiros
Turma: 3.4111.1V
Disciplina: Banco de Dados
Lista 05
*/

-- q1
SELECT CONCAT(pnome,' ',minicial,' ',unome) AS nome
FROM empregado;

-- q2
SELECT dnumero,dnome FROM departamento AS d;

-- q3
SELECT pnumero, pjnome, plocalizacao FROM projeto;

-- q4
SELECT ssn, pnome, DATE_FORMAT(datanasc,'%d-%m-%Y') 
FROM empregado 
WHERE sexo="M";

-- q5
SELECT pnome 
FROM empregado 
WHERE superssn IS NULL;

-- q6
SELECT nome_dependente 
FROM dependente 
WHERE parentesco = "cônjuge";

-- q7
SELECT pnome 
FROM empregado 
WHERE salario >= 30000;

-- q8
SELECT pnome 
FROM empregado 
WHERE sexo="F" AND salario >= 25000;

-- q9
SELECT pnome 
FROM empregado 
WHERE pnome LIKE 'J%';

-- q10
SELECT * 
FROM empregado 
WHERE endereco LIKE "%Houston%";

-- q11
SELECT nome_dependente, DATE_FORMAT(datanasc, '%d-%m-%Y')  AS datanascimento
FROM dependente 
WHERE parentesco = "cônjuge" OR parentesco = "filho";

-- q12
SELECT pjnome 
FROM projeto 
WHERE plocalizacao = "Stafford";

-- q13
SELECT CONCAT(pnome, ' ', unome)  AS nome
FROM empregado 
WHERE sexo = "F" AND salario >= 3000 AND endereco LIKE '%Berry%';

-- q14
SELECT * 
FROM empregado 
WHERE salario BETWEEN 38000 AND 43000;

-- q15
SELECT dno,sexo,COUNT(sexo)
FROM empregado
GROUP BY dno,sexo;

-- q16
SELECT dno,COUNT(dno)
FROM empregado
GROUP BY dno;

-- q16
SELECT dnum,COUNT(pnumero) 
FROM projeto
GROUP BY dnum;

-- q17
SELECT dnum,COUNT(pnumero) 
FROM projeto
GROUP BY dnum;

-- q18
SELECT dno,AVG(salario)
FROM empregado
GROUP BY dno;

-- q19
SELECT sexo, max(salario) 
FROM empregado
GROUP BY sexo;

-- q20
SELECT sum(salario) 
FROM empregado
WHERE dno = 4;

-- q21
SELECT AVG(salario)
FROM empregado
WHERE endereco LIKE '%houston%' AND sexo = 'M';

-- q22
SELECT pnome,count(pnome)
FROM empregado
GROUP BY pnome;
