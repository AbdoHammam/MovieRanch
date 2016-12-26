package ranch.db;

/**
 * @author Giovanni
 * @version 1.0.0
 */
public class DatabaseModule {
    private String host;
    private String port;
    private String databaseName;
    private String user;
    private String password;
    private String[] options; //For extension and database properties

    public DatabaseModule() {
        host = "";
        port = "";
        databaseName = "";
        user = "";
        password = "";
    }
    
    public DatabaseModule(String host, String port, String databaseName,
            String user, String password, String[] options) {
        this.host = host;
        this.port = port;
        this.databaseName = databaseName;
        this.user = user;
        this.password = password;
        this.options = options;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public String getPort() {
        return port;
    }

    public void setPort(String port) {
        this.port = port;
    }

    public String getDatabaseName() {
        return databaseName;
    }

    public void setDatabaseName(String databaseName) {
        this.databaseName = databaseName;
    }
    
    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String[] getOptions() {
        return options;
    }

    public void setOptions(String[] options) {
        this.options = options;
    }
    
    public String getConnectionURL() {
        return String.format("jdbc:mysql://%s:%s/%s?user=%s&password=%s",
                host, port, databaseName, user, password);
    }
    
    public static void main(String[] args) {
        DatabaseModule db = new DatabaseModule("localhost", "3306", "movieranch", "root", "royal", null);
    }   
}
