<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Adopciones!</title>
        <link rel="stylesheet" href="princistyle.css"type="text/css">
    </head>
    <body>
        <header>
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
        <%@ page import="java.sql.*, basesita.conexionsita" %>
        <%
            HttpSession sesion = request.getSession();
            Object userIdObj = sesion.getAttribute("user_id");
            int userId = Integer.parseInt(userIdObj.toString());
            Connection con = null;
            conexionsita conecta = new conexionsita();
            con = conecta.conectar();
            CallableStatement comandito = null;
            String queryString = "call desplegarMisAdopciones(?)";
            comandito = con.prepareCall(queryString);
            comandito.setInt(1, userId);
            ResultSet rs = comandito.executeQuery();
        %>
        <h1>Mis Mascotas en Adopción:</h1>
        <div class='tabla-misAdopciones'>
            <table>
                <tr>
                    <th>Nombre</th>
                    <th>Edad</th>
                    <th>Procedencia</th>
                    <th>Municipio</th>
                    <th>Eliminar</th>
                </tr>
                <% while (rs.next()) {%>
                <tr>
                    <td><%= rs.getString("NombreMascota")%></td>
                    <td><%= rs.getString("Edad")%></td>
                    <td><%= rs.getString("Procedencia")%></td>
                    <td><%= rs.getString("Municipio")%></td>
                    <td>
                        <form action="EliminarAdopcion.jsp" method="post" name="EliminarRAdopcion">
                            <input type="hidden" name="idAdopcion" value="<%= rs.getInt("idAdopcion")%>">
                            <button type="submit">Eliminar</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </table>
            <h1>Mascotas en adopción de otrs dueños:</h1>
            <%
                queryString = "call desplegarAdopciones(?)";
                comandito = con.prepareCall(queryString);
                comandito.setInt(1, userId);
                rs = comandito.executeQuery();
            %>
            <table>
                <tr>
                    <th>Nombre</th>
                    <th>Edad</th>
                    <th>Procedencia</th>
                    <th>Municipio</th>
                    <th>Eliminar</th>
                </tr>
                <% while (rs.next()) {%>
                <tr>
                    <td><%= rs.getString("NombreMascota")%></td>
                    <td><%= rs.getString("Edad")%></td>
                    <td><%= rs.getString("Procedencia")%></td>
                    <td><%= rs.getString("Municipio")%></td>
                </tr>
                <% } %>
            </table>

        </div>
        <%
            con.close();
        %> 
    </body>
</html>
