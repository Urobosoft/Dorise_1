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
            HttpSession sesion = request.getSession();
            Object userIdObj = sesion.getAttribute("user_id");
            Connection con = null;
            CallableStatement comandito = null;
            ResultSet rs = null;

            if (userIdObj != null) {
                int userid = Integer.parseInt(userIdObj.toString());
                conexionsita conecta = new conexionsita();
                
                try {
                    con = conecta.conectar();
                    String queryString = "call buscarCruza(?)";
                    comandito = con.prepareCall(queryString);
                    comandito.setInt(1, userid);
                    rs = comandito.executeQuery();
        %>
        <table border="1">
            <tr>
                <th>Nombre</th>
                <th>Edad</th>
                <th>Especie</th>
                <th>Raza</th>
            </tr>
        <% 
                    while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getString("Nombre") %></td>
                <td><%= rs.getInt("Edad") %></td>
                <td><%= rs.getString("Especie") %></td>
                <td><%= rs.getString("Raza") %></td>
            </tr>
        <% 
                    }
                } catch (Exception e) {
                    e.printStackTrace();
        %>
            <tr>
                <td colspan="4">Error al recuperar los datos: <%= e.getMessage() %></td>
            </tr>
        </table>
        <%
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (comandito != null) try { comandito.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            } else {
        %>
                <p>No hay sesión de usuario activa.</p>
        <%
            }
        %>
    </body>
</html>
