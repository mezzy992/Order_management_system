package servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.SellerPojo;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("port_id") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        String portId = (String) session.getAttribute("port_id");
        SellerPojo seller = new SellerPojo();

        try {
            if (seller.fetchByPortId(portId)) {
                req.setAttribute("port_id", seller.getPort_id());
                req.setAttribute("name", seller.getName());
                req.setAttribute("email", seller.getEmail());
                req.setAttribute("location", seller.getLocation());
            } else {
                resp.sendRedirect("Login.jsp");
                return;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        RequestDispatcher rd = req.getRequestDispatcher("Profilemanagement.jsp");
        rd.forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("port_id") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        String portId = (String) session.getAttribute("port_id");
        String action = req.getParameter("action");

        SellerPojo seller = new SellerPojo();
        seller.setPort_id(portId);

        if ("update".equals(action)) {
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String location = req.getParameter("location");
            String password = req.getParameter("password");

            if (password != null && !password.trim().isEmpty() && password.length() < 8) {
                resp.sendRedirect("ProfileServlet?error=length");
                return;
            }

            try {
                // Always fetch current user before update
                seller.fetchByPortId(portId);

                seller.setName(name);
                seller.setEmail(email);
                seller.setLocation(location);

                if (password != null && !password.trim().isEmpty()) {
                    seller.setPassword(password); // update only if new password given
                }

                seller.update();

                // reload updated data into request
                req.setAttribute("port_id", seller.getPort_id());
                req.setAttribute("name", seller.getName());
                req.setAttribute("email", seller.getEmail());
                req.setAttribute("location", seller.getLocation());
                req.setAttribute("success", "Profile updated successfully!");

                RequestDispatcher rd = req.getRequestDispatcher("Profilemanagement.jsp");
                rd.forward(req, resp);

            } catch (SQLException e) {
                throw new ServletException(e);
            }

        } else if ("delete".equals(action)) {
            try {
                seller.delete();
            } catch (SQLException e) {
                throw new ServletException(e);
            }
            session.invalidate();
            resp.sendRedirect("Login.jsp?deleted=true");
        } else {
            resp.sendRedirect("ProfileServlet");
        }
    }
}