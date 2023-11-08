<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@page import="java.sql.*, basesita.conexionsita"%>
        <%
            try{
            int idAdopcion = Integer.parseInt(request.getParameter("idAdopcion"));
            Connection con = null;
            CallableStatement comandito = null;
            conexionsita conecta = new conexionsita();
            con = conecta.conectar();
            comandito = con.prepareCall("call EliminarAdopcion(?)");
            comandito.setInt(1, idAdopcion);
            comandito.executeQuery();
            response.sendRedirect("Principal.jsp");
            }catch(SQLException e){
                out.println("<h2>Error al eliminar el registro: " + e.getMessage() + "</h2>");
                e.printStackTrace();
            }
        %>
    </body>
</html>
