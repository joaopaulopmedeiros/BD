SELECT nome_dependente, DATE_FORMAT(datanasc, '%d-%m-%Y') 
FROM dependente WHERE parentesco = "cônjuge" OR parentesco = "filho";