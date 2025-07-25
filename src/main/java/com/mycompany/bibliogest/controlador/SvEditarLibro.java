package com.mycompany.bibliogest.controlador;

import com.mycompany.bibliogest.dao.LibroDAO;
import com.mycompany.bibliogest.modelo.Libro;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/SvEditarLibro")
public class SvEditarLibro extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String codigo = request.getParameter("codigo");

        LibroDAO dao = new LibroDAO();
        Libro libro = dao.buscarPorCodigo(codigo);

        if (libro != null) {
            request.setAttribute("libro", libro);
            request.getRequestDispatcher("jsp/bibliotecario/editarLibro.jsp").forward(request, response);
        } else {
            response.sendRedirect("SvLibros");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String codigo = request.getParameter("codigoLibro");
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        String categoria = request.getParameter("categoria");
        String editorial = request.getParameter("editorial");
        String isbn = request.getParameter("isbn");
        int anio = Integer.parseInt(request.getParameter("anioPublicacion"));
        int total = Integer.parseInt(request.getParameter("cantidadTotal"));
        int disponible = Integer.parseInt(request.getParameter("cantidadDisponible"));

        Libro libroActualizado = new Libro(codigo, titulo, autor, categoria, editorial, isbn, anio, total, disponible);

        LibroDAO dao = new LibroDAO();
        dao.actualizarLibro(libroActualizado);

        request.getSession().setAttribute("mensaje", "editado");
        response.sendRedirect("SvLibros");
    }
}
