package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db_config.GetConnection;

public class SellerPojo {
    private String port_id;
    private String name;
    private String email;
    private String password;
    private String location;

    // Getters and Setters
    public String getPort_id() {
        return port_id;
    }

    public void setPort_id(String port_id) {
        this.port_id = port_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    // Fetch user info by port_id
    public boolean fetchByPortId(String port_id) throws SQLException {
        this.port_id = port_id;
        String sql = "SELECT * FROM users WHERE port_id = ?";
        try (Connection conn = GetConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, port_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    this.name = rs.getString("name");
                    this.email = rs.getString("email");
                    this.location = rs.getString("location");
                    this.password = rs.getString("password");
                    return true;
                }
            }
        }
        return false;
    }

    // Update user info in DB
    public void update() throws SQLException {
        String sql = "UPDATE users SET name=?, email=?, location=?, password=? WHERE port_id=?";
        try (Connection conn = GetConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, this.name);
            ps.setString(2, this.email);
            ps.setString(3, this.location);
            ps.setString(4, this.password);
            ps.setString(5, this.port_id);
            ps.executeUpdate();
        }
    }

    // Delete user by port_id
    public void delete() throws SQLException {
        String sql = "DELETE FROM users WHERE port_id=?";
        try (Connection conn = GetConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, this.port_id);
            ps.executeUpdate();
        }
    }
}