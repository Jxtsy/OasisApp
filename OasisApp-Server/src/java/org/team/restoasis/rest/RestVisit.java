/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.team.restoasis.rest;

import com.google.gson.Gson;
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
import org.team.restoasis.controller.ControllerVisit;

import org.team.restoasis.model.Visit;

/**
 *
 * @author aj898
 */
@Path("visit")
public class RestVisit {

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Path("save")
    public Response Save(@FormParam("user_id") int user_id,
            @FormParam("property_id") int property_id,
            @FormParam("visit_date") String visit_date) {
        String out = "";
        try {
            //System.out.println(use);
            Visit visit = new Visit(0, user_id, property_id, visit_date);
            ControllerVisit us = new ControllerVisit();
            us.save(visit);
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

    @Path("getVisit")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getVisit() {
        String out = "";
        Gson gson = new Gson();
        try {
            ControllerVisit cu = new ControllerVisit();
            List<Visit> list = cu.getVisit();
            out = gson.toJson(list);
        } catch (Exception e) {
            out = """
                  {"Error":"Error en la peticion"}
                  """;
        }
        return Response.ok(out).build();
    }

    @Path("delete/{visiti_id}")
    @DELETE
    @Produces(MediaType.APPLICATION_JSON)
    public Response deleteVisit(@PathParam("visit_id") int visit_id) {
        String out;
        try {
            ControllerVisit controller = new ControllerVisit();
            boolean result = controller.deleteVisit(visit_id);
            out = result ? "{\"Success\":\"Favorite deleted\"}" : "{\"Error\":\"Failed to delete favorite\"}";
        } catch (Exception e) {
            out = """
                  {"Error":"Error en la peticion"}
                  """;
        }
        return Response.ok(out).build();
    }
}
