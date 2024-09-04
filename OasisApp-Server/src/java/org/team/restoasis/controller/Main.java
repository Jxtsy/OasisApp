/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.team.restoasis.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.team.restoasis.model.User;

/**
 *
 * @author aj898
 */
public class Main {
    
    public static void main(String[] args) throws ParseException {
        User c = new User(0, "Juan Jaramillo", "Jxtsy", "Jaramillo@gmail.com", "JJLovesU1!", "Avenida Universidad","+ 52 462 217 9231");
        ControllerAuth cc = new ControllerAuth();
        cc.save(c);
    }
}
