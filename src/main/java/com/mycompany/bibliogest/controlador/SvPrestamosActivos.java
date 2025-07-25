package com.mycompany.bibliogest.controlador;

import com.mycompany.bibliogest.dao.PrestamoDAO;
import com.mycompany.bibliogest.modelo.Prestamo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/SvPrestamosActivos")
public class SvPrestamosActivos extends HttpServlet {
    PrestamoDAO dao = new PrestamoDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
               
        List<Prestamo> prestamosActivos = dao.obtenerPrestamosActivos();

        request.setAttribute("prestamosActivos", prestamosActivos);
        request.getRequestDispatcher("jsp/bibliotecario/prestamosActivos.jsp").forward(request, response);
    }
}
