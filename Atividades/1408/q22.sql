SELECT pnome,count(pnome)
FROM empregado
GROUP BY pnome;