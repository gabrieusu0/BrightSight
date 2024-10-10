CREATE DATABASE BrightSight;

USE BrightSight;

CREATE TABLE empresa (
    IdEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    rua VARCHAR(45),
    bairro VARCHAR(45),
    cidade VARCHAR(45),
    cep CHAR(8),
    numero CHAR(11),
    senha VARCHAR(45) NOT NULL
);

CREATE TABLE local_sensor (
    idLocal INT PRIMARY KEY AUTO_INCREMENT,
    fkEmpresa INT,
    CepLocal CHAR(8),
    regiao VARCHAR(45),
    estado CHAR(2),
    cidade VARCHAR(45),
    numero INT,
    FOREIGN KEY (fkEmpresa) REFERENCES EMPRESA(IdEmpresa)
);

    
CREATE TABLE quadrante (
    idQuadrante INT,
    fkLocal INT,
    PotencialIdeal FLOAT,
    posicao VARCHAR(45),
    PRIMARY KEY (idQuadrante, fkLocal),
    FOREIGN KEY (fkLocal) REFERENCES local_sensor(idLocal)
);

CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    fkQuadrante INT,
    fkLocal INT,
    nome_sensor VARCHAR(45),
    FOREIGN KEY (fkQuadrante, fkLocal) REFERENCES QUADRANTE(idQuadrante, fkLocal)
);

CREATE TABLE dados (
    idDADOS INT PRIMARY KEY AUTO_INCREMENT,
    potenciaAtual INT,
    horaData DATETIME,
    fkSensor INT,
    FOREIGN KEY (fkSensor) REFERENCES SENSOR(idSensor)
);
