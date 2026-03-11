package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ReportedProduct;

import java.io.IOException;
import java.util.List;

@WebServlet("/ReportedProductServlet")
public class ReportedProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Display reported products for the logged-in seller only
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("port_id") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String portId = (String) session.getAttribute("port_id");

        List<ReportedProduct> reportList = ReportedProduct.getReportsBySeller(portId);
        request.setAttribute("reportList", reportList);
        request.getRequestDispatcher("Reported.jsp").forward(request, response);
    }

    // Handle update of report status, then reload filtered list
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("port_id") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int reportedId = Integer.parseInt(request.getParameter("reportedId"));
        String newStatus = request.getParameter("status");
        String portId = (String) session.getAttribute("port_id");

        try {
            boolean updated = ReportedProduct.updateReportStatus(reportedId, newStatus);

            // Fetch reports again for logged-in seller
            List<ReportedProduct> reportList = ReportedProduct.getReportsBySeller(portId);
            request.setAttribute("reportList", reportList);

            if (updated) {
                request.setAttribute("updateSuccess", "Report status updated successfully!");
            } else {
                request.setAttribute("updateError", "Failed to update report status.");
            }

            request.getRequestDispatcher("Reported.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("updateError", "Error updating status.");
            request.getRequestDispatcher("Reported.jsp").forward(request, response);
        }
    }
}