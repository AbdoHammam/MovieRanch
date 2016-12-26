package ranch.util;

import java.util.HashMap;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author Giovanni
 * Used to handle different operations on user sessions
 */
public class SessionControl extends HttpServlet {
    
    public static void saveSession(HttpServletRequest request, HttpServletResponse response) {
        HashMap<String, HttpSession> sessionManager = 
                    (HashMap<String, HttpSession>)request.getServletContext()
                            .getAttribute("sessionManager");
        HttpSession session = request.getSession();
        sessionManager.put(session.getId(), session);
        
        Cookie cookie = new Cookie("token", session.getId());
        response.addCookie(cookie);
    }
    
    public static Cookie acquireCookie(String cookieName, HttpServletRequest request) {
        for(Cookie cookie : request.getCookies())
            if(cookie.getName().equals(cookieName))
                return cookie;
        return null;
    }
}