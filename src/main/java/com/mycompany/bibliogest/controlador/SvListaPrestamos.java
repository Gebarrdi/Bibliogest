package com.mycompany.bibliogest.controlador;

import com.mycompany.bibliogest.dao.PrestamoDAO;
import com.mycompany.bibliogest.modelo.Prestamo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/SvListaPrestamos")
public class SvListaPrestamos extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrestamoDAO dao = new PrestamoDAO();
        List<Prestamo> prestamos = dao.listarTodos();

        request.setAttribute("prestamos", prestamos);
        request.getRequestDispatcher("jsp/bibliotecario/listaPrestamos.jsp").forward(request, response);
    }
}
