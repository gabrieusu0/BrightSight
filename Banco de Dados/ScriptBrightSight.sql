create database BrightSight;

use BrightSight;

CREATE TABLE EMPRESA (
	idEmpresa INT auto_increment primary key,
	nome VARCHAR(50),
	CNPJ CHAR(14),
	rua VARCHAR(45),
	bairro VARCHAR(45),
	cidade VARCHAR(45),
	cep CHAR(8),
	numero CHAR(11),
	senha VARCHAR(45)
);

INSERT INTO EMPRESA (nome, CNPJ, rua, bairro, cidade, cep, numero, senha) VALUES
('SolarTech', '12345678000199', 'Rua das Flores', 'Centro', 'São Paulo', '01001000', '100', 'Senha123'),
('EcoEnergy', '98765432000188', 'Av. Paulista', 'Bela Vista', 'São Paulo', '01310000', '200', 'EcoSenha2024'),
('GreenPower', '56473829000177', 'Rua Verde', 'Jardim das Águas', 'Curitiba', '80010000', '300', 'Green2024'),
('EnergiaLimpa', '11223344000166', 'Rua da Luz', 'Alto da Lapa', 'São Paulo', '05050000', '150', 'LuzSegura2024'),
('SolEnergia', '22334455000155', 'Av. Solar', 'Sol Nascente', 'Belo Horizonte', '30110000', '250', 'SolForte2024');

SELECT * FROM EMPRESA;

CREATE TABLE LOCALIDADE (
idLocal INT AUTO_INCREMENT PRIMARY KEY,
FkEmpresa INT,
CepLocal CHAR(8),
constraint fkEmpresaLocal foreign key (fkEmpresa) references EMPRESA(idEmpresa)
);

INSERT INTO LOCALIDADE VALUES
	(1, 1, '12345678'),
    (2, 1, '87654321'),
    (3, 2, '13579753'),
    (4, 2, '24686420'),
    (5, 3, '08642468'),
    (6, 3, '12348765'),
    (7, 4, '43215678'),
    (8, 5, '32145698');
    
SELECT * FROM LOCALIDADE;
    
CREATE TABLE SENSOR (
	idSensor INT AUTO_INCREMENT,
    fkLocal INT,
    constraint fkCompostaSensor primary key (idSensor, fkLocal),
    constraint fkLocalSensor foreign key (fkLocal) references LOCALIDADE(idLocal)
);

INSERT INTO SENSOR VALUES
	(1,1),
    (2,1),
    (3,1),
    (1,2),
    (2,2),
    (3,2),
    (1,3),
    (2,3),
    (3,3),
    (1,4),
    (2,4),
    (3,4),
    (1,5),
    (2,5),
    (3,5);
    
CREATE TABLE DADOS (
	idDados int primary key auto_increment,
	potênciaAtual INT,
	horaData DATETIME,
	fkSensor INT,
	fkLocalDados INT,
	constraint fkSensorDados foreign key (fkSensor) references SENSOR(idSensor),
	constraint fkLocalDados foreign key (fkLocalDados) references SENSOR(fkLocal)
);

INSERT INTO DADOS (potênciaAtual, horaData, fkSensor, fkLocalDados) VALUES
(120, '2024-09-30 08:45:00', 1, 1),
(135, '2024-09-30 09:00:00', 2, 1),
(110, '2024-09-30 09:15:00', 3, 1),
(145, '2024-09-30 09:30:00', 1, 2),
(125, '2024-09-30 09:45:00', 2, 2);

SELECT * FROM EMPRESA JOIN LOCALIDADE ON FkEmpresa = idEmpresa;

SELECT 
    E.nome AS Empresa, 
    L.idLocal AS Localidade, 
    L.CepLocal AS CEP, 
    S.idSensor AS Sensor, 
    D.potênciaAtual AS Potência, 
    D.horaData AS DataHora 
FROM EMPRESA AS E
JOIN LOCALIDADE AS L
ON E.idEmpresa = L.fkEmpresa
JOIN SENSOR AS S 
ON L.idLocal = S.fkLocal
JOIN DADOS AS D
ON S.idSensor = D.fkSensor AND L.idLocal = D.fkLocalDados
WHERE E.idEmpresa = 1;
