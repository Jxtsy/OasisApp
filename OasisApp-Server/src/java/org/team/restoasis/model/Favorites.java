/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.team.restoasis.model;

/**
 *
 * @author pedroflores
 */
public class Favorites {
    private int favorite_id;
    private int user_id;
    private int property_id;
    
    public Favorites() {
        
    }

    public Favorites(int favorite_id, int user_id, int property_id) {
        this.favorite_id = favorite_id;
        this.user_id = user_id;
        this.property_id = property_id;
    }

    public int getFavorite_id() {
        return favorite_id;
    }

    public void setFavorite_id(int favorite_id) {
        this.favorite_id = favorite_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getProperty_id() {
        return property_id;
    }

    public void setProperty_id(int property_id) {
        this.property_id = property_id;
    }
    

}
