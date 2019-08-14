SELECT e.sexo,
AVG(e.salario)
FROM empregado AS e
GROUP BY e.sexo