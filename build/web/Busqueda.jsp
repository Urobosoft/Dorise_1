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
            int userid = Integer.parseInt(userIdObj.toString());
            Connection con = null;
            CallableStatement comandito = null;
            conexionsita conecta = new conexionsita();
            con = conecta.conectar();
            String queryString = "call buscarCruza(?)";
            comandito = con.prepareCall(queryString);
            comandito.setInt(1, userid);
            ResultSet rs = comandito.executeQuery();
            while (rs.next()) {
                String nombre = rs.getString("Nombre");
                int edad = rs.getInt("Edad");
                String especie = rs.getString("Especie");
                String raza = rs.getString("Raza");
        %>
        <table>
            <tr>
                <td><%= rs.getString("Nombre")%></td>
                <td><%= rs.getString("Edad")%></td>
                <td><%= rs.getString("Especie")%></td>
                <td><%= rs.getString("Raza")%></td>
            </tr>
            <%
                }
                con.close();
                comandito.close();
                rs.close();
            %>
        </table>
    </body>
</html>
