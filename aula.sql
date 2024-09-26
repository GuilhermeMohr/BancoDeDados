-- 	**** M2 - ATIVIDADE EM SALA 02 ****
/* Com base no uso do banco de dados clinica_vet (código para criação do 
 esquema no final deste arquivo linha 39 a 120), efetue as seguintes atividades: */
 
 -- OBS: Estregar este arquivo com o codigo solicitado em cada tarefa em ordem cronológica.
 
 /*	1. Com o uso do comando ALTER, efetue as seguintes modificações no esquema clinica_vet: */
	-- a. Adicione um novo campo à tabela Tutor nomeado data_nascimento, para armazenar a data de nascimento dos tutores.       
       alter table Tutor add column data_nascimento date after cpf;
       
	-- b. Modifique o campo cpf na tabela Tutor para aceitar até 14 caracteres (para incluir a formatação de CPF com pontos e traços).
	   alter table Tutor modify column cpf varchar(14);
       
	-- C. Modifique o nome da coluna fone da tabela Tutor para telefone, para tornar o nome mais claro.
	   ALTER TABLE Tutor CHANGE fone telefone varchar(16);
       
    -- D. Adicione uma restrição de unicidade ao campo telefone na tabela Veterinario para garantir que não haja duplicatas.
	   alter table Tutor modify column telefone varchar(16) not null;
       
	-- E. Remova o campo complemento da tabela Tutor_endereco, pois ele não será mais utilizado.
       ALTER TABLE Tutor_endereco DROP COLUMN complemento;
       
	-- F. Renomeie a tabela Veterinario_endereco para Endereco_veterinario, tornando o nome mais claro e consistente.
       rename table veterinario_endereco to endereco_veterinario;
       
    -- G. Adicione uma chave estrangeira à tabela Consulta para garantir que cada consulta tenha um tutor associado, vinculando a tabela Tutor.
       alter table consulta add column id_tutor int;
       alter table consulta add constraint fk_consulta_tutor foreign key (id_tutor) references tutor(id);
       
	-- H. Modifique o campo especialidade na tabela Veterinario para torná-lo obrigatório (não aceitar NULL) e, em seguida, faça o mesmo com o campo rua na tabela Endereco_veterinario.
	   alter table veterinario modify column especialidade varchar(100) not null;
       alter table endereco_veterinario modify column rua varchar(100) not null;
       
	-- I.  Modifique os tipos de dados de duas colunas da tabela Consulta: altere o campo horario para DATETIME e o campo dt para TIMESTAMP.
		alter table consulta modify column horario datetime not null, modify column dt timestamp;


/* 	2. Geração e inserção de dados sintéticos. */
	/* a. Pesquisar e apresentar uma forma de inserir uma grande quantidade de 
		dados artificiais no banco de dados. */
	/* b. Com o uso da técnica apresentada no item 1, efetue a inserção da seguinte 
		quantidade de dados: 50 tutores com seus respectivos endereços; 
		30 veterinário com seus respectivos endereços; 70 animais; e 100 consultas. */
	
	
	
SET FOREIGN_KEY_CHECKS = 0;

-- **** CÓDIGO PARA A CRIAÇÃO DO ESQUEMA CLINICA_VET ****
-- CRIAÇÃO DE ESQUEMA E TABELAS
CREATE SCHEMA clinica_vet;
use clinica_vet;
-- SET SQL_SAFE_UPDATES = 0;
-- DROP SCHEMA clinica_vet;tutor

-- Tutor(id, cpf, nome, email, fone)]
-- DROP TABLE Tutor;
CREATE TABLE Tutor (
    id integer PRIMARY KEY,    
    cpf varchar(12) NOT NULL UNIQUE,
	nome varchar(100) NOT NULL,
    email varchar(200) UNIQUE,
    fone varchar(16) NOT NULL
);

-- Animal(id, id_tutor, peso, raca, especie, cor, sexo, data_nasc)
-- DROP TABLE Animal;
CREATE TABLE Animal (
    id INT PRIMARY KEY auto_increment,
	id_tutor INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    peso decimal(5,2),
    raca VARCHAR(100) NOT NULL,
    especie VARCHAR(100),
	cor VARCHAR(100),
	sexo VARCHAR(10),
	data_nasc date,
    CONSTRAINT fk_animal_tutor FOREIGN KEY (id_tutor) REFERENCES Tutor(id)
);

-- Tutor_endereço(id, id_tutor, cep, rua, numero, complemento, cidade, uf)
-- DROP TABLE Tutor_endereco;
CREATE TABLE Tutor_endereco (
    id INT PRIMARY KEY auto_increment,
	id_tutor integer NOT NULL,
	cep varchar(12) NOT NULL,
    rua varchar(100),
    numero integer NOT NULL,
    complemento varchar(50),
    cidade varchar(50),
    uf varchar(2),
	CONSTRAINT fk_tutend_tut FOREIGN KEY (id_tutor) REFERENCES Tutor (id)
);

-- Veterinário(id, nome, crmv, email, fone, especialidade)
-- DROP TABLE Veterinario;
CREATE TABLE Veterinario (
    id INT PRIMARY KEY auto_increment,
    nome VARCHAR(100),
    crmv VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(200) UNIQUE,
    fone VARCHAR(16),
	especialidade VARCHAR(100)
);

-- Veterinario_endereço(id, id_vet, cep, rua, numero, complemento, cidade, uf)
-- DROP TABLE Veterinario_endereço;
CREATE TABLE Veterinario_endereco (
    id INT PRIMARY KEY auto_increment,
	id_vet INT NOT NULL,
	cep VARCHAR(12),
    rua VARCHAR(100),
    numero INT,
    complemento VARCHAR(50),
    cidade VARCHAR(50),
    uf char(2),
	CONSTRAINT fk_vetend_vet FOREIGN KEY (id_vet) REFERENCES Veterinario(id)
);

-- Consulta(id, id_vet, id_animal, dt, horario)
-- DROP TABLE Consulta;
CREATE TABLE Consulta (
    id INT PRIMARY KEY auto_increment,
	id_vet INT NOT NULL,
    id_animal INT NOT NULL,
    dt DATE NOT NULL,
    horario TIME NOT NULL,
    CONSTRAINT fk_cons_vet FOREIGN KEY (id_vet) REFERENCES Veterinario(id), 
    CONSTRAINT fk_cons_anim FOREIGN KEY (id_Animal) REFERENCES Animal(id)
);
