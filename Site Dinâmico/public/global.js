function carregar() {
    var idEmpresa = sessionStorage.ID_EMPRESA;

    fetch(`/empresas/buscarInfosRegiao/${idEmpresa}`)
    .then((res) => {
        res.json()
        .then((resposta) => {
            var options = `<option disabled value="#" selected>ESTADOS</option>`;
            resposta.forEach((elemento) => {
                options += `<option value="${elemento.estado}">${elemento.estado}</option>`;
            })

            slc_estados.innerHTML = options;
            slc_cidades.disabled = true;
            slc_quadrantes.disabled = true;
        })
    })
    .catch(function (resposta) {
        console.log(`#ERRO: ${resposta}`);
        // finalizarAguardar();
      });

}

// function teste() {
//     var idEmpresa = sessionStorage.ID_EMPRESA;

//     fetch(`/empresas/buscarInfosQuadrante/${idEmpresa}`)
//     .then((res) => {
//         res.json()
//         .then((resposta) => {
//             var options = `<option value="#" selected>QUADRANTES</option>`;
//             resposta.forEach((elemento) => {
//                 options += `<option value="${elemento.Quadrante}">${elemento.Quadrante}</option>`;
//             })


//             slc_quadrantes.innerHTML = options;
//         })
//     })
//     .catch(function (resposta) {
//         console.log(`#ERRO: ${resposta}`);
//       });
// }

function buscarCidade() {
    var estadoDash = document.getElementById("slc_estados").value;

    sessionStorage.setItem("estadoMesmo", estadoDash);

    if (estadoDash != "#") {
        console.log(`Estado selecionado: ${estadoDash}`);

        // Faz o fetch enviando o estado no corpo da requisição
        fetch(`/empresas/buscarCidadeMesmo`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                estadoServer: estadoDash, // Envia o estado selecionado
            }),
        })
            .then((resposta) => {
                if (resposta.ok) {
                    return resposta.json();
                } else {
                    console.log("Erro ao buscar cidades.");
                }
            })
            .then((cidades) => {
                console.log("Cidades retornadas:", cidades);

                var options = `<option disabled value="#" selected>CIDADES</option>`;
                cidades.forEach((cidade) => {
                    options += `<option value="${cidade.cidade}">${cidade.cidade}</option>`;
                });
                slc_cidades.innerHTML = options;
                slc_cidades.disabled = false; 
            })
            .catch((erro) => {
                console.error("Erro no fetch:", erro);
            });
    }
}

function buscarQuadrantes() {
    var cidadeSelecionada = document.getElementById("slc_cidades").value;

    // Verifica se a cidade foi selecionada
    if (cidadeSelecionada != "#") {
        console.log(`Cidade: ${cidadeSelecionada}`);

        // Faz o fetch para buscar os quadrantes da cidade
        fetch(`/empresas/buscarQuadrantes`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                cidadeServer: cidadeSelecionada, // Envia a cidade selecionada
            }),
        })
            .then((resposta) => {
                if (resposta.ok) {
                    return resposta.json();
                } else {
                    console.log("Erro ao buscar quadrantes.");
                }
            })
            .then((quadrantes) => {
                console.log("Quadrantes:", quadrantes);

                var options = `<option disabled value="#" selected>QUADRANTES</option>`;
                quadrantes.forEach((quadrante) => {
                    options += `<option value="${quadrante.quadrante}">${quadrante.quadrante}</option>`;
                });

                slc_quadrantes.innerHTML = options;
                slc_quadrantes.disabled = false; 

            })
            .catch((erro) => {
                console.error("Erro no fetch:", erro);
            });
    } 
}
