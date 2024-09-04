/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.team.restoasis.model;

/**
 *
 * @author aj898
 */
public class DetailProperty {
    private int detail_id;
    private int property_id;
    private String description;
    private String size;
    private int bedrooms;
    private int bathrooms;
    private String style;
    private String special_Features;
    
    public DetailProperty (){
        
    }

    public DetailProperty(int detail_Id, int property_id, String description, String size, int bedrooms, int bathrooms, String style, String special_Features) {
        this.detail_id = detail_Id;
        this.property_id = property_id;
        this.description = description;
        this.size = size;
        this.bedrooms = bedrooms;
        this.bathrooms = bathrooms;
        this.style = style;
        this.special_Features = special_Features;
    }

    public int getDetail_Id() {
        return detail_id;
    }

    public void setDetail_Id(int detail_Id) {
        this.detail_id = detail_Id;
    }

    public int getProperty_id() {
        return property_id;
    }

    public void setProperty_id(int property_id) {
        this.property_id = property_id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public int getBedrooms() {
        return bedrooms;
    }

    public void setBedrooms(int bedrooms) {
        this.bedrooms = bedrooms;
    }

    public int getBathrooms() {
        return bathrooms;
    }

    public void setBathrooms(int bathrooms) {
        this.bathrooms = bathrooms;
    }

    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }

    public String getSpecial_Features() {
        return special_Features;
    }

    public void setSpecial_Features(String special_Features) {
        this.special_Features = special_Features;
    }
    
    
            
}
