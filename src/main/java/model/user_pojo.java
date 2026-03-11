package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import db_config.GetConnection;

public class user_pojo {
    private String port_id;
    private String name;
    private String email;
    private String location;
    private String password;

    // Getters and Setters
    public String getPort_id() { return port_id; }
    public void setPort_id(String port_id) { this.port_id = port_id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public void insertUser() throws SQLException {
        Connection conn = GetConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement("INSERT INTO users VALUES (?, ?, ?, ?, ?)");
        ps.setString(1, port_id);
        ps.setString(2, name);
        ps.setString(3, email);
        ps.setString(4, location);
        ps.setString(5, password);
        ps.executeUpdate();
        conn.close();
    }
}
