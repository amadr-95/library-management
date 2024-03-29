package com.biblioteca.controladores;

import com.biblioteca.model.entidades.Libro;
import com.biblioteca.servicios.ServicioLibro;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "Inicio", urlPatterns = {"/Inicio"})
public class Inicio extends HttpServlet {

    public Inicio() {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String vista = "/index.jsp";
        List<Libro> libros = ServicioLibro.listarLibros();
        request.setAttribute("libros", libros);
        getServletContext().getRequestDispatcher(vista).forward(request, response);
    }
}