SELECT e.sexo,
COUNT(*)
FROM empregado AS e
GROUP BY e.sexo