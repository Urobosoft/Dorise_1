<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%@page import="java.sql.*, basesita.conexionsita"%>
    <%
        HttpSession sesion = request.getSession();
        String nombre = request.getParameter("nombre");
        Object userIdObj = sesion.getAttribute("user_id");
        int userid = Integer.parseInt(userIdObj.toString());
        String edad = request.getParameter("edad");
        String inicioP = request.getParameter("InicioP");
        String finP = request.getParameter("FinP");
        String especie = request.getParameter("especie");
        String raza = request.getParameter("raza");
        String sexo = request.getParameter("sexo");
        Connection con = null;
        CallableStatement comandito = null;
        ResultSet rs = null;
        conexionsita conecta = new conexionsita();
        con = conecta.conectar();
        try {
            comandito = con.prepareCall("{call agregarAnimal(?,?,?,?,?,?,?,?)}");
            comandito.setString(1, nombre);
            comandito.setInt(2, Integer.parseInt(edad));
            if (inicioP == null || inicioP.isEmpty()) {
                comandito.setNull(3, Types.DATE);
            } else {
                comandito.setDate(3, java.sql.Date.valueOf(inicioP));
            }
            if (finP == null || finP.isEmpty()) {
                comandito.setNull(4, Types.DATE);
            } else {
                comandito.setDate(4, java.sql.Date.valueOf(finP));
            }
            comandito.setString(5, especie);
            comandito.setString(6, raza);
            comandito.setString(7, sexo);
            comandito.setInt(8, userid);
            comandito.executeUpdate();
            out.println("<script>alert('El registro se ha guardado correctamente.')</script>");
            response.sendRedirect("Principal.jsp");
        } catch (Exception e) {
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
    <a href="MiPerfil.jsp">Regresar</a>
</html>
