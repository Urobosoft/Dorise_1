package basesita;

import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class conexionsita {
    Connection cnx  = null;
        public Connection conectar(){
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                cnx = DriverManager.getConnection("jdbc:mysql://localhost:3308/doris?autoReconnect=true&useSSL=false", "root", "n0m3l0");
            }
            catch(ClassNotFoundException | SQLException error){
               out.println("");
            }
            return cnx;
        }   
}
