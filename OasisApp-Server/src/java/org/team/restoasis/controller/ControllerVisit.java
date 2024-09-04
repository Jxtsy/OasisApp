/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.team.restoasis.controller;

import java.util.List;
import org.team.restoasis.model.Visit;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
/**
 *
 * @author aj898
 */
public class ControllerVisit {
        public List<Visit> getVisit() {
        List<Visit> listVisitas = null;
        String query = "SELECT * FROM Visits";
        try {
            ConnectionMysql connMysql = new ConnectionMysql();
            Connection conn = connMysql.open();
            PreparedStatement pstm = conn.prepareStatement(query);
            ResultSet rs = pstm.executeQuery();
            listVisitas = new ArrayList<>();
            while (rs.next()) {
                listVisitas.add(fillVisit(rs));
            }
            rs.close();
            pstm.close();
            connMysql.close();
            return listVisitas;
        } catch (Exception e) {
            listVisitas = new ArrayList<>();
            e.printStackTrace();
            return listVisitas;
        }
    }

    public Visit save(Visit visit) {
        String query = "INSERT INTO Visits VALUES (0,?,?,?)";
        try {
            ConnectionMysql connMysql = new ConnectionMysql();
            Connection conn = connMysql.open();
            PreparedStatement pstm = conn.prepareStatement(query);
            pstm.setInt(1, visit.getUser_id());
            pstm.setInt(2, visit.getProperty_id());
            pstm.setString(3, visit.getVisit_date());
            pstm.execute();
            System.out.println(pstm.getGeneratedKeys());
            pstm.close();
            connMysql.close();
            conn.close();

        } catch (Exception e) {
            System.out.println("Error " + e.getMessage());
        }
        return visit;

    }

    private Visit fillVisit(ResultSet rs) throws SQLException {
        Visit v = new Visit();
        v.setVisit_id(rs.getInt("visit_id"));
        v.setUser_id(rs.getInt("user_id"));
        v.setProperty_id(rs.getInt("property_id"));
        v.setVisit_date(rs.getString("visit_date"));
        return v;
    }
    
     public boolean deleteVisit(int visit_id) {
        String query = "DELETE FROM Visits WHERE visit_id = ?";
        try {
            ConnectionMysql connMysql = new ConnectionMysql();
            Connection conn = connMysql.open();
            PreparedStatement pstm = conn.prepareStatement(query);
            pstm.setInt(1, visit_id);
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
