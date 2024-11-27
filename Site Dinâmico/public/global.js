function carregar() {
    let idEmpresa = 1;

    fetch(`/empresas/buscarInfosRegiao/${idEmpresa}`)
    .then((res) => {
        res.json()
        .then((resposta) => {
            var options = `<option value="#" selected>ESTADOS</option>`;
            resposta.forEach((elemento) => {
                options += `<option value="${elemento.estado}">${elemento.estado}</option>`;
            })

            var options2 = `<option value="#" selected>CIDADES</option>`;
            resposta.forEach((elemento) => {
                options2 += `<option value="${elemento.cidade}">${elemento.cidade}</option>`;
            })

            slc_estados.innerHTML = options;
            slc_cidades.innerHTML = options2;
        })
    })
    .catch(function (resposta) {
        console.log(`#ERRO: ${resposta}`);
        // finalizarAguardar();
      });

}

function teste() {
    let idEmpresa = 1;

    fetch(`/empresas/buscarInfosQuadrante/${idEmpresa}`)
    .then((res) => {
        res.json()
        .then((resposta) => {
            var options = `<option value="#" selected>QUADRANTES</option>`;
            resposta.forEach((elemento) => {
                options += `<option value="${elemento.Quadrante}">${elemento.Quadrante}</option>`;
            })


            slc_quadrantes.innerHTML = options;
        })
    })
    .catch(function (resposta) {
        console.log(`#ERRO: ${resposta}`);
        // finalizarAguardar();
      });
}

function validar(){
    
}