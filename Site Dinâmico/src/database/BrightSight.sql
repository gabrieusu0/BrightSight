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
	senha VARCHAR(45)
);

INSERT INTO empresa (nome, CNPJ, rua, bairro, cidade, cep, numero, senha) VALUES
	('SolarTech', '12345678000199', 'Rua das Flores', 'Centro', 'São Paulo', '01001000', '100', 'Senha123'),
	('EcoEnergy', '98765432000188', 'Av. Paulista', 'Bela Vista', 'São Paulo', '01310000', '200', 'EcoSenha2024'),
	('GreenPower', '56473829000177', 'Rua Verde', 'Jardim das Águas', 'Curitiba', '80010000', '300', 'Green2024'),
	('EnergiaLimpa', '11223344000166', 'Rua da Luz', 'Alto da Lapa', 'São Paulo', '05050000', '150', 'LuzSegura2024'),
	('SolEnergia', '22334455000155', 'Av. Solar', 'Sol Nascente', 'Belo Horizonte', '30110000', '250', 'SolForte2024');

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

CREATE TABLE teste (
idTeste INT PRIMARY KEY AUTO_INCREMENT,
dados decimal(6,2)
);

select * from teste;

CREATE TABLE dados (
	idDados INT PRIMARY KEY AUTO_INCREMENT,
    potenciaAtual INT,
    horaData TIMESTAMP default current_timestamp,
    fkSensor INT,
	FOREIGN KEY (fkSensor) REFERENCES sensor (idSensor)
);

alter table dados
modify column potenciaAtual decimal;

INSERT INTO dados (potenciaAtual, horaData, fkSensor) VALUES 
	(400, '2024-10-09 10:00:00', 1),
	(600, '2024-10-09 11:00:00', 2),
	(900, '2024-10-09 12:00:00', 3),
	(750, '2024-10-09 13:00:00', 4),
	(680, '2024-10-09 14:00:00', 5),
	(590, '2024-10-09 15:00:00', 6),
	(550, '2024-10-09 16:00:00', 7),
	(460, '2024-10-09 17:00:00', 8),
	(420, '2024-10-09 18:00:00', 9),
	(360, '2024-10-09 19:00:00', 10),
	(280, '2024-10-09 20:00:00', 11),
	(100, '2024-10-09 21:00:00', 12);
    
SELECT * FROM dados;


SELECT * FROM empresa JOIN local_sensor ON FkEmpresa = idEmpresa;

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

