package servlet;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product_pojo;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("port_id") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String portId = (String) session.getAttribute("port_id");

        // If edit request
        String editId = request.getParameter("editId");
        if (editId != null) {
            Product_pojo product = Product_pojo.getProductById(Integer.parseInt(editId), portId);
            request.setAttribute("editProduct", product);
        }

        List<Product_pojo> products = Product_pojo.getProductsByUser(portId);
        request.setAttribute("products", products);

        RequestDispatcher rd = request.getRequestDispatcher("Product.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("port_id") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String portId = (String) session.getAttribute("port_id");
        String action = request.getParameter("action");

        Product_pojo product = new Product_pojo();
        product.setSellerPortId(portId);

        if (request.getParameter("product_id") != null && !request.getParameter("product_id").isEmpty()) {
            product.setProductId(Integer.parseInt(request.getParameter("product_id")));
        }

        product.setProductName(request.getParameter("productname"));
        product.setDescription(request.getParameter("description"));
        if (request.getParameter("quantity") != null && !request.getParameter("quantity").isEmpty())
            product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
        if (request.getParameter("price") != null && !request.getParameter("price").isEmpty())
            product.setPrice(Integer.parseInt(request.getParameter("price")));

        if ("add".equalsIgnoreCase(action)) {
            product.addProduct();
            session.setAttribute("message", "✅ Product added successfully!");
        } else if ("update".equalsIgnoreCase(action)) {
            product.updateProduct();
            session.setAttribute("message", "✅ Product updated successfully!");
        } else if ("delete".equalsIgnoreCase(action)) {
            product.deleteProduct();
            session.setAttribute("message", "✅ Product deleted successfully!");
        }

        response.sendRedirect("ProductServlet"); // Refresh
    }
}