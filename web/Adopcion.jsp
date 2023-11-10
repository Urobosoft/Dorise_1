<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@ page import="java.sql.*, basesita.conexionsita" %>
        <%
            try {
                HttpSession sesion = request.getSession();
                Object userIdObj = sesion.getAttribute("user_id");
                int userId = Integer.parseInt(userIdObj.toString());
                int idMascota = Integer.parseInt(request.getParameter("idMascota"));
                String NombreMascota = (request.getParameter("Nombre"));
                int EdadMascota = Integer.parseInt(request.getParameter("Edad"));
                Connection con = null;
                CallableStatement comandito = null;
                conexionsita conecta = new conexionsita();
                con = conecta.conectar();
                String query = "SELECT Municipio FROM Direccion " +
                               "INNER JOIN Lista_Direccion ON Direccion.idDireccion = Lista_Direccion.idDireccion " +
                               "WHERE Lista_Direccion.idUsuario = ?";
                PreparedStatement stmt = con.prepareStatement(query);
                stmt.setInt(1, userId);
                ResultSet rs = stmt.executeQuery();
                String municipio = "";
                if (rs.next()) {
                    municipio = rs.getString("Municipio");
                }
                query = "SELECT COUNT(*) AS count FROM usuarios WHERE id = ?";
                stmt = con.prepareStatement(query);
                stmt.setInt(1, userId);
                rs = stmt.executeQuery();
                String procedencia = "";
                if (rs.next()) {
                    procedencia = "Usuario";
                }
                else
                    procedencia = "Refugio";
                comandito = con.prepareCall("CALL agregarAdopcion(?, ?, ?, ?, ?, ?)");
                comandito.setInt(1, idMascota);
                comandito.setInt(2, userId);
                comandito.setString(3, NombreMascota);
                comandito.setInt(4, EdadMascota);
                comandito.setString(5, procedencia);
                comandito.setString(6, municipio);
                comandito.executeUpdate();
                rs.close();
                stmt.close();
                comandito.close();
                con.close();
                response.sendRedirect("Principal.jsp");
            } catch (SQLException e) {
                out.println("<h2>Error al dar la opción: " + e.getMessage() + "</h2>");
                e.printStackTrace();
            }
        %>
    </body>
</html>
