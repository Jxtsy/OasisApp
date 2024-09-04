/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.team.restoasis.rest;

import jakarta.ws.rs.FormParam;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.team.restoasis.controller.ControllerAuth;
import org.team.restoasis.model.User;

/**
 *
 * @author aj898
 */
@Path("auth")
public class RestAuth {

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Path("login")
    public Response login(@QueryParam("username") String username,
            @QueryParam("password") String password) {
        String out = "";
        try {
            ControllerAuth cu = new ControllerAuth();
            User user = cu.getByUsernameAndPassword(username, password);
            if (user != null) {
                System.out.println(username);
                out = """
                 {"userId": "%d"}
                 """.formatted(user.getUser_id());
            } else {
                return Response.status(401).build();
            }
        } catch (Exception e) {
            out = """
             {"error":"%s"}
             """;
            out = String.format(out, e.getMessage());
        }
        return Response.ok(out).build();
    }

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Path("save")
    public Response Save(@FormParam("name") String name,
            @FormParam("username") String username,
            @FormParam("email") String email,
            @FormParam("password") String password,
            @FormParam("address") String address,
            @FormParam("phone") String phone) {
        String out = "";
        try {
            //System.out.println(use);
            User user = new User(0, name, username, email, password, address, phone);
            ControllerAuth us = new ControllerAuth();
            us.save(user);
            out = """
                     {"Response":"Insert correct"}
                     """;
        } catch (Exception e) {
            out = """
                 {"Response":"Error to insert"}
                 """;
        }
        return Response.ok(out).build();

    }
}
