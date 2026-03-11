package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import db_config.GetConnection;

public class ReportedProduct {
    private int reportedId;
    private int productId;
    private String reporterId;
    private String reason;
    private Timestamp reportedAt;
    private String status;

    // Getters and Setters
    public int getReportedId() { return reportedId; }
    public void setReportedId(int reportedId) { this.reportedId = reportedId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getReporterId() { return reporterId; }
    public void setReporterId(String reporterId) { this.reporterId = reporterId; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public Timestamp getReportedAt() { return reportedAt; }
    public void setReportedAt(Timestamp reportedAt) { this.reportedAt = reportedAt; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    // Fetch all reported products
    public static List<ReportedProduct> getAllReports() {
        List<ReportedProduct> reports = new ArrayList<>();
        String sql = "SELECT * FROM report";

        try (Connection conn = GetConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ReportedProduct report = new ReportedProduct();
                report.setReportedId(rs.getInt("reportedId"));
                report.setProductId(rs.getInt("productId"));
                report.setReporterId(rs.getString("reporterId"));
                report.setReason(rs.getString("reason"));
                report.setReportedAt(rs.getTimestamp("reportedAt"));
                report.setStatus(rs.getString("status"));

                reports.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }

    // Update status of a report
    public static boolean updateReportStatus(int reportedId, String newStatus) {
        String sql = "UPDATE report SET status=? WHERE reportedId=?";

        try (Connection conn = GetConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, reportedId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ NEW METHOD: Get reported products for a specific seller
    public static List<ReportedProduct> getReportsBySeller(String sellerPortId) {
        List<ReportedProduct> reports = new ArrayList<>();
        String sql = "SELECT r.* FROM report r " +
                     "JOIN information i ON r.productId = i.product_id " +
                     "WHERE i.seller_port_id = ?";

        try (Connection conn = GetConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, sellerPortId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ReportedProduct report = new ReportedProduct();
                report.setReportedId(rs.getInt("reportedId"));
                report.setProductId(rs.getInt("productId"));
                report.setReporterId(rs.getString("reporterId"));
                report.setReason(rs.getString("reason"));
                report.setReportedAt(rs.getTimestamp("reportedAt"));
                report.setStatus(rs.getString("status"));
                reports.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }
}