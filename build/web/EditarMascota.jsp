<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, basesita.conexionsita" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>JSP Page</title>
        <script>
            function activarPeriodo() {
                var selectedValue = document.querySelector('input[name="sexo"]:checked').value;
                var inicioP = document.getElementById('InicioP');
                var finP = document.getElementById('FinP');
                if (selectedValue === "Hembra") {
                    inicioP.disabled = false;
                    finP.disabled = false;
                } else {
                    inicioP.disabled = true;
                    finP.disabled = true;
                    inicioP.value = "";
                    finP.value = "";
                }
            }
            function validarEdad() {
                var nombre = document.getElementById("nom").value;
                var edad = document.getElementById("edad").value;
                var inicioP = document.getElementById("InicioP").value;
                var finP = document.getElementById("FinP").value;
                var especie = document.getElementById("especie").value;
                var sexo = document.querySelector('input[name="sexo"]:checked');
                var diffTime = Math.abs(new Date(finP) - new Date(inicioP));
                var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

                if (nombre === "") {
                    alert("Por favor, ingrese un nombre.");
                    return false;
                } else if (edad === "") {
                    alert("Por favor, seleccione la edad.");
                    return false;
                } else if (isNaN(edad)) {
                    alert("La edad debe ser un número.");
                    return false;
                } else if (especie === "") {
                    alert("Por favor, seleccione una especie.");
                    return false;
                } else if (!sexo) {
                    alert("Por favor, seleccione un sexo.");
                    return false;
                } else if (sexo.value === "Hembra") {
                    if (inicioP === "") {
                        alert("Por favor, seleccione la fecha de inicio del periodo reproductivo.");
                        return false;
                    } else if (finP === "") {
                        alert("Por favor, seleccione la fecha de fin del periodo reproductivo.");
                        return false;
                    } else if (diffDays < 14 || diffDays > 28) {
                        alert("La diferencia entre la fecha de inicio y la fecha de fin del periodo reproductivo debe ser de entre 2 y 4 semanas.");
                        return false;
                    } else {
                        return true;
                    }
                } else {
                    if (especie === "Perro") {
                        if (sexo.value === "Macho") {
                            if (edad > 8 || edad < 1) {
                                alert("La edad debe ser de mínimo 1 año y máximo 8.");
                                return false;
                            } else {
                                return true;
                            }
                        } else {
                            if (edad > 7 || edad < 1) {
                                alert("La edad debe ser de mínimo 1 año y máximo 7.");
                                return false;
                            } else {
                                return true;
                            }
                        }
                    } else {
                        return true;
                    }
                }
            }
            function desactivarPeriodo() {
                var sexo = document.querySelector('input[name="sexo"]:checked').value;
                var inicioP = document.getElementById('InicioP');
                var finP = document.getElementById('FinP');
                if (sexo === "Macho") {
                    inicioP.disabled = true;
                    finP.disabled = true;
                    inicioP.value = "";
                    finP.value = "";
                }
            }

        </script>
    </head>
    <body onload="desactivarPeriodo()">
        <%
            HttpSession sesion = request.getSession();
            int mascotaid = Integer.parseInt(request.getParameter("idMascota"));
            Connection con = null;
            CallableStatement comandito = null;
            conexionsita conecta = new conexionsita();
            con = conecta.conectar();
            String queryString = "call buscarAnimal(?)";
            comandito = con.prepareCall(queryString);
            comandito.setInt(1, mascotaid);
            ResultSet rs = comandito.executeQuery();
            while (rs.next()) {
        %>
        <div class="tabla-mascotas">
            <form action="EditMascota.jsp" onsubmit="return validarEdad()">
                <table border="1" width="250" align="center">
                    <tr>
                        <td>Id:</td>
                        <td><input type="text" name="idMas" id="idMas" value="<%=rs.getString(1)%>" hidden=""></td>
                    </tr>
                    <tr>
                        <td>Nombre:</td>
                        <td><input type="text" name="nom" id="nom" value="<%=rs.getString(2)%>"></td>
                    </tr>
                    <tr>
                        <td>Edad:</td>
                        <td><input type="text" name="edad" id="edad" value="<%=rs.getString(3)%>"></td>
                    </tr>
                    <tr>
                        <td>Especie:</td>
                        <td><input type="text" name="especie" id="especie" value="<%=rs.getString(6)%>" disabled></td>
                    </tr>
                    <tr>
                        <td>Sexo:</td>
                        <td>
                            <label><input type="radio" name="sexo" id="sexo" value="Macho" <% if ("Macho".equals(rs.getString(8))) {
                                    out.print("checked");
                                } %> onchange="activarPeriodo()"> Macho</label>
                                          <label><input type="radio" name="sexo" id="sexo" value="Hembra" <% if ("Hembra".equals(rs.getString(8)))
                                                  out.print("checked");%> onchange="activarPeriodo()"> Hembra</label>
                        </td>
                    </tr>
                    <tr>
                        <td>Inicio Periodo:</td>
                        <td><input type="date" name="InicioP" id="InicioP" value="<%=rs.getString(4)%>"></td>
                    </tr>
                    <tr>
                        <td>Fin Periodo:</td>
                        <td><input type="date" name="FinP" id="FinP" value="<%=rs.getString(5)%>"></td>
                    </tr>
                    <th colspan="2">
                        <input type="submit" name="btngrabar" value="Editar Mascota">
                    </th>
                </table>
            </form>
        </div>
        <%
            }
            rs.close();
            comandito.close();
            con.close();
        %>
    </body>
</html>
