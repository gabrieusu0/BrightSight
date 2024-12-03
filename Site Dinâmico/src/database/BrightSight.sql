CREATE DATABASE BrightSight;

USE BrightSight;

    
CREATE TABLE empresa (
	idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50),
    telefone CHAR(12),
	cnpj CHAR(14),
	rua VARCHAR(45),
	bairro VARCHAR(45),
	cidade VARCHAR(45),
	cep CHAR(8),
	numero CHAR(11),
	senha VARCHAR(45),
    codigoVerificacao CHAR(6)
);

SELECT * FROM usuario;

INSERT INTO empresa (nome, telefone, CNPJ, rua, bairro, cidade, cep, numero, senha, codigoVerificacao) VALUES
	('SolarTech', '11940028922', '12345678000199', 'Rua das Flores', 'Centro', 'São Paulo', '01001000', '100', 'Senha123', 'A1B2C3');
    
CREATE TABLE usuario (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    email VARCHAR(45) UNIQUE,
    senha VARCHAR(45) UNIQUE,
    fkEmpresa int,
    CONSTRAINT fkCodigoUsuario FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa)
    );
    

SELECT * FROM empresa JOIN local_sensor ON fkEmpresa = idEmpresa WHERE idEmpresa = 1 AND local_sensor.estado = "MG";

SELECT local_sensor.estado, local_sensor.cidade FROM empresa JOIN local_sensor ON fkEmpresa = idEmpresa WHERE idEmpresa = 1;

SELECT * FROM usuario;

CREATE TABLE local_sensor (
idLocal INT AUTO_INCREMENT PRIMARY KEY,
fkEmpresa INT,
cepLocal CHAR(8),
regiao VARCHAR(45),
estado CHAR(2),
cidade VARCHAR(100),
numero INT,
FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO local_sensor (fkEmpresa, CepLocal, regiao, estado, cidade, numero) VALUES 
(1, '80020000', 'Centro', 'PR', 'Curitiba', 300),
(1, '30150000', 'Lagoa', 'MG', 'Belo Horizonte', 400);
    
SELECT * FROM local_sensor;
    
CREATE TABLE quadrante (
	idQuadrante INT,
    fkLocal INT,
    potenciaIdeal INT,
    posicao VARCHAR(45),
	PRIMARY KEY (idQuadrante, fkLocal),
	FOREIGN KEY (fkLocal) REFERENCES local_sensor (idLocal)
);



INSERT INTO quadrante (idQuadrante, fkLocal, potenciaIdeal, posicao) VALUES 
	(1, 1, 850, 'Norte'),
	(2, 1, 780, 'Sul'),
	(1, 2, 850, 'Leste'),
	(2, 2, 780, 'Oeste');
    
SELECT * FROM quadrante
ORDER BY fkLocal;


CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    fkQuadrante INT,
    fkLocal INT,
    numero_serie VARCHAR(45),
    FOREIGN KEY (fkQuadrante, fkLocal) REFERENCES quadrante (idQuadrante, fkLocal)
);

INSERT INTO sensor  (fkQuadrante, fkLocal, numero_serie) VALUES 
	(1, 1, 'Sensor PR-Norte'),
	(2, 1, 'Sensor PR-Sul'),
    
	(1, 2, 'Sensor MG-Leste'),
	(2, 2, 'Sensor MG-Oeste');
    
SELECT * FROM sensor;


CREATE TABLE dados (
	idDados INT PRIMARY KEY AUTO_INCREMENT,
    potenciaAtual INT,
    horaData TIMESTAMP default current_timestamp,
    fkSensor INT,
	FOREIGN KEY (fkSensor) REFERENCES sensor (idSensor)
);

SELECT * FROM sensor;
SELECT * FROM dados;
SELECT * FROM usuario;
SELECT * FROM empresa;
SELECT * FROM sensor;


SELECT 
    e.nome AS 'Nome Empresa', 
    ls.cidade AS 'Cidade do Local do Sensor',
    ls.estado AS 'Estado do Local do Sensor',
    q.posicao AS 'Posicao Quadrante',
    q.potenciaIdeal AS 'Potencia Ideal Quadrante',
    s.numero_serie AS 'Numero Serie do Sensor',
    d.potenciaAtual AS 'Potencia Atual do Sensor',
    d.horaData AS 'Data e Hora da Leitura'
FROM empresa as e                   /*nome da empresa*/
JOIN local_sensor as ls             /*tudo do local do sensor*/
ON e.idEmpresa = ls.fkEmpresa       /*idEmpresa na empresa = fkEmpresa em local_sensor*/
JOIN quadrante as q                 /*quadrante para mostrar potencia e posição*/
ON ls.idLocal = q.fkLocal           /*idLocal em local_sensor = fkLocal em quadrante*/
JOIN sensor as s                    /*sensor para mostrar seu numero de serie*/
ON q.idQuadrante = s.fkQuadrante AND q.fkLocal = s.fkLocal   /*Referencias as duas chaves primarias pois é composta*/
JOIN dados as d                     /*dados para mostrar a potencia registrada e data/hora*/
ON s.idSensor = d.fkSensor;          /*idSensor em sensor = fkSensor em dados*/


SELECT 
	quadrante.posicao as 'Quadrante'
FROM quadrante JOIN local_sensor
	ON quadrante.fkLocal = local_sensor.idLocal
JOIN empresa
	ON local_sensor.fkEmpresa = empresa.idEmpresa
WHERE idEmpresa = 1;

SELECT local_sensor.estado, local_sensor.cidade, quadrante.posicao FROM empresa JOIN local_sensor ON fkEmpresa = idEmpresa JOIN quadrante ON quadrante.fkLocal = local_sensor.idLocal WHERE idEmpresa = 1;






