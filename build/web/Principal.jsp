
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<head>
    <meta charset="UTF-8">
    <title>Doris - Muevete con ingenio</title>
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
        <h1>Encuentra perros compatibles para la reproducción</h1>
        <br>
        <section>
            <%@page import="java.sql.*, basesita.conexionsita"%>
            <%
                try {
                    HttpSession sesion = request.getSession();
                    Object userIdObj = sesion.getAttribute("user_id");
                    int userId = Integer.parseInt(userIdObj.toString());
                    Connection con = null;
                    conexionsita conecta = new conexionsita();
                    con = conecta.conectar();
                    CallableStatement comandito = null;
                    comandito = con.prepareCall("{ call buscarCruza(?) }");
                    comandito.setInt(1, userId);
                    ResultSet rs = comandito.executeQuery();
                    if (rs.next()) {
            %>
            <table class="mascota">
                <tr>
                    <th>Especie</th>
                    <th>Raza</th>
                    <th>Edad</th>
                    <th>Sexo</th>
                    <th>Nombre</th>
                    <th>Dueño</th>
                    <th>Localidad</th>
                </tr>
                <%
                    do {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("Especie") + "</td>");
                        out.println("<td>" + rs.getString("Raza") + "</td>");
                        out.println("<td>" + rs.getInt("Edad") + "</td>");
                        out.println("<td>" + rs.getString("sexo_mascota") + "</td>");
                        out.println("<td>" + rs.getString("nombre_mascota") + "</td>");
                        out.println("<td>" + rs.getString("nombre_usuario") + "</td>");
                        out.println("<td>" + rs.getString("Municipio") + "</td>");
                        out.println("</tr>");
                    } while (rs.next());
                %>
            </table>
            <%
            } else {
            %>
            <p>No se encontraron perros compatibles para la reproducción.</p>
            <%
                    }
                } catch (SQLException e) {
                    out.println("Error: " + e.getMessage());
                }
            %>

        </section>
    </main>
    <footer>
        <p>Doris - Todos los derechos reservados &copy;2023</p>
    </footer>
</body>
</html>