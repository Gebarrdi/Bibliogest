package com.mycompany.bibliogest.controlador;

import com.mycompany.bibliogest.dao.PrestamoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/SvRegistrarDevolucion")
public class SvRegistrarDevolucion extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String codigoPrestamo = request.getParameter("codigoPrestamo");

        if (codigoPrestamo != null && !codigoPrestamo.isEmpty()) {
            PrestamoDAO dao = new PrestamoDAO();

            dao.registrarDevolucion(codigoPrestamo, LocalDate.now());
        }

        response.sendRedirect("SvPrestamo?accion=pendientes");
    }
}
