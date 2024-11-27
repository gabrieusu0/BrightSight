var database = require("../database/config");

function buscarInfosRegiao(id) {
  var instrucaoSql = `SELECT local_sensor.estado, local_sensor.cidade FROM empresa JOIN local_sensor ON fkEmpresa = idEmpresa WHERE idEmpresa = ${id};`;

  return database.executar(instrucaoSql);
}

function buscarInfosQuadrante(id) {
  var instrucaoSql = `SELECT 
	quadrante.posicao as 'Quadrante'
FROM quadrante JOIN local_sensor
	ON quadrante.fkLocal = local_sensor.idLocal
JOIN empresa
	ON local_sensor.fkEmpresa = empresa.idEmpresa
WHERE idEmpresa = ${id};`;

  return database.executar(instrucaoSql);
}


function buscarQuadranteSulPR() {
  var instrucaoSql = `
  SELECT 
	ROUND((SUM(dados.potenciaAtual) / 180), 0) AS 'Media', -- 30 DIAS * 6H = 1 QUADRANTE (180)    |     VEZES 2 (Pois são dois quadrantes nesse local)
    sensor.numero_serie as 'Nome'
FROM empresa
JOIN local_sensor
    ON empresa.idEmpresa = local_sensor.fkEmpresa
JOIN quadrante
    ON local_sensor.idLocal = quadrante.fkLocal
JOIN sensor
    ON quadrante.idQuadrante = sensor.fkQuadrante
JOIN dados
    ON sensor.idSensor = dados.fkSensor
WHERE empresa.nome = 'SolarTech' 
  AND local_sensor.cidade = 'Curitiba'
  AND sensor.idSensor = 2;  
  `;

  return database.executar(instrucaoSql);
}



function buscarPorId(id) {
  var instrucaoSql = `SELECT * FROM empresa WHERE id = ${id}`;

  return database.executar(instrucaoSql);
}

function listar() {
  var instrucaoSql = `SELECT idEmpresa, codigoVerificacao FROM empresa`;

  return database.executar(instrucaoSql);
}

function buscarPorCnpj(cnpj) {
  var instrucaoSql = `SELECT * FROM empresa WHERE cnpj = '${cnpj}'`;

  return database.executar(instrucaoSql);
}

function cadastrar(razaoSocial, cnpj) {
  var instrucaoSql = `INSERT INTO empresa (razao_social, cnpj) VALUES ('${razaoSocial}', '${cnpj}')`;

  return database.executar(instrucaoSql);
}

function buscarFuncionarioPorEmpresa(empresaId) {

  var instrucaoSql = `SELECT * FROM usuario WHERE fkEmpresa = ${empresaId}`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

module.exports = { buscarPorCnpj, buscarPorId, cadastrar, listar, buscarInfosRegiao, buscarFuncionarioPorEmpresa, buscarInfosQuadrante, buscarQuadranteSulPR};
