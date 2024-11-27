var database = require("../database/config");

function buscarInfosRegiao(id) {
  var instrucaoSql = `SELECT local_sensor.estado, local_sensor.cidade FROM empresa JOIN local_sensor ON fkEmpresa = idEmpresa WHERE idEmpresa = ${id};`;

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

module.exports = { buscarPorCnpj, buscarPorId, cadastrar, listar, buscarInfosRegiao, buscarFuncionarioPorEmpresa};
