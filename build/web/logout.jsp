<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@page import="java.sql.*"%>
        <%
            HttpSession sesionsita = null;
            sesionsita = request.getSession(false);
            if (sesionsita != null) {
                sesionsita.invalidate();
            }
            response.sendRedirect("index.html");
        %>
    </body>
</html>
