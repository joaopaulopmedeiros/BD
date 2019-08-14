SELECT e.dno,
AVG(e.salario)
FROM empregado AS e
GROUP BY e.dno
HAVING AVG(e.salario) < 55000