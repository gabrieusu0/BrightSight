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

module.exports = {
  buscarPorCnpj,
  buscarPorId,
  cadastrar,
  listar,
  buscarInfosRegiao,
  buscarInfosQuadrante,
  buscarQuadranteSulPR
};
