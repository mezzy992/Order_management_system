package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.OrderPojo;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("port_id") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String sellerPortId = (String) session.getAttribute("port_id");
        List<OrderPojo> orders = OrderPojo.getOrdersBySeller(sellerPortId);

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("Order.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("order_id"));
        String newStatus = request.getParameter("status");

        boolean updated = OrderPojo.updateOrderStatus(orderId, newStatus);

        if (updated) {
            response.sendRedirect("OrderServlet?updateSuccess=true");
        } else {
            response.sendRedirect("OrderServlet?updateSuccess=false");
        }
    }
}