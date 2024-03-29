package com.biblioteca.controladores.socio;

import com.biblioteca.model.entidades.Libro;
import com.biblioteca.model.entidades.Prestamo;
import com.biblioteca.servicios.ServicioLibro;
import com.biblioteca.servicios.ServicioPrestamo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet(name = "DevolucionPrestamo", urlPatterns = {"/socio/DevolucionPrestamo"})
public class DevolucionPrestamo extends HttpServlet {

    public DevolucionPrestamo() {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vista = "/socio/gestionPrestamos.jsp";
        String id = request.getParameter("id");
        if(id != null && !id.isEmpty()){
            long prestamoId = Long.parseLong(id);
            Prestamo prestamo = ServicioPrestamo.obtenerPrestamoPorId(prestamoId);

            ServicioPrestamo.establecerFechaDevolucion(prestamoId, LocalDate.now());

            //incrementar la cantidad de libros disponibles
            Libro libro = prestamo.getLibro();
            libro.setNumeroEjemplares(libro.getNumeroEjemplares() + 1);
            ServicioLibro.actualizarLibro(libro);

            response.sendRedirect("GestionPrestamos");
            return;
        }
        request.getRequestDispatcher(vista).forward(request, response);
    }
}
