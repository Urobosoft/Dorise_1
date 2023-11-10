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
            function validarEdad(){
                var edad = document.getElementById("edad").value.trim();
                var sexo = document.getElementById("sexo").value.trim();
                var especie = document.getElementById("especie").value.trim();
                if(isNaN(sexo)){
                    alert("La edad debe ser un número");
                    return false;
                }
                else{
                if(especie === "Perro"){
                    if(sexo === "Macho"){
                        if(edad > 8 || edad < 1){
                            alert("La edad debe ser de mínimo 1 año y máximo 8");
                            return false;
                        }else
                            return true;
                    }else
                         if(edad > 7 || edad < 1){
                            alert("La edad debe ser de mínimo 1 año y máximo 7");
                            return false;
                        }else
                            return true;
                    }else
                    if(sexo === "Macho"){
                        if(edad > 7 || edad < 1){
                            alert("La edad debe ser de mínimo 1 año y máximo 7");
                            return false;
                        }else
                            return true;
                    }else
                         if(edad > 6 || edad < 1){
                            alert("La edad debe ser de mínimo 1 año y máximo 6");
                            return false;
                        }else
                            return true;
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
            <form onsubmit="return validarEdad()">
                <table border="1" width="250" align="center">
                    <tr>
                        <td>Nombre:</td>
                        <td><input type="text" name="nom" value="<%=rs.getString(2)%>"></td>
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
                    <input type="submit" name="btngrabar" value="EditarUsuario">
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
