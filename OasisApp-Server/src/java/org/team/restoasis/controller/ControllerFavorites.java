/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.team.restoasis.controller;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.team.restoasis.model.Favorites;

/**
 *
 * @author pedroflores
 */

public class ControllerFavorites {
    
    public List<Favorites> getAllFavorites(){
        List<Favorites> listFavorites = null;
        String query = "SELECT * FROM Favorites";
        try {
            ConnectionMysql connMysql = new ConnectionMysql();
            Connection conn = connMysql.open();
            PreparedStatement pstm = conn.prepareStatement(query);
            ResultSet rs = pstm.executeQuery();
            listFavorites = new ArrayList<>();
            while (rs.next()) {
                listFavorites.add(fillFavorite(rs));
            }
            rs.close();
            pstm.close();
            connMysql.close();
            return listFavorites;
        } catch (Exception e){
            listFavorites = new ArrayList<>();
            e.printStackTrace();
            return listFavorites;
        }
    }
    
    public boolean addFavorite(int user_id, int property_id) {
        String query = "INSERT INTO Favorites (user_id, property_id) VALUES (?, ?)";
        try {
            ConnectionMysql connMysql = new ConnectionMysql();
            Connection conn = connMysql.open();
            PreparedStatement pstm = conn.prepareStatement(query);
            pstm.setInt(1, user_id);
            pstm.setInt(2, property_id);
            int rowsAffected = pstm.executeUpdate();
            pstm.close();
            connMysql.close();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private Favorites fillFavorite(ResultSet rs) throws SQLException {
        Favorites favorite = new Favorites();
        favorite.setFavorite_id(rs.getInt("favorite_id"));
        favorite.setUser_id(rs.getInt("user_id"));
        favorite.setProperty_id(rs.getInt("property_id"));
        return favorite;
    }


    public boolean deleteFavorite(int favorite_id) {
        String query = "DELETE FROM Favorites WHERE favorite_id = ?";
        try {
            ConnectionMysql connMysql = new ConnectionMysql();
            Connection conn = connMysql.open();
            PreparedStatement pstm = conn.prepareStatement(query);
            pstm.setInt(1, favorite_id);
            int rowsAffected = pstm.executeUpdate();
            pstm.close();
            connMysql.close();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
}

