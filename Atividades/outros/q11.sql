CREATE DATABASE IF NOT EXISTS questao11;
CREATE TABLE IF NOT EXISTS questao11.tb_cliente(
    codigo int NOT NULL AUTO_INCREMENT,
    nome varchar(50),
    endereco varchar(50),
    cidade varchar(50),
    estado varchar(2),
    sexo char,
    data_nascimento date,
    salario double,
    cpf varchar(14),
    email varchar(30),
    PRIMARY KEY(codigo)
);
CREATE TABLE IF NOT EXISTS questao11.tb_projeto(
    codigo int NOT NULL AUTO_INCREMENT,
    descricao varchar(50) NOT NULL,
    data_inicio date,
    data_termino date,
    PRIMARY KEY(codigo)
);

CREATE TABLE IF NOT EXISTS questao11.tb_cliente_projeto(
    codigo_cliente int NOT NULL,
    codigo_projeto int NOT NULL,
    ch int, 
    FOREIGN KEY(codigo_cliente) REFERENCES tb_cliente(codigo),
    FOREIGN KEY(codigo_projeto) REFERENCES tb_projeto(codigo)
);