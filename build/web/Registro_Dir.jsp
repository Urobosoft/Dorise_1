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
        Object userIdObj = sesion.getAttribute("user_id");
        int userid = Integer.parseInt(userIdObj.toString());
        String calle = request.getParameter("calle");
        String no_ext = request.getParameter("no_ext");
        String no_int = request.getParameter("no_int");
        String cp = request.getParameter("cp");
        String colonia = request.getParameter("colonia");
        String estado = request.getParameter("estado");
        String municipio = request.getParameter("municipio");
        Connection con = null;
        CallableStatement comandito = null;
        ResultSet rs = null;
        conexionsita conecta = new conexionsita();
        con = conecta.conectar();
        try {
            comandito = con.prepareCall("{call agregarDir(?,?,?,?,?,?,?,?)}");
            comandito.setString(1, calle);
            comandito.setInt(2, Integer.parseInt(no_ext));
            comandito.setInt(3, Integer.parseInt(no_int));
            comandito.setInt(4, Integer.parseInt(cp));
            comandito.setString(5, colonia);
            comandito.setString(6, estado);
            comandito.setString(7, municipio);
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
