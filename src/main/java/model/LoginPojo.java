package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db_config.GetConnection;  // Your DB connection class

public class LoginPojo {
    private String portId;
    private String password;
    private String name;
    private String email;
    private String location;

    // Getters and Setters
    public String getPortId() {
        return portId;
    }

    public void setPortId(String portId) {
        this.portId = portId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    // Method to check login and populate user details
    public boolean validateLogin() {
        boolean status = false;
        String sql = "SELECT * FROM users WHERE port_id=? AND password=?";

        try (Connection conn = GetConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, this.portId);
            stmt.setString(2, this.password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // Login valid, populate extra user info
                    this.name = rs.getString("name");
                    this.email = rs.getString("email");
                    this.location = rs.getString("location");

                    status = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return status;
    }
}