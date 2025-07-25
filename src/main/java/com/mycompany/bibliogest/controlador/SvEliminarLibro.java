package com.mycompany.bibliogest.controlador;

import com.mycompany.bibliogest.dao.LibroDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/SvEliminarLibro")
public class SvEliminarLibro extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String codigo = request.getParameter("codigo");

        if (codigo != null && !codigo.trim().isEmpty()) {
            LibroDAO dao = new LibroDAO();
            dao.eliminarLibroPorCodigo(codigo);

            request.getSession().setAttribute("mensaje", "eliminado");
        }

        response.sendRedirect("SvLibros");
    }
}