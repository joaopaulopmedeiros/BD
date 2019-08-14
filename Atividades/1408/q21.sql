SELECT AVG(salario)
FROM empregado
WHERE endereco LIKE '%houston%' AND sexo = 'M';