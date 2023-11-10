<%@ page import="java.sql.*, basesita.conexionsita" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            try {
                Connection con = null;
                CallableStatement comandito = null;
                conexionsita conecta = new conexionsita();
                con = conecta.conectar();
                int mascotaid = Integer.parseInt(request.getParameter("idMas"));
                String name = request.getParameter("nom");
                String edad = request.getParameter("edad");
                String sexo = request.getParameter("sexo");
                String inicioP = request.getParameter("InicioP");
                String finP = request.getParameter("FinP");
                String queryString = "call EditarMascota(?,?,?,?,?,?)";
                comandito = con.prepareCall(queryString);
                comandito.setInt(1, mascotaid);
                comandito.setString(2, name);
                comandito.setString(3, edad);
                comandito.setString(4, sexo);
                if (inicioP == null || inicioP.isEmpty()) {
                    comandito.setNull(5, Types.DATE);
                } else {
                    comandito.setDate(5, java.sql.Date.valueOf(inicioP));
                }
                if (finP == null || finP.isEmpty()) {
                    comandito.setNull(6, Types.DATE);
                } else {
                    comandito.setDate(6, java.sql.Date.valueOf(finP));
                }
                comandito.executeUpdate();
            } catch (SQLException e) {
                out.println("<h2>Error al cambiar el registro: " + e.getMessage() + "</h2>");
                e.printStackTrace();
            }
            response.sendRedirect("Principal.jsp");
        %>
    </body>
</html>
