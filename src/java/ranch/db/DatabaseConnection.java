package ranch.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @author Giovanni
 * @version 1.0.0
 */
public class DatabaseConnection {
    private static DatabaseModule dbModule = null;
    private static Connection dbConnection = null;
    
    public static void useModule(DatabaseModule dbModule) {
        DatabaseConnection.dbModule = dbModule;
    }
    
    public static Connection getActiveConnection() {
        if(dbModule == null)
            throw new NullPointerException("Database module object cannot be null."
                    + " Use DatabaseConnection.useModule(DatabaseModule) to set the module first.");
        try {
            Class.forName("com.mysql.jdbc.Driver"); //We don't need this in Java 1.8
            dbConnection = DriverManager.getConnection(dbModule.getConnectionURL());
            return dbConnection;
        } catch (SQLException | ClassNotFoundException e){
            e.printStackTrace();
        }
        return null;
    }
    
    public static void main(String[] args) {
        DatabaseModule dbModule = new DatabaseModule();
        dbModule.setHost("localhost");
        dbModule.setPort("3306");
        dbModule.setDatabaseName("movieranch");
        dbModule.setUser("root");
        dbModule.setPassword("royal");
        
        DatabaseConnection.useModule(dbModule);
        Connection con = DatabaseConnection.getActiveConnection();
        System.out.println("success");
    }
}
