SELECT sexo, max(salario) 
FROM empregado
GROUP BY sexo;