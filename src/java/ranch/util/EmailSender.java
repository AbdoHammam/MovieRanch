package ranch.util;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Schedule;
import ranch.db.DatabaseConnection;
import ranch.db.DatabaseModule;

/**
 *
 * @author andrew
 */
public class EmailSender {
    private final String EMAIL = "IAProject3306@gmail.com";
    private final String PASSWORD = "IAProject33066";
    @Schedule(hour="12", minute="0", second="0", persistent=false)
    public void someDailyJob() {
        Connection connection = DatabaseConnection.getActiveConnection();
        try {
            Statement statement = connection.createStatement();
            String email = "you haven't returned movie ";
            String header = "hello there, this is movie ranch Admin";
            String query = "select * from renting inner join user on user.id = renting.userId inner"
                    + "join movie on movie.id = renting.movieId where renting.dueDate > CURDATE()";
            ResultSet set = statement.executeQuery(query);
            while(set.next()){
                SendEmail.send(set.getString("email"), header, email + set.getString("name"), EMAIL, PASSWORD);
                query = "insert into emails (date, userId, movieName, rentingDate, renterEmail) values('";
                query += "'2016-12-27'," + set.getInt("id") + ", '" + set.getString("name") + "', '" + set.getString("rentingDate")
                        + "', '" + set.getString("email") +"'";
                statement.execute(query);
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(EmailSender.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(EmailSender.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
