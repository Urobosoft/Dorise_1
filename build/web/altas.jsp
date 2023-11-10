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
            CallableStatement comandito = null;
            ResultSet rs = null;
            conexionsita conecta = new conexionsita();
            try {
                con = conecta.conectar();
                String consulta = "SELECT * FROM usuarios WHERE correo_electronico=? OR telefono_celular=?";
                PreparedStatement pst = con.prepareStatement(consulta);
                pst.setString(1, correo);
                pst.setString(2, cel);
                rs = pst.executeQuery();
                if (rs.next()) {
                    out.println("<h2>El correo electrónico y/o número de celular ya están en uso. Por favor, ingrese otros datos.</h2>");
                    out.println("<button onclick=\"window.location.href='altas.html'\">Regresar</button>");
                } else {
                    comandito = con.prepareCall("{ call agregar(?, ?, ?, ?, ?, ?, ?) }");
                    comandito.setString(1, nombre);
                    comandito.setString(2, contrasenia);
                    comandito.setString(3, sexo);
                    comandito.setString(4, fecha);
                    comandito.setString(5, correo);
                    comandito.setString(6, cel);
                    comandito.registerOutParameter(7, Types.INTEGER);
                    comandito.executeUpdate();
                    int idGenerado = comandito.getInt(7);
                    Statement stmt = con.createStatement();
                    ResultSet rs2 = stmt.executeQuery("SELECT LAST_INSERT_ID()");
                    if (rs2.next()) {
                        int idUsuario = rs2.getInt(1);
                    }
                    HttpSession sesion = request.getSession(true);
                    sesion.setAttribute("user_id", idGenerado);
                    sesion.setAttribute("user_name", nombre);
                    sesion.setAttribute("user_mail", correo);
                    sesion.setAttribute("user_sex", sexo);
                    sesion.setAttribute("user_date", fecha);
                    sesion.setAttribute("user_phone", cel);
                    out.println("<h2>Registro insertado correctamente</h2>");
                    response.sendRedirect("Principal.jsp");
                }
            } catch (SQLException e) {
                out.println("<h2>Error al insertar el registro: " + e.getMessage() + "</h2>");
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (comandito != null) {
                        comandito.close();
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
