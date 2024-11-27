function carregar() {
    let idEmpresa = 1;

    fetch(`/empresas/buscarInfosRegiao/${idEmpresa}`)
    .then((res) => {
        res.json()
        .then((listaElelementos) => {
            var options = `<option value="#" selected>ESTADOS</option>`;
            listaElelementos.forEach((elemento) => {
                options += `<option value="${elemento.estado}">${elemento.estado}</option>`;
            })

            var options2 = `<option value="#" selected>CIDADES</option>`;
            listaElelementos.forEach((elemento) => {
                options2 += `<option value="${elemento.cidade}">${elemento.cidade}</option>`;
            })

            slc_estados.innerHTML = options;
            slc_cidades.innerHTML = options2;
        })
    })
}

function validar(){
    
}