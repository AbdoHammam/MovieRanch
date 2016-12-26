package ranch.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ranch.db.DatabaseConnection;
import ranch.models.Movie;
import ranch.models.User;

/**
 * @author andrew
 * @author Giovanni
 * @author Rino
 * @author Abdo
 * @version 1.3.0
 * <p>
 * This servlet is mainly used to handle Ajax requests</p>
 */
@WebServlet(urlPatterns = {"/utilities"})
public class Utilities extends HttpServlet {

    private Connection con;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");

        String option = request.getParameter("option"); //What action should be taken
        try (PrintWriter out = response.getWriter()) {
            if (option.equals("login")) {
                out.print(doLogin(request.getParameter("user"),
                        request.getParameter("pass"), request, response));
            } else if (option.equals("signup")) {
                //TO-DO
            } else if (option.equals("getPassword")) {
                out.print(User.getPassword(Integer.parseInt(request.getParameter("id"))));
            } else if (option.equals("rentMovie")) {
                out.print(rent(request));
            } else if(option.equals("search")){
                out.print(search(request));
            }

        } catch (Exception e){
            response.getWriter().write(e.getStackTrace().toString());
        }
        finally {
            if (con != null) {
                con.close();
            }
        }
    }

    private String doLogin(String name, String password, HttpServletRequest request,
            HttpServletResponse response) throws SQLException {
        con = DatabaseConnection.getActiveConnection();
        PreparedStatement stmt = con.prepareStatement("SELECT * FROM user WHERE name = ? AND password = ?");
        stmt.setString(1, name);
        stmt.setString(2, password);

        ResultSet resultSet = stmt.executeQuery();
        if (resultSet.next()) {
            User user = new User();
            user.setId(resultSet.getInt(1));
            user.setUsername(resultSet.getString(2));
            user.setDateOfJoin(resultSet.getTimestamp(3));
            user.setGender(resultSet.getString(4));
            user.setBalance(resultSet.getDouble(5));
            user.setAddress(resultSet.getString(6));
            user.setEmail(resultSet.getString(7));
            user.setIsAdmin(resultSet.getInt(8) == 1);
            user.setPassword(resultSet.getString(9));

            request.getSession().setAttribute("user", user);
            SessionControl.saveSession(request, response);
            return "OK";
        } else {
            return "BAD";
        }
    }

    private String doSignUp() {
        return null;
    }

    private String rent(HttpServletRequest request) {
        int duration = Integer.parseInt(request.getParameter("duration"));
        int userId = Integer.parseInt(request.getParameter("id"));
        int movieId = Integer.parseInt(request.getParameter("xid"));

        Movie movie = Movie.getMovie(movieId);
        User user = User.getUser(userId);

        double price = movie.getRentalPrice() * duration;
        if (price > user.getBalance()) {
            return "error:balance not enough;";
        } else {
            User.updateBalance(user.getBalance() - price, userId);
            Movie.rentMovie(movieId, userId, duration);
        }
        return user.getBalance() - price + "";
    }

    private String search(HttpServletRequest request){
        String value = request.getParameter("value");
        String option = request.getParameter("key");
        String result = Movie.getAllMatchingMovies(value, option); 
        return result;
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Utilities.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Utilities.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
