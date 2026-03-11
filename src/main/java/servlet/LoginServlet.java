package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.LoginPojo;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get data from JSP
        String portId = request.getParameter("port_id");
        String password = request.getParameter("password");

        // ✅ Check password length (at least 8 chars)
        if (password == null || password.length() < 8) {
            response.sendRedirect("Login.jsp?error=length");
            return;
        }

        // ✅ Put into POJO
        LoginPojo user = new LoginPojo();
        user.setPortId(portId);
        user.setPassword(password);

        // ✅ Call POJO method (DB check inside POJO)
        if (user.validateLogin()) {
            HttpSession session = request.getSession();
            session.setAttribute("port_id", portId); // ✅ stored for use in Products/Orders/Reports

            response.sendRedirect("Dashboard.jsp");
        } else {
            response.sendRedirect("Login.jsp?error=invalid");
        }
    }
}