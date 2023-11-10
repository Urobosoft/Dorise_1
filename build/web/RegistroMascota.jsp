<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Formulario de registro de animales</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="RegistroM.css">
        <script type="text/javascript">
            function validarFormulario() {
                var nombre = document.getElementById("nombre").value;
                var edad = document.getElementById("edad").value;
                var inicioP = document.getElementById("InicioP").value;
                var finP = document.getElementById("FinP").value;
                var especie = document.getElementById("especie").value;
                var raza = document.getElementById("raza").value;
                var sexo = document.querySelector('input[name="sexo"]:checked');
                if (nombre === "") {
                    alert("Por favor, ingrese un nombre.");
                    return false;
                } else
                if (edad === "") {
                    alert("Por favor, seleccione la edad.");
                    return false;
                } else
                if (especie === "") {
                    alert("Por favor, seleccione una especie.");
                    return false;   
                } else
                if (raza === "") {
                    alert("Por favor, seleccione una raza.");
                    return false;
                } else
                if (!sexo) {
                    alert("Por favor, seleccione un sexo.");
                    return false;
                } else
                if (sexo === "Hembra") {
                    if (inicioP === "") {
                        alert("Por favor, seleccione la fecha de inicio del periodo reproductivo.");
                        return false;
                    } else
                    if (finP === "") {
                        alert("Por favor, seleccione la fecha de fin del periodo reproductivo.");
                        return false;
                    } else
                        return true;
                }
            }
            function cargarRazas() {
                var especie = document.getElementById("especie").value;
                var selectRaza = document.getElementById("raza");
                selectRaza.innerHTML = ""; // Limpiar el combo de raza
                if (especie === "Perro") {
                    var razasPerro = [
                        "American Pit Bull Terrier",
                        "Bulldog Frances",
                        "Bulldog Ingles",
                        "Boxer",
                        "Chihuahua",
                        "Cocker Spaniel",
                        "Dálmata",
                        "Doberman",
                        "Labrador Retriever",
                        "Pastor Aleman",
                        "Poodle",
                        "Pug",
                        "Rottweiler",
                        "San Bernardo",
                        "Schnauzer",
                        "Shar Pei",
                        "Terrier Escocés",
                        "Yorkshire Terrier",
                        "Otra"
                    ];
                    for (var i = 0; i < razasPerro.length; i++) {
                        var opcion = document.createElement("option");
                        opcion.value = razasPerro[i];
                        opcion.text = razasPerro[i];
                        selectRaza.appendChild(opcion);
                    }
                } else if (especie === "Gato") {
                    var razasGato = [
                        "Siames",
                        "Persa",
                        "Bengali",
                        "Gato Comun",
                        "Abisinio",
                        "Somali",
                        "Bosque de Noruega",
                        "Sphynx",
                        "Scottish Fold",
                        "Otra"
                    ];
                    for (var i = 0; i < razasGato.length; i++) {
                        var opcion = document.createElement("option");
                        opcion.value = razasGato[i];
                        opcion.text = razasGato[i];
                        selectRaza.appendChild(opcion);
                    }
                }
            }
            function activarPeriodo() {
                var selectedValue = document.querySelector('input[name="sexo"]:checked').value;
                if (selectedValue === "Hembra") {
                    InicioP.disabled = false;
                    FinP.disabled = false;
                } else {
                    InicioP.disabled = true;
                    FinP.disabled = true;
                    InicioP.value = "";
                    FinP.value = "";
                }
            }
        </script>
    </head>
    <body>
        <h1>Formulario de registro de animales</h1>
        <form name="registroAnimal" method="post" action="RegistroM.jsp" onsubmit="return validarFormulario();">
            <label for="nombre">Nombre:</label>
            <input type="text" name="nombre" id="nombre"><br><br>
            <label for="edad">Edad:</label>
            <select name="edad" id="edad">
                <option value="">Seleccione la edad</option>
                <option value="1">1 año</option>
                <option value="2">2 años</option>
                <option value="3">3 años</option>
                <option value="4">4 años</option>
                <option value="5">5 años</option>
                <option value="6">6 años</option>
                <option value="7">7 años</option>
                <option value="8">8 años</option>
                <option value="9">9 años</option>
                <option value="10">10 años</option>
            </select>
            <br><br>
            <label>Sexo:</label>
            <div class="radio-buttons">
                <input type="radio" name="sexo" id="sexo-macho" value="Macho" onchange="activarPeriodo()">
                <label for="sexo-macho"><span class="checkmark"> </span> Macho</label>
                <input type="radio" name="sexo" id="sexo-hembra" value="Hembra" onchange="activarPeriodo()">
                <label for="sexo-hembra"><span class="checkmark"> </span> Hembra</label>
            </div>
            <br><br>
            <label for="fecha">Inicio del periodo reproductivo:</label>
            <input type="date" name="InicioP" id="InicioP" disabled="">
            <br><br>
            <label for="fecha">Fin del periodo reproductivo:</label>
            <input type="date" name="FinP" id="FinP" disabled="">
            <br><br>
            <label for="especie">Especie:</label>
            <select name="especie" id="especie" onchange="cargarRazas()">
                <option value="">Seleccione una opción</option>
                <option value="Perro">Perro</option>
                <option value="Gato">Gato</option>
            </select>
            <br><br>
            <label for="raza">Raza:</label>
            <select name="raza" id="raza"></select>
            <br><br>
            <label>Id del dueño:</label>
            <input type="text" name="idUsuario" value="<%= session.getAttribute("user_id")%>" disabled="">
            <br><br>
            <input type="submit" value="Registrar">
        </form>
    </body>
</html>