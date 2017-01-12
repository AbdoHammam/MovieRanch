package ranch.util;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ranch.models.Movie;

/**
 *
 * @author andre
 */
@WebServlet(urlPatterns = {"/UpdateMovie"})
public class UpdateMovie extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String desc, genre, actor, actress;
        double rating, rentingPrice;
        int year, availNum, id;
        
        desc = request.getParameter("description");
        genre = request.getParameter("genre");
        actor = request.getParameter("actor");
        actress = request.getParameter("actress");
        year = Integer.parseInt(request.getParameter("ReleasedDate"));
        availNum = Integer.parseInt(request.getParameter("copies"));
        rating = Double.parseDouble(request.getParameter("rating"));
        rentingPrice = Double.parseDouble(request.getParameter("cost"));
        id = Integer.parseInt(request.getParameter("id"));
        
        Movie movie = new Movie();
        movie.setId(id);
        movie.setDescription(desc);
        movie.setGenre(Movie.Genre.WAR);
        movie.setLeadActor(actor);
        movie.setLeadActress(actress);
        movie.setNumberOfAvailableCopies(availNum);
        movie.setRating(rating);
        movie.setYearOfRelease(year);
        movie.setRentalPrice(rentingPrice);
        
        Movie.updateMovie(movie);
        response.sendRedirect("http://localhost:8080/movieranch/home.jsp");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
