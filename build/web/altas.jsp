<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function mensaje() {
                alert("registro dado de alta");
            }
        </script>    
    </head>
    <body>
        <%@page import="java.sql.*, basesita.conexionsita"%>
        <%
            String nombre = request.getParameter("nombre");
            String contrasenia = request.getParameter("contrasenia");
            String sexo = request.getParameter("sexo");
            String fecha = request.getParameter("fecha");
            String correo = request.getParameter("correo");
            String cel = request.getParameter("cel");
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            conexionsita conecta = new conexionsita();
            try {
                con = conecta.conectar();
                String consulta = "SELECT * FROM usuarios WHERE correo_electronico=? OR telefono_celular=?";
                pst = con.prepareStatement(consulta);
                pst.setString(1, correo);
                pst.setString(2, cel);
                rs = pst.executeQuery();
                if (rs.next()) {
                    out.println("<h2>El correo electrónico y/o número de celular ya están en uso. Por favor, ingrese otros datos.</h2>");
                    out.println("<button onclick=\"window.location.href='altas.html'\">Regresar</button>");
                } else {
                    consulta = "INSERT INTO usuarios (nombre, contrasenia, sexo, fecha_nacimiento, correo_electronico, telefono_celular)"
                    + " VALUES (?, ?, ?, ?, ?, ?)";
                    pst = con.prepareStatement(consulta, Statement.RETURN_GENERATED_KEYS);
                    pst.setString(1, nombre);
                    pst.setString(2, contrasenia);
                    pst.setString(3, sexo);
                    pst.setString(4, fecha);
                    pst.setString(5, correo);
                    pst.setString(6, cel);
                    pst.executeUpdate();
                    rs = pst.getGeneratedKeys();
                    if (rs.next()) {
                        int idUsuario = rs.getInt(1);
                        HttpSession sesion = request.getSession(true);
                        sesion.setAttribute("user_id", idUsuario);
                        sesion.setAttribute("user_name", nombre);
                        sesion.setAttribute("user_mail", correo);
                        sesion.setAttribute("user_sex", sexo);
                        sesion.setAttribute("user_date", fecha);
                        sesion.setAttribute("user_phone", cel);
                        response.sendRedirect("Principal.jsp");
                    } else {
                        out.println("<h2>Error al insertar el registro.</h2>");
                    }
                }
            } catch (SQLException e) {
                out.println("<h2>Error al insertar el registro: " + e.getMessage() + "</h2>");
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (pst != null) {
                        pst.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                } catch (SQLException e) {
                    out.println("<h2>Error al cerrar la conexión: " + e.getMessage() + "</h2>");
                    e.printStackTrace();
                }
            }
        %>
    </body>
</html>
