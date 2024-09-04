/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.team.restoasis.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.team.restoasis.model.DetailProperty;
import org.team.restoasis.model.Property;

/**
 *
 * @author aj898
 */
public class ControllerProperty {
    public List<Property> getProperties() {
        List<Property> listProperties = null;
        String query = "SELECT * FROM Properties";
        try {
            ConnectionMysql connMysql = new ConnectionMysql();
            Connection conn = connMysql.open();
            PreparedStatement pstm = conn.prepareStatement(query);
            ResultSet rs = pstm.executeQuery();
            listProperties = new ArrayList<>();
            while (rs.next()) {
                listProperties.add(fillProperty(rs));
            }
            rs.close();
            pstm.close();
            connMysql.close();
            return listProperties;
        } catch (Exception e) {
            listProperties = new ArrayList<>();
            e.printStackTrace();
            return listProperties;
        }
    }

    private Property fillProperty(ResultSet rs) throws SQLException {
        Property property = new Property();
        property.setPropertyId(rs.getInt("Property_id"));
        property.setName(rs.getString("Name"));
        property.setLocation(rs.getString("Location"));
        property.setPrice(rs.getFloat("Price"));
        return property;
    }
    
    public DetailProperty getDetailProperty(int propertyId) {
        DetailProperty property = null;
        String query = "SELECT * FROM Details WHERE property_id = ?";
        try {
            ConnectionMysql connMysql = new ConnectionMysql();
            Connection conn = connMysql.open();
            PreparedStatement pstm = conn.prepareStatement(query);
            pstm.setInt(1, propertyId);
            ResultSet rs = pstm.executeQuery();
            property = new DetailProperty();
            while (rs.next()) {
                property = fillDetailProperty(rs);
            }
            rs.close();
            pstm.close();
            connMysql.close();
            return property;
        } catch (Exception e) {
            property = new DetailProperty();
            e.printStackTrace();
            return property;
        }
    }

    private DetailProperty fillDetailProperty(ResultSet rs) throws SQLException {
        DetailProperty dp = new DetailProperty();
        dp.setProperty_id(rs.getInt("Property_id"));
        dp.setDetail_Id(rs.getInt("Detail_id"));
        dp.setDescription(rs.getString("Description")); 
        dp.setSize(rs.getString("Size")); 
        dp.setBedrooms(rs.getInt("Bedrooms"));
        dp.setBathrooms(rs.getInt("Bathrooms"));
        dp.setStyle(rs.getString("Style")); 
        dp.setSpecial_Features(rs.getString("Special_Features"));

        return dp;
    }
     private DetailProperty filltailProperty(ResultSet rs) throws SQLException {
        DetailProperty dp = new DetailProperty();
        dp.setDetail_Id(rs.getInt("Detail_id"));
        dp.setDescription(rs.getString("Description")); 
        dp.setSize(rs.getString("Size")); 
        dp.setBedrooms(rs.getInt("Bedrooms"));
        dp.setBathrooms(rs.getInt("Bathrooms"));
        dp.setStyle(rs.getString("Style")); 
        dp.setSpecial_Features(rs.getString("Special_Features"));

        return dp;
    }
}
