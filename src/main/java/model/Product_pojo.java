package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import db_config.GetConnection;

public class Product_pojo {
    private int productId;
    private String sellerPortId;
    private String productName;
    private String description;
    private int quantity;
    private int price;

    // --- Getters & Setters ---
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getSellerPortId() { return sellerPortId; }
    public void setSellerPortId(String sellerPortId) { this.sellerPortId = sellerPortId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    // --- DAO METHODS INSIDE POJO ---

    // Add product
    public boolean addProduct() {
        String sql = "INSERT INTO information (seller_port_id, productname, description, quantity, price) VALUES (?,?,?,?,?)";
        try (Connection conn = GetConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, this.sellerPortId);
            ps.setString(2, this.productName);
            ps.setString(3, this.description);
            ps.setInt(4, this.quantity);
            ps.setInt(5, this.price);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // Update product
    public boolean updateProduct() {
        String sql = "UPDATE information SET productname=?, description=?, quantity=?, price=? WHERE product_id=? AND seller_port_id=?";
        try (Connection conn = GetConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, this.productName);
            ps.setString(2, this.description);
            ps.setInt(3, this.quantity);
            ps.setInt(4, this.price);
            ps.setInt(5, this.productId);
            ps.setString(6, this.sellerPortId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // Delete product
    public boolean deleteProduct() {
        String sql = "DELETE FROM information WHERE product_id=? AND seller_port_id=?";
        try (Connection conn = GetConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, this.productId);
            ps.setString(2, this.sellerPortId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // Get all products for logged-in seller
    public static List<Product_pojo> getProductsByUser(String sellerPortId) {
        List<Product_pojo> list = new ArrayList<>();
        String sql = "SELECT * FROM information WHERE seller_port_id=?";
        try (Connection conn = GetConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sellerPortId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product_pojo p = new Product_pojo();
                p.setProductId(rs.getInt("product_id"));
                p.setSellerPortId(rs.getString("seller_port_id"));
                p.setProductName(rs.getString("productname"));
                p.setDescription(rs.getString("description"));
                p.setQuantity(rs.getInt("quantity"));
                p.setPrice(rs.getInt("price"));
                list.add(p);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // Fetch product by ID
    public static Product_pojo getProductById(int productId, String sellerPortId) {
        String sql = "SELECT * FROM information WHERE product_id=? AND seller_port_id=?";
        try (Connection conn = GetConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setString(2, sellerPortId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Product_pojo p = new Product_pojo();
                p.setProductId(rs.getInt("product_id"));
                p.setSellerPortId(rs.getString("seller_port_id"));
                p.setProductName(rs.getString("productname"));
                p.setDescription(rs.getString("description"));
                p.setQuantity(rs.getInt("quantity"));
                p.setPrice(rs.getInt("price"));
                return p;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
}