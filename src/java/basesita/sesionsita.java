package basesita;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class sesionsita {
    public static boolean createSession(HttpServletRequest request, String usuario, String contrasena) {
        HttpSession session = request.getSession();
        Connection conexion = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conexionsita conecta = new conexionsita();
            conexion = conecta.conectar();
            String consulta = "SELECT * FROM usuarios WHERE correo_electronico=? AND contrasenia=?";
            ps = conexion.prepareStatement(consulta);
            ps.setString(1, usuario);
            ps.setString(2, contrasena);
            rs = ps.executeQuery();
            if (rs.next()) {
                session.setAttribute("user_id", rs.getInt("id"));
                session.setAttribute("user_name", rs.getString("nombre"));
                session.setAttribute("user_sex", rs.getString("sexo"));
                session.setAttribute("user_date", rs.getString("fecha_nacimiento"));
                session.setAttribute("user_mail", rs.getString("correo_electronico"));
                session.setAttribute("user_phone", rs.getString("telefono_celular"));
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conexion != null) {
                    conexion.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
