-- q23
SELECT
   parentesco,
   count(parentesco) 
FROM
   dependente 
GROUP BY
   parentesco;
-- q24
SELECT
   pnome 
FROM
   empregado 
ORDER BY
   pnome ASC;
-- q25
SELECT
   pnome 
FROM
   empregado 
ORDER BY
   datanasc ASC;
-- q26
SELECT
   pnome 
FROM
   empregado 
ORDER BY
   salario DESC,
   pnome ASC;
-- q27
SELECT
   pnome 
FROM
   empregado 
   INNER JOIN
      dependente 
      ON (essn = ssn) 
GROUP BY
   pnome;