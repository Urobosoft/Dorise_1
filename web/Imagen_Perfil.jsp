<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@page import="java.sql.*, java.io.InputStream, javax.servlet.http.Part, basesita.conexionsita"%>
        <%
            HttpSession sesion = request.getSession();
            Object userIdObj = sesion.getAttribute("user_id");
            int userid = Integer.parseInt(userIdObj.toString());
            Part imagenPart = request.getPart("imagen");
            String nombreImagen = imagenPart.getSubmittedFileName();
            InputStream imagenStream = imagenPart.getInputStream();
            conexionsita conecta = new conexionsita();
            Connection con = conecta.conectar();
            CallableStatement comandito = con.prepareCall("{call insertarImagen(?, ?, ?)}");
            comandito.setInt(1, userid);
            comandito.setString(2, nombreImagen);
            comandito.setBlob(3, imagenStream);
            comandito.executeUpdate();
            comandito.close();
            con.close();
            imagenStream.close();
            response.sendRedirect("MiPerfil.jsp");

        %>
        <a href="MiPerfil.jsp">Regresar</a>
    </body>
</html>
