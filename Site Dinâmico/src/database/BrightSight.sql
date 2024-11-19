CREATE DATABASE BrightSight;

USE BrightSight;

    
CREATE TABLE empresa (
	idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50),
	cnpj CHAR(14),
	rua VARCHAR(45),
	bairro VARCHAR(45),
	cidade VARCHAR(45),
	cep CHAR(8),
	numero CHAR(11),
	senha VARCHAR(45),
    codigoVerificacao CHAR(6)
);

INSERT INTO empresa (nome, CNPJ, rua, bairro, cidade, cep, numero, senha, codigoVerificacao) VALUES
	('SolarTech', '12345678000199', 'Rua das Flores', 'Centro', 'São Paulo', '01001000', '100', 'Senha123', 'A1B2C3'),
	('EcoEnergy', '98765432000188', 'Av. Paulista', 'Bela Vista', 'São Paulo', '01310000', '200', 'EcoSenha2024', 'A2B3C4'),
	('GreenPower', '56473829000177', 'Rua Verde', 'Jardim das Águas', 'Curitiba', '80010000', '300', 'Green2024', 'A3B4C5'),
	('EnergiaLimpa', '11223344000166', 'Rua da Luz', 'Alto da Lapa', 'São Paulo', '05050000', '150', 'LuzSegura2024', 'A4B5C6'),
	('SolEnergia', '22334455000155', 'Av. Solar', 'Sol Nascente', 'Belo Horizonte', '30110000', '250', 'SolForte2024', 'A5B6C7');
    
CREATE TABLE usuario (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    email VARCHAR(45) UNIQUE,
    senha VARCHAR(45) UNIQUE,
    fkEmpresa int,
    CONSTRAINT fkCodigoUsuario FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa)
    );

SELECT * FROM empresa;

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

INSERT INTO local_sensor (fkEmpresa, CepLocal, regiao, estado, cidade, numero)
VALUES 
(1, '01001000', 'Centro', 'SP', 'São Paulo', 100),
(2, '20040010', 'Zona Sul', 'RJ', 'Rio de Janeiro', 200),
(3, '80020000', 'Centro', 'PR', 'Curitiba', 300),
(4, '30150000', 'Lagoa', 'MG', 'Belo Horizonte', 400),
(4, '73150000', 'Passo Fundo', 'GO', 'Brasilia', 600),
(5, '40010010', 'Jardim', 'BA', 'Salvador', 500);
    
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
	(1, 2, 900, 'Leste'),
	(2, 2, 820, 'Oeste'),
	(1, 3, 720, 'Sul'),
	(2, 3, 900, 'Leste'),    
	(1, 4, 840, 'Norte'),
	(2, 4, 820, 'Sul'),
	(1, 5, 720, 'Leste'),
	(2, 5, 630, 'Norte'),
	(1, 6, 890, 'Sul'),
	(2, 6, 940, 'Leste');
    
SELECT * FROM quadrante
ORDER BY fkLocal;


CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    fkQuadrante INT,
    fkLocal INT,
    numero_serie VARCHAR(45),
    FOREIGN KEY (fkQuadrante, fkLocal) REFERENCES quadrante (idQuadrante, fkLocal)
);

INSERT INTO sensor  (fkQuadrante, fkLocal, numero_serie)
VALUES 
	(1, 1, 'Sensor SP-Norte'),
	(2, 1, 'Sensor SP-Sul'),
	(1, 2, 'Sensor RJ-Leste'),
	(2, 2, 'Sensor RJ-Oeste'),
	(1, 3, 'Sensor SP-Sul'),
	(2, 3, 'Sensor SP-Norte'),    
	(1, 4, 'Sensor RJ-Leste'),
	(2, 4, 'Sensor RJ-Norte'),
	(1, 5, 'Sensor SP-Sul'),
	(2, 5, 'Sensor SP-Norte'),
	(1, 6, 'Sensor RJ-Sul'),
	(2, 6, 'Sensor RJ-Leste');
    
SELECT * FROM sensor;


CREATE TABLE dados (
	idDados INT PRIMARY KEY AUTO_INCREMENT,
    potenciaAtual INT,
    horaData TIMESTAMP default current_timestamp,
    fkSensor INT,
	FOREIGN KEY (fkSensor) REFERENCES sensor (idSensor)
);

SELECT * FROM dados;

SELECT * FROM usuario;
SELECT * FROM empresa;

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