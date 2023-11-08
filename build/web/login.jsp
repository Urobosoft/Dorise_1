<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@page import="java.sql.*, basesita.conexionsita, basesita.sesionsita"%>
        <%
            String usuario = request.getParameter("correo");
            String contrasena = request.getParameter("contrasena");
            if (sesionsita.createSession(request, usuario, contrasena)) {
                response.sendRedirect("Principal.jsp");
            } else {
                out.println("Usuario y/o contraseña incorrectos");
            }
        %>
        <a href="index.html">Regresar xd</a>
    </body>
</html>
