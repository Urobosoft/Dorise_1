<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mis Mascotas</title>
        <link rel="stylesheet" type="text/css" href="perfil.css">
    </head>
    <body>
        <header>
            <nav>
                <ul>
                    <li><a href="Principal.html">Inicio</a></li>
                    <li><a href="MiPerfil.jsp">Mi Perfil</a></li>
                    <li><a href="RegistrarMascota.html">Registrar Mascota</a></li>
                    <li><a href="#">Contactos</a></li>
                    <li><a href="logout.jsp">Cerrar sesión</a></li>
                </ul>
            </nav>
        </header>
        <main>
            <h1>Mis Mascotas</h1>
            <div id="container">
                <div id="mascotas">
                    <%@page import="java.sql.*, java.io.*, basesita.conexionsita"%>
                    <%
                        HttpSession sesion = request.getSession();
                        Object userIdObj = sesion.getAttribute("user_id");
                        int userid = Integer.parseInt(userIdObj.toString());
                        Connection con = null;
                        CallableStatement comandito = null;
                        conexionsita conecta = new conexionsita();
                        con = conecta.conectar();
                        String queryString = "call desplegarAnimal(?)";
                        comandito = con.prepareCall(queryString);
                        comandito.setInt(1, userid);
                        ResultSet rs = comandito.executeQuery();
                    %>
                    <div class='tabla-mascotas'>
                        <table>
                            <tr>
                                <th>Nombre</th>
                                <th>Edad</th>
                                <th>Inicio Periodo</th>
                                <th>Fin Periodo</th>
                                <th>Especie</th>
                                <th>Raza</th>
                                <th>Sexo</th>
                            </tr>
                            <% while (rs.next()) {%>
                            <tr>
                                <td><%= rs.getString("Nombre")%></td>
                                <td><%= rs.getString("Edad")%></td>
                                <td><%= rs.getString("InicioPeriodo")%></td>
                                <td><%= rs.getString("FinPeriodo")%></td>
                                <td><%= rs.getString("Especie")%></td>
                                <td><%= rs.getString("Raza")%></td>
                                <td><%= rs.getString("Sexo")%></td>
                                <td>
                                    <form method="POST" action="EliminarMascota.jsp">
                                        <input type="hidden" name="idMascota" value="<%= rs.getString("idMascota")%>">
                                        <button type="submit">Eliminar</button>
                                    </form>
                                </td>
                                <td>
                                    <form method="POST" action="EditarMascota.jsp">
                                        <input type="hidden" name="idMascota" value="<%= rs.getString("idMascota")%>">
                                        <button type="submit">Editar</button>
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                        </table>
                    </div>
                    <%
                        con.close();
                    %> 
                </div>
            </div>
        </main>
    </body>
</html>
