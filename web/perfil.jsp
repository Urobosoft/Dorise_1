<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil de usuario</title>
    </head>
    <body>
        <%@page import="java.sql.*"%>
        <%
            int idUsuario = Integer.parseInt(session.getAttribute("idUsuario").toString());
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3308/doris?autoReconnect=true&useSSL=false",
                        "root", "n0m3l0");
            } catch (SQLException error) {
                out.print(error.toString());
            }
            String consulta = "SELECT * FROM usuarios WHERE id=?";
            pst = con.prepareStatement(consulta);
            pst.setInt(1, idUsuario);
            rs = pst.executeQuery();
            if (rs.next()) {
                String nombre = rs.getString("nombre");
                String sexo = rs.getString("sexo");
                String fecha = rs.getString("fecha_nacimiento");
                String correo = rs.getString("correo_electronico");
                String cel = rs.getString("telefono_celular");
                
                out.println("<h2>Perfil de usuario</h2>");
                out.println("<p><b>Nombre:</b> " + nombre + "</p>");
                out.println("<p><b>Sexo:</b> " + sexo + "</p>");
                out.println("<p><b>Fecha de nacimiento:</b> " + fecha + "</p>");
                out.println("<p><b>Correo electrónico:</b> " + correo + "</p>");
                out.println("<p><b>Teléfono celular:</b> " + cel + "</p>");
            } else {
                out.println("<h2>No se encontró el usuario</h2>");
            }
            pst.close();
            con.close();
        %>
    </body>
</html>
