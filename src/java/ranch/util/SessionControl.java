package ranch.util;

import java.io.IOException;
import java.util.HashMap;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ranch.models.User;

/**
 * @author Giovanni
 * Used to handle different operations on user sessions
 */

public class SessionControl extends HttpServlet {
    private static final int TIMEOUT = 2 * 24 * 60 * 60; //2 Days
    public static void saveSession(HttpServletRequest request, HttpServletResponse response) {
        HashMap<String, HttpSession> sessionManager = 
                    (HashMap<String, HttpSession>)request.getServletContext()
                            .getAttribute("sessionManager");
        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(TIMEOUT);
        sessionManager.put(session.getId(), session);
        
        Cookie cookie = new Cookie("token", session.getId());
        cookie.setMaxAge(TIMEOUT);
        response.addCookie(cookie);
    }
    
    public static Cookie acquireCookie(String cookieName, HttpServletRequest request) {
        if(request.getCookies() != null) {
            for(Cookie cookie : request.getCookies())
                if(cookie.getName().equals(cookieName))
                    return cookie;
        }
        return null;
    }
    
    public static void removeSession(HttpServletRequest request, HttpServletResponse response) {
        Cookie cookie = SessionControl.acquireCookie("token", request);
        if(cookie != null) {
            HashMap<String, HttpSession> sessionManager = 
            (HashMap<String, HttpSession>)request.getServletContext()
                    .getAttribute("sessionManager");
            sessionManager.get(cookie.getValue()).invalidate();
            sessionManager.remove(cookie.getValue());
            cookie.setMaxAge(0);
            response.addCookie(cookie);
        }
    }
    
    //made by andrew, as i don't know how to access this shit
    public static int getId(String sessionId, HttpServletRequest request){
        HashMap<String, HttpSession> sessionManager = 
            (HashMap<String, HttpSession>)request.getServletContext()
                    .getAttribute("sessionManager");
        HttpSession session = sessionManager.get(sessionId);
        User user = (User) session.getAttribute("user");
        return user.getId();
    }
}