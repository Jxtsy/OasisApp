/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.team.restoasis.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.team.restoasis.model.User;

/**
 *
 * @author pedroflores
 */
public class ControllerProfile {
    
    private User fillUsuario(ResultSet rs) throws SQLException {
        User u = new User();
        u.setUser_id(rs.getInt("user_id"));
        u.setName(rs.getString("name"));
        u.setUsername(rs.getString("username"));
        u.setEmail(rs.getString("email"));
        u.setPassword(rs.getString("password"));
        u.setAddres(rs.getString("addres"));
        u.setPhone(rs.getString("phone"));
        return u;
    }
    
    public User getById(int userId) {
        User user = null;
        String query = "SELECT * FROM Users WHERE user_id = ?";
        try {
            ConnectionMysql connMysql = new ConnectionMysql();
            Connection conn = connMysql.open();
            PreparedStatement pstm = conn.prepareStatement(query);
            pstm.setInt(1, userId);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                user = fillUsuario(rs);
            }
            rs.close();
            pstm.close();
            connMysql.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public boolean updateUser(User user) {
        boolean success = false;
        String query = "UPDATE Users SET name = ?, username = ?, email = ?, password = ?, addres = ?, phone = ? WHERE user_id = ?";
        try {
            ConnectionMysql connMysql = new ConnectionMysql();
            Connection conn = connMysql.open();
            PreparedStatement pstm = conn.prepareStatement(query);
            pstm.setString(1, user.getName());
            pstm.setString(2, user.getUsername());
            pstm.setString(3, user.getEmail());
            pstm.setString(4, user.getPassword());
            pstm.setString(5, user.getAddres());
            pstm.setString(6, user.getPhone());
            pstm.setInt(7, user.getUser_id());
            int rowsUpdated = pstm.executeUpdate();
            if (rowsUpdated > 0) {
                success = true;
            }
            pstm.close();
            connMysql.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }
    
}
