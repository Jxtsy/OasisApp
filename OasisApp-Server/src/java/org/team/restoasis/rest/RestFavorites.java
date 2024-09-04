/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.team.restoasis.rest;

import com.google.gson.Gson;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.FormParam;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;
import org.team.restoasis.controller.ControllerFavorites;
import org.team.restoasis.model.Favorites;

/**
 *
 * @author pedroflores
 */
@Path("favorites")
public class RestFavorites {
    
    @Path("getAll")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAll(){
        String out;
        Gson gson = new Gson();
        try {
            ControllerFavorites controller = new ControllerFavorites();
            List<Favorites> list = controller.getAllFavorites();
            out = gson.toJson(list);
            
        } catch (Exception e){
            out = """
                  {"Error":"Error en la peticion"}
                  """;
        }
        return Response.ok(out).build();
    }
    
    @Path("addFavorites")
    @POST
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addFavorite(@FormParam("user_id") int user_id,
                                @FormParam("property_id") int property_id) {
        String out;
        Gson gson = new Gson();
        try {
            ControllerFavorites controller = new ControllerFavorites();
            boolean result = controller.addFavorite(user_id, property_id);
            out = result ? "{\"Success\":\"Favorite added\"}" : "{\"Error\":\"Failed to add favorite\"}";
        } catch (Exception e) {
            out = "{\"Error\":\"Error in request\"}";
        }
        return Response.ok(out).build();
    }

    @Path("delete/{favorite_id}")
    @DELETE
    @Produces(MediaType.APPLICATION_JSON)
    public Response deleteFavorite(@PathParam("favorite_id") int favorite_id) {
        String out;
        try {
            ControllerFavorites controller = new ControllerFavorites();
            boolean result = controller.deleteFavorite(favorite_id);
            out = result ? "{\"Success\":\"Favorite deleted\"}" : "{\"Error\":\"Failed to delete favorite\"}";
        } catch (Exception e) {
             out = """
                  {"Error":"Error en la peticion"}
                  """;
        }
        return Response.ok(out).build();
    }

}
