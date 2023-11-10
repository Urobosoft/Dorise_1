<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= session.getAttribute("user_name")%></title>
        <link rel="stylesheet" type="text/css" href="perfil.css">
        <style>
            img {
                border-radius: 50%;
                width: 100px;
                height: 100px;
            }
        </style>
    </head>
    <body>
        <header>
            <nav>
                <ul>
                    <li><a href="Principal.jsp">Inicio</a></li>
                    <li><a href="MiPerfil.jsp">Mi Perfil</a></li>
                    <li><a href="Mis_Mascotas.jsp">Mis Mascotas</a></li>
                    <li><a href="#">Contactos</a></li>
                    <li><a href="Registro_Dir.html">Agregar Direccion</a></li>
                    <li><a href="logout.jsp">Cerrar sesión</a></li>
                </ul>
            </nav>
        </header>
        <main>
            <div id="container">
                <h1>Mi perfil</h1>
                <img src="data:image/png;base64,${sessionScope.user_image}" onerror="this.src='imagenes/perfil_blanco.jpeg'"/>
                <div id="datos-personales">
                    <h2>Datos personales</h2>
                    <ul>
                        <li><strong>Nombre:</strong><%= session.getAttribute("user_name")%></li>
                        <li><strong>Sexo:</strong> <%= session.getAttribute("user_sex")%></li>
                        <li><strong>Fecha de nacimiento:</strong> <%= session.getAttribute("user_date")%></li>
                        <li><strong>Correo electrónico:</strong> <%= session.getAttribute("user_mail")%></li>
                        <li><strong>Teléfono celular:</strong> <%= session.getAttribute("user_phone")%></li>
                    </ul>
                </div>
                <div id="direcciones">
                    <%@page import="java.sql.*, java.io.*, basesita.conexionsita"%>
                    <%
                        HttpSession sesion = request.getSession();
                        Object userIdObj = sesion.getAttribute("user_id");
                        int userid = Integer.parseInt(userIdObj.toString());
                        Connection con = null;
                        CallableStatement comandito = null;
                        conexionsita conecta = new conexionsita();
                        con = conecta.conectar();
                        String queryString = "call desplegarDir(?)";
                        comandito = con.prepareCall(queryString);
                        comandito.setInt(1, userid);
                        ResultSet rs = comandito.executeQuery();
                        if (rs.next()) {
                    %>
                    <table>
                        <tr>
                            <th>Estado</th>
                            <th>Municipio</th>
                            <th>Colonia</th>
                            <th>CP</th>
                        </tr>
                        <% do {
                        %>
                        <tr>
                            <td><%= rs.getString("Estado")%></td>
                            <td><%= rs.getString("Municipio")%></td>
                            <td><%= rs.getString("Colonia")%></td>
                            <td><%= rs.getString("Codigo_Postal")%></td>
                            <td>
                                <form method="POST" action="EliminarDireccion.jsp">
                                    <input type="hidden" name="idDireccion" value="<%= rs.getString("idDireccion")%>">
                                    <button type="submit">Eliminar</button>
                                </form>
                            </td>
                        </tr>
                        <% } while (rs.next());
                        %>
                    </table>
                    <%} else { %>
                    <p>No hay direcciones registradas.</p>
                    <%} %>


                </div>
                <%
                    rs.close();
                    con.close();
                %> 
            </div>
        </main>
    </body>
</html>
