package ranch.util;

import java.util.HashMap;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSession;
import ranch.db.DatabaseConnection;
import ranch.db.DatabaseModule;

/**
 *@author Giovanni
 *@version 1.1.0
 * <h2>ServletListener</h2>
 * <p>Used to perform start up procedures</p>
 */
public class ServletListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        //Create a session manager and add it to the servelet context object
        HashMap<String, HttpSession> sessionManager = 
                new HashMap<String, HttpSession>();
        sce.getServletContext().setAttribute("sessionManager", sessionManager);
        
        //Establish database connection information
        DatabaseModule dbModule = new DatabaseModule();
        dbModule.setHost("localhost");
        dbModule.setPort("3306");
        dbModule.setDatabaseName("movieranch");
        dbModule.setUser("root");
        dbModule.setPassword("root");
        DatabaseConnection.useModule(dbModule);
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        //Not needed
    }  
}