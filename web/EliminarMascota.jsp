<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Mascota eliminada uwu!</h1>
        <%@page import="java.sql.*, basesita.conexionsita"%>
        <%
            try{
            int idMascota = Integer.parseInt(request.getParameter("idMascota"));
            Connection con = null;
            CallableStatement comandito = null;
            conexionsita conecta = new conexionsita();
            con = conecta.conectar();
            comandito = con.prepareCall("call EliminarAnimal(?)");
            comandito.setInt(1, idMascota);
            comandito.executeQuery();
            response.sendRedirect("Principal.jsp");
            }catch(SQLException e){
                out.println("<h2>Error al eliminar el registro: " + e.getMessage() + "</h2>");
                e.printStackTrace();
            }
        %>
    </body>
</html>
