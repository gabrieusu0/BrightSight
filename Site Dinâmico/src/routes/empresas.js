var express = require("express");
var router = express.Router();

var empresaController = require("../controllers/empresaController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    empresaController.cadastrar(req, res);
})

router.get("/buscar", function (req, res) {
    empresaController.buscarPorCnpj(req, res);
});

router.get("/buscar/:id", function (req, res) {
  empresaController.buscarPorId(req, res);
});

router.get("/listar", function (req, res) {
  empresaController.listar(req, res);
});
 
router.get("/buscarInfosRegiao/:id", function (req, res) {
  empresaController.buscarInfosRegiao(req, res);
});

router.get("/buscarInfosQuadrante/:id", function (req, res) {
  empresaController.buscarInfosQuadrante(req, res);
});

router.get("/buscarQuadranteSulPR", function (req, res) {
  empresaController.buscarQuadranteSulPR(req, res);
});

router.get("/buscarQuadranteNortePR", function (req, res) {
  empresaController.buscarQuadranteNortePR(req, res);
});

router.get("/buscarQuadranteLesteMG", function (req, res) {
  empresaController.buscarQuadranteLesteMG(req, res);
});

router.get("/buscarQuadranteOesteMG", function (req, res) {
  empresaController.buscarQuadranteOesteMG(req, res);
});

router.post("/buscarCidadeMesmo", function (req, res) {
  empresaController.buscarCidade(req, res);
});

router.post("/buscarQuadrantes", function (req, res) {
  empresaController.buscarQuadrantes(req, res);
});

router.post("/primeiraSemana", function (req, res) {
  empresaController.buscarPrimeiraSemana(req, res);
});

router.post("/segundaSemana", function (req, res) {
  empresaController.buscarSegundaSemana(req, res);
});

router.post("/terceiraSemana", function (req, res) {
  empresaController.buscarTerceiraSemana(req, res);
});

router.post("/quartaSemana", function (req, res) {
  empresaController.buscarQuartaSemana(req, res);
});


module.exports = router;