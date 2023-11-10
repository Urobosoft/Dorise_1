<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mis Mascotas</title>
            <link rel="stylesheet" href="princistyle.css"type="text/css">

    </head>
    <body>
        <header id="header">
        <div class="main">
            <nav class="nav">
                <div class="menu"></div>
                <ul class="menulist">
                    <li class="active"><a href="Principal.jsp"><i class="fa fa-home"></i>Home</a></li>
                    <li><a href="#"> Perfil </i></a>
                        <div class="sub-menu">
                            <ul>
                                <li><a href="MiPerfil.jsp">Ver perfil</a></li>
                                <li><a href="RegistrarMascota.html">Registrar mascota</a></li>
                                <li><a href="Registro_Dir.html">Registrar Dirección</a></li>
                            </ul>
                        </div>
                    </li>
                    <li><a href="#">Principal </a>
                        <div class="sub-menu">
                            <ul class=>
                                <li><a href="Mis_Mascotas.jsp">Mascotas</a></li>
                            </ul>
                        </div>
                    </li>

                    <li><a href="#"></i> Mascotas </i></a>
                        <div class="sub-menu">
                            <ul>
                                <li><a href="RAdopciones.jsp">Adopción</a></li>
                                <li><a href="Tips.html">Tips</a></li>
                                <li><a href="Mis_Mascotas.jsp">Mis mascotas</a></li>

                            </ul>
                        </div>
                    </li>
                    <li><a href="#">Salud</a>
                        <div class="sub-menu">
                            <ul>
                                <li><a href="#">Veterinario</a></li>
                                <li><a href="Recomendaciones.html">Recomendaciones</a></li>
                                <li><a href="Enfermedades.html">Enfermedades</a></li>
                                <li><a href="Cuidados.html">Cuidados</a></li>
                            </ul>
                        </div>
                    </li>
                    <li><a href="#">Acerca de nosotros</a></li>
                    <li><a href="logout.jsp">Cerrar sesión</a></li>
                </ul>
                <div class="bars__menu">
                    <span class="line1__bars-menu"></span>
                    <span class="line2__bars-menu"></span>
                    <span class="line3__bars-menu"></span>
                </div>
            </nav>
        </div>
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
                                <th>Acciones</th>
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
                                        <input type="hidden" name="idMascota" value="<%= rs.getInt("idMascota")%>">
                                        <button type="submit">Eliminar</button>
                                    </form>
                                    <form method="POST" action="EditarMascota.jsp">
                                        <input type="hidden" name="idMascota" value="<%= rs.getInt("idMascota")%>">
                                        <button type="submit">Editar</button>
                                    </form>
                                    <form method="POST" action="Adopcion.jsp">
                                        <input type="hidden" name="idMascota" value="<%= rs.getInt("idMascota")%>">
                                        <input type="hidden" name="Edad" value="<%= rs.getInt("Edad")%>">
                                        <input type="hidden" name="Nombre" value="<%= rs.getString("Nombre")%>">
                                        <button type="submit">Dar en adopcción</button>
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
