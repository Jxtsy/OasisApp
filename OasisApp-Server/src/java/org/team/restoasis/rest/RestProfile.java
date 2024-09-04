/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.team.restoasis.rest;

import com.google.gson.Gson;
import jakarta.ws.rs.FormParam;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.team.restoasis.controller.ControllerProfile;
import org.team.restoasis.model.User;

/**
 *
 * @author pedroflores
 */

@Path("profile")
public class RestProfile {
    
    @GET
    @Path("getUserDetails")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getUserDetails(@QueryParam("userId") int userId) {
        System.out.println("Entramos al metodo");
        System.out.println(userId);
        
        ControllerProfile controllerProfile = new ControllerProfile();
        User user = controllerProfile.getById(userId);

        if (user != null) {
            System.out.println(userId);
            Gson gson = new Gson();
            
            return Response.ok(gson.toJson(user)).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).entity("User not found").build();
        }
    }
    
    @PUT
    @Path("updateUser")
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateUser(
            @FormParam("userId") String userId,
            @FormParam("name") String name,
            @FormParam("username") String username,
            @FormParam("email") String email,
            @FormParam("password") String password,
            @FormParam("address") String address,
            @FormParam("phone") String phone) {
        
        User user = new User();
        user.setUser_id(Integer.parseInt(userId));
        user.setName(name);
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setAddres(address);
        user.setPhone(phone);
        
        System.out.println("Entramos al metodo");
        System.out.println(userId);
        System.out.println(name);
        
        ControllerProfile controllerProfile = new ControllerProfile();
        boolean success = controllerProfile.updateUser(user);
        
        if (success) {
            Gson gson = new Gson();
            return Response.ok(gson.toJson(user)).build();
        } else {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Failed to update user").build();
        }
    }
    
}
