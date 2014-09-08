# GRANT ALL PRIVILEGES ON Sollar.* TO 'janjaSollar'@'localhost' IDENTIFIED BY 'janjaSollar';
# pass: janjaSollar2014

DROP DATABASE IF EXISTS Sollar;

CREATE DATABASE Sollar DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

USE Sollar;

CREATE TABLE nivel (
	id INT NOT NULL AUTO_INCREMENT,
	nivel CHAR(32),
	PRIMARY KEY (id)
)ENGINE=InnoDB;

CREATE TABLE user (
	id INT NOT NULL AUTO_INCREMENT,
	nivel_id INT NOT NULL,
    email CHAR(64) NOT NULL,
    nome CHAR(64) NOT NULL,
    senha CHAR(32) NOT NULL,
    dataRegistro TIMESTAMP NOT NULL DEFAULT NOW(),
    dataAcesso TIMESTAMP NOT NULL,
    ativo INT(1),
    PRIMARY KEY (id),
    FOREIGN KEY (nivel_id) REFERENCES nivel(id) ON DELETE RESTRICT
)ENGINE=InnoDB;

CREATE TABLE token (
	id INT NOT NULL AUTO_INCREMENT,
	user_id INT NOT NULL,
	dataRegistro TIMESTAMP NOT NULL DEFAULT NOW(),
	token CHAR(32) NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE RESTRICT
)ENGINE=InnoDB;


CREATE TABLE categoria (
	id INT NOT NULL AUTO_INCREMENT,
	categoria CHAR(32) NOT NULL,
	PRIMARY KEY (id)
)ENGINE=InnoDB;

CREATE TABLE modelo (
	id INT NOT NULL AUTO_INCREMENT,
	modelo CHAR(32) NOT NULL,
	PRIMARY KEY (id)
)ENGINE=InnoDB;

CREATE TABLE produto (
	id INT NOT NULL AUTO_INCREMENT,
	cod CHAR(4) NOT NULL,
	categoria_id INT NOT NULL,
	modelo_id INT NOT NULL,
	tensao CHAR(16) NULL,
	potencia REAL(10,2) NULL,
	cor CHAR(16),
	bocal CHAR(16),
	qtd_caixa INT,
	descricao TEXT,
	preco_unitario numeric(15,2) NULL,
	preco_caixa numeric(15,2) NULL,
	preco_master numeric(15,2) NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (modelo_id) REFERENCES modelo(id) ON DELETE RESTRICT,
	FOREIGN KEY (categoria_id) REFERENCES categoria(id) ON DELETE RESTRICT
)ENGINE=InnoDB;


CREATE TABLE promocao (
	id INT NOT NULL AUTO_INCREMENT,
	promocao CHAR(32) NOT NULL,
	multiplicador REAL(4,2),
	PRIMARY KEY (id)
)ENGINE=InnoDB;

CREATE TABLE produto_promocao (
	id INT NOT NULL AUTO_INCREMENT,
	promocao_id INT NOT NULL,
	produto_id INT NULL,
	categoria_id INT NULL,
	modelo_id INT NULL,
	multiplicador REAL(4,2),
	PRIMARY KEY (id),
	FOREIGN KEY (promocao_id) REFERENCES promocao(id) ON DELETE RESTRICT,
	FOREIGN KEY (produto_id) REFERENCES produto(id) ON DELETE RESTRICT,
	FOREIGN KEY (categoria_id) REFERENCES categoria(id) ON DELETE RESTRICT,
	FOREIGN KEY (modelo_id) REFERENCES modelo(id) ON DELETE RESTRICT
)ENGINE=InnoDB;