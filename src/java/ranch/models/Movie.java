package ranch.models;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.json.JsonArray;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import ranch.db.DatabaseConnection;
import ranch.db.DatabaseModule;

/**
 * @author Giovanni
 * @version 1.0.0
 */
public class Movie implements Serializable {

    public enum Genre {
    ACTION, ADVENTURE, ANIMATION, BIOGRAPHY,
    DOCUMENTARY, HORROR, FANTASY, SCIFI,
    THRILLER, WAR, MYSTERY, ROMANCE,
    CRIME, COMEDY, MUSIC, FAMILY, PORNOGRAPHY
    }
    
    private String title;
    private String description;
    private String posterPath;
    private String leadActor;
    private String leadActress;
    private String director;
    private Genre genre;
    private int yearOfRelease;
    private int numberOfAvailableCopies;
    private int numberOfRentedCopies;
    private int id;
    private double rentalPrice;
    private double rating;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPosterPath() {
        return posterPath;
    }

    public void setPosterPath(String posterPath) {
        this.posterPath = posterPath;
    }

    public String getLeadActor() {
        return leadActor;
    }

    public void setLeadActor(String leadActor) {
        this.leadActor = leadActor;
    }

    public String getLeadActress() {
        return leadActress;
    }

    public void setLeadActress(String leadActress) {
        this.leadActress = leadActress;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public Genre getGenre() {
        return genre;
    }

    public void setGenre(Genre genre) {
        this.genre = genre;
    }

    public int getYearOfRelease() {
        return yearOfRelease;
    }

    public void setYearOfRelease(int yearOfRelease) {
        this.yearOfRelease = yearOfRelease;
    }

    public int getNumberOfAvailableCopies() {
        return numberOfAvailableCopies;
    }

    public void setNumberOfAvailableCopies(int numberOfAvailableCopies) {
        this.numberOfAvailableCopies = numberOfAvailableCopies;
    }

    public int getNumberOfRentedCopies() {
        return numberOfRentedCopies;
    }

    public void setNumberOfRentedCopies(int numberOfRentedCopies) {
        this.numberOfRentedCopies = numberOfRentedCopies;
    }

    public double getRentalPrice() {
        return rentalPrice;
    }

    public void setRentalPrice(double rentalPrice) {
        this.rentalPrice = rentalPrice;
    }
    
    public void setRating(double rating){
        this.rating = rating;
    }
    
    public double getRating(){
        return rating;
    }
    
    public void setId(int id){
        this.id = id;
    }
    
    public int getId(){
        return id;
    }
    
    public static void addMovie(Movie movie) {
        //TODO - add movie in database
    }
    
    public static ArrayList<Movie> retriveMovies(String filter) {
        try { 
            JSONParser parser = new JSONParser();
            JSONObject object = (JSONObject)parser.parse(filter);
            //TODO - retrieve movies from database subject to the stated criteria
        } catch (ParseException e) {
            
        }
        return null;
    }
    
    public static Movie getMovie(int id) {
        Movie movie = null;
        DatabaseModule module = new DatabaseModule("localhost", "3306", "MovieRanch", "root", "root", null);
        DatabaseConnection.useModule(module);
        Connection connection = DatabaseConnection.getActiveConnection();
        String query = "select * from Movie where id = " + id;
        
        Statement statement;
        try {
            statement = connection.createStatement();
            ResultSet set = statement.executeQuery(query);
        while(set.next()){
            movie = new Movie();
            movie.setId(id);
            movie.setDescription(set.getString("description"));
            movie.setDirector(set.getString("director"));
            //giovanni, you handle this :), the genre
            movie.setGenre(Genre.WAR);
            movie.setLeadActor(set.getString("leadActor"));
            movie.setLeadActress(set.getString("leadActress"));
            movie.setNumberOfAvailableCopies(set.getInt("availableNumber"));
            movie.setNumberOfRentedCopies(set.getInt("rentedNumber"));
            movie.setPosterPath(set.getString("posterLink"));
            movie.setRating(set.getInt("rating"));
            movie.setRentalPrice(set.getDouble("rentingPrice"));
            movie.setTitle(set.getString("name"));
            movie.setYearOfRelease(set.getInt("yearOfRelease"));
        }
        } catch (SQLException ex) {
            Logger.getLogger(Movie.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return movie;
    }
    
    public static void rentMovie(int id, int userId, int duration){
        DatabaseModule module = new DatabaseModule("localhost", "3306", "MovieRanch", "root", "root", null);
        DatabaseConnection.useModule(module);
        Connection connection = DatabaseConnection.getActiveConnection();
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	Calendar cal = Calendar.getInstance();
	LocalDate date = LocalDate.parse(format.format(cal.getTime()));
	
        String query = "insert into Renting(movieId, userId, dueDate) values(" + id + "," + userId +",'" +
                date.plusDays(duration).toString() + "')";
        Statement statement;
        try {
            statement = connection.createStatement();
            statement.execute(query);
        query = "update Movie set rentedNumber = rentedNumber + 1, availableNumber = availableNumber - 1 where id = " + id;
        statement.executeUpdate(query);
        } catch (SQLException ex) {
            Logger.getLogger(Movie.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void updateMovie(Movie movie){
        DatabaseModule module = new DatabaseModule("localhost", "3306", "MovieRanch", "root", "root", null);
        DatabaseConnection.useModule(module);
        Connection connection = DatabaseConnection.getActiveConnection();
        try {
            String cond = movie.getLeadActor() == null ? ", leadActress = '" + movie.getLeadActress() + "' "
                    : ", leadActor = '" + movie.getLeadActor() + "' ";
            Statement statement = connection.createStatement();
            String query = "update Movie set genre = '" + movie.getGenre() + "', description = '" + movie.getDescription()
                    + "',"
                    + " availableNumber = " + movie.getNumberOfAvailableCopies() + ",  rating = " + movie.getRating()
                    + ", "
                    + "yearOfRelease = " + movie.getYearOfRelease() + ", rentingPrice = " + movie.getRentalPrice()
                    + cond +  "where id = " + movie.getId();
            statement.executeUpdate(query);
        } catch (SQLException ex) {
            Logger.getLogger(Movie.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static String getAllMatchingMovies(String value, String option){
        DatabaseModule module = new DatabaseModule("localhost", "3306", "MovieRanch", "root", "root", null);
        DatabaseConnection.useModule(module);
        Connection connection = DatabaseConnection.getActiveConnection();
        String query = "select * from Movie where ";
        if (option.equals("year")){
            query += "yearOfRelease = " + value;
        }else if (option.equals("actor")){
            query += "leadActor like '%" + value + "%' or leadActress like '%" + value + "%'";
        } else if (option.equals("name")){
            query += "name like '%" + value + "%'";
        }
        try {
            Statement statement = connection.createStatement();
            ResultSet set = statement.executeQuery(query);
            JSONArray array = new JSONArray();
            while(set.next()){
                JSONObject obj = new JSONObject();
                obj.put("name", set.getString("name"));
                obj.put("imagePath", set.getString("posterLink"));
                obj.put("id", set.getInt("id"));
                array.add(obj);
            }
            return array.toString();
                    
        }catch (SQLException ex) {
            Logger.getLogger(Movie.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}