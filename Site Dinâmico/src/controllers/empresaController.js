var empresaModel = require("../models/empresaModel");

function buscarInfosRegiao(req, res){
  var idEmpresa = req.params.id;

  empresaModel.buscarInfosRegiao(idEmpresa)
  .then(function (resposta){
    res.status(200).json(resposta);
  })
}

function buscarInfosQuadrante(req, res){
  var idEmpresa = req.params.id;

  empresaModel.buscarInfosQuadrante(idEmpresa)
  .then(function (resposta){
    res.status(200).json(resposta);
  })
}

function buscarQuadranteSulPR(req, res){

  empresaModel.buscarQuadranteSulPR()
  .then(function (resposta){
    res.status(200).json(resposta);
  })
}

function buscarQuadranteNortePR(req, res){

  empresaModel.buscarQuadranteNortePR()
  .then(function (resposta){
    res.status(200).json(resposta);
  })
}

function buscarQuadranteOesteMG(req, res){

  empresaModel.buscarQuadranteOesteMG()
  .then(function (resposta){
    res.status(200).json(resposta);
  })
}

function buscarQuadranteLesteMG(req, res){

  empresaModel.buscarQuadranteLesteMG()
  .then(function (resposta){
    res.status(200).json(resposta);
  })
}


function buscarPorCnpj(req, res) {
  var cnpj = req.query.cnpj;

  empresaModel.buscarPorCnpj(cnpj).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function listar(req, res) {
  empresaModel.listar().then((resultado) => {
    res.status(200).json(resultado);
  });
}

function buscarPorId(req, res) {
  var id = req.params.id;

  empresaModel.buscarPorId(id).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function cadastrar(req, res) {
  var cnpj = req.body.cnpj;
  var razaoSocial = req.body.razaoSocial;

  empresaModel.buscarPorCnpj(cnpj).then((resultado) => {
    if (resultado.length > 0) {
      res
        .status(401)
        .json({ mensagem: `a empresa com o cnpj ${cnpj} já existe` });
    } else {
      empresaModel.cadastrar(razaoSocial, cnpj).then((resultado) => {
        res.status(201).json(resultado);
      });
    }
  });
}

function buscarQuadrantes(req, res) {
  var idCidade = req.body.cidadeServer;

  if (idCidade == undefined) {
      res.status(400).send("Seu idCidade está undefined!");
      return;
  }

  empresaModel.buscarQuadrantes(idCidade)
      .then(function (resposta) {
          if (resposta.length > 0) {
              res.status(200).json(resposta); 
          } else {
              res.status(404).send("Nenhum quadrante encontrado para esta cidade.");
          }
      })
}

function buscarCidade(req, res) {
  var idEstado = req.body.estadoServer;

  if (idEstado == undefined) {
      res.status(400).send("Seu idEstado está undefined!");
      return;
  }

  empresaModel.buscarCidade(idEstado)
      .then(function (resposta) {
          if (resposta.length > 0) {
              res.status(200).json(resposta); 
          } else {
              res.status(404).send("Nenhuma cidade encontrada para este estado.");
          }
      })
}

module.exports = {
  buscarPorCnpj,
  buscarPorId,
  cadastrar,
  listar,
  buscarInfosRegiao,
  buscarInfosQuadrante,
  buscarQuadranteSulPR,
  buscarQuadranteNortePR,
  buscarQuadranteOesteMG,
  buscarQuadranteLesteMG,
  buscarCidade,
  buscarQuadrantes
};
