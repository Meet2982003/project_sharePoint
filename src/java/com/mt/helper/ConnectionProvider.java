
package com.mt.helper;
import java.sql.*;
public class ConnectionProvider {
    private static Connection conn;
    public static Connection getConnection(){
        try{
            if(conn==null){
            //driver class load
            Class.forName("com.mysql.jdbc.Driver");
            
            //create connection
            
            conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","Meet@125");
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return conn;
    }
}
