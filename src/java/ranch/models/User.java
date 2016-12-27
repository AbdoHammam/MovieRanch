package ranch.models;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import ranch.db.DatabaseConnection;
import ranch.db.DatabaseModule;

/**
 * @author Giovanni
 * @version 1.1.0
 */
public class User {
    protected int id;
    protected String username;
    protected String email;
    protected String password;
    private double balance;
    private Timestamp dateOfJoin;
    private String gender;
    private String address;
    private boolean isAdmin;
    private ArrayList<Movie> rentedMovies;
    
    public User() {
        //Empty Constructor
    }
    public User(int id, String username, String email, String password, 
            double balance, Timestamp dateOfJoin, String gender, String address, boolean isAdmin) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.password = password;
        this.balance = balance;
        this.dateOfJoin = dateOfJoin;
        this.gender = gender;
        this.address = address;
        this.isAdmin = isAdmin;
    }

    public Timestamp getDateOfJoin() {
        return dateOfJoin;
    }

    public void setDateOfJoin(Timestamp dateOfJoin) {
        this.dateOfJoin = dateOfJoin;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    public ArrayList<Movie> getRentedMovies() {
        return rentedMovies;
    }

    public void setRentedMovies(ArrayList<Movie> rentedMovies) {
        this.rentedMovies = rentedMovies;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }
    
    public static User getUser(int id){
        User user = null;
        DatabaseModule module = new DatabaseModule("localhost", "3306", "MovieRanch", "root", "root", null);
        DatabaseConnection.useModule(module);
        Connection connection = DatabaseConnection.getActiveConnection();
        Statement statement;
        try {
            statement = connection.createStatement();
            String query = "select * from User where id = " + id;  
            ResultSet set = statement.executeQuery(query);
            while(set.next()){
                user = new User();
                user.setBalance(set.getDouble("balance"));//
                user.setEmail(set.getString("email"));//
                user.setId(set.getInt("id"));//
                user.setPassword(set.getString("password"));//
                user.setUsername(set.getString("name"));//
                user.setAddress(set.getString("address"));//
                user.setRentedMovies(null);//just for now
                user.setDateOfJoin(set.getTimestamp("dateOfJoin"));//
                user.setIsAdmin(set.getBoolean("isAdmin"));//
                user.setGender(set.getString("gender"));//
            }
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public static String getPassword(int id) {
        DatabaseModule module = new DatabaseModule("localhost", "3306", "MovieRanch", "root", "root", null);
        DatabaseConnection.useModule(module);
        Connection connection = DatabaseConnection.getActiveConnection();
        String query = "select * from User where id = " + id;
        ResultSet set;
        try {
            Statement statement = connection.createStatement();
            set = statement.executeQuery(query);
            while(set.next()){
                return set.getString("password");
        }
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }
       
        return null;
    }
    
    public static void updateBalance(double amount, int id){
        DatabaseModule module = new DatabaseModule("localhost", "3306", "MovieRanch", "root", "root", null);
        DatabaseConnection.useModule(module);
        Connection connection = DatabaseConnection.getActiveConnection();
        Statement statement;
        String query = "update User set balance = " + amount + " where id = " + id;
        try {
            statement = connection.createStatement();
            statement.executeUpdate(query);
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void updateUserInfo(User user){
        DatabaseModule module = new DatabaseModule("localhost", "3306", "MovieRanch", "root", "root", null);
        DatabaseConnection.useModule(module);
        Connection connection = DatabaseConnection.getActiveConnection();
        String conditional = user.getPassword().equals("") ? "" : ", password = '" + user.getPassword() + "'";
        try {
            Statement statement = connection.createStatement();
            String query = "update User set name = '" + user.getUsername() + "', gender = '" + user.getGender() + "', balance = "
                    + user.getBalance() + ", address = '" + user.getAddress() + "', email = '" + user.getEmail() + "'"
                    + conditional + " where id = " + user.getId();
            statement.executeUpdate(query);
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}