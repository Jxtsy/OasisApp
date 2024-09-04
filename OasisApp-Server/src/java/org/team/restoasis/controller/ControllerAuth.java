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
 * @author aj898
 */
public class ControllerAuth {

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

    public User getByUsernameAndPassword(String username, String password) {
        User user = null;
        String query = "SELECT * FROM Users WHERE username = ? AND password = ?";
        try {
            ConnectionMysql connMysql = new ConnectionMysql();
            Connection conn = connMysql.open();
            //Prepara la query para recibir los parametros necesarios
            PreparedStatement pstm = conn.prepareStatement(query);
            pstm.setString(1, username);
            pstm.setString(2, password);
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

    public User save(User user) {
        String query = "INSERT INTO Users VALUES (0,?,?,?,?,?,?)";
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
            pstm.execute();
            System.out.println(pstm.getGeneratedKeys());
            pstm.close();
            connMysql.close();
            conn.close();
        } catch (Exception e) {
            System.out.println("Error " + e.getMessage());
        }
        return user;
    }

}
