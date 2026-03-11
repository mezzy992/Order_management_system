package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.user_pojo;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
        response.sendRedirect("Register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  
        String port_id = request.getParameter("port_id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String location = request.getParameter("location");
        String password = request.getParameter("password");

        if (!port_id.matches("^[a-zA-Z0-9]+$")) {
            request.setAttribute("error", "Port ID must contain only letters and numbers");
            request.getRequestDispatcher("/Register.jsp").forward(request, response);
            return;
        }

        if (password == null || password.length() != 8) {
            request.setAttribute("error", "Password must be exactly 8 characters");
            request.getRequestDispatcher("/Register.jsp").forward(request, response);
            return;
        }

        user_pojo user = new user_pojo();
        user.setPort_id(port_id);
        user.setName(name);
        user.setEmail(email);
        user.setLocation(location);
        user.setPassword(password);

        try {
            user.insertUser();
            response.sendRedirect("Login.jsp?success=true");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("Login.jsp?error=db");
        }
    }
}
