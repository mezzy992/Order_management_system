package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import db_config.GetConnection;

public class OrderPojo {
    private int order_id;
    private String buyer_id;
    private String seller_port_id;  // FK to user.port_id
    private Timestamp order_date;
    private int total_amount;
    private String status;
    private String delivery_address;

    // ====== Getters & Setters ======
    public int getOrder_id() { return order_id; }
    public void setOrder_id(int order_id) { this.order_id = order_id; }

    public String getBuyer_id() { return buyer_id; }
    public void setBuyer_id(String buyer_id) { this.buyer_id = buyer_id; }

    public String getSeller_port_id() { return seller_port_id; }
    public void setSeller_port_id(String seller_port_id) { this.seller_port_id = seller_port_id; }

    public Timestamp getOrder_date() { return order_date; }
    public void setOrder_date(Timestamp order_date) { this.order_date = order_date; }

    public int getTotal_amount() { return total_amount; }
    public void setTotal_amount(int total_amount) { this.total_amount = total_amount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getDelivery_address() { return delivery_address; }
    public void setDelivery_address(String delivery_address) { this.delivery_address = delivery_address; }

    // ====== DAO Methods ======

    // Get all orders for a seller
    public static List<OrderPojo> getOrdersBySeller(String sellerPortId) {
        List<OrderPojo> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE seller_port_id = ?";

        try (Connection conn = GetConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, sellerPortId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderPojo o = new OrderPojo();
                o.setOrder_id(rs.getInt("order_id"));
                o.setBuyer_id(rs.getString("buyer_id"));
                o.setSeller_port_id(rs.getString("seller_port_id"));
                o.setOrder_date(rs.getTimestamp("order_date"));
                o.setTotal_amount(rs.getInt("total_amount"));
                o.setStatus(rs.getString("status"));
                o.setDelivery_address(rs.getString("delivery_address"));
                orders.add(o);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Update order status
    public static boolean updateOrderStatus(int orderId, String newStatus) {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (Connection conn = GetConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}