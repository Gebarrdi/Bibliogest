package com.mycompany.bibliogest.controlador;

import com.mycompany.bibliogest.dao.LibroDAO;
import com.mycompany.bibliogest.modelo.Libro;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/SvLibros")
public class SvLibros extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        LibroDAO dao = new LibroDAO();
        List<Libro> listaLibros = dao.listarTodos();

        request.setAttribute("libros", listaLibros);
        request.getRequestDispatcher("jsp/comunes/libros.jsp").forward(request, response);
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

        Libro nuevoLibro = new Libro(codigo, titulo, autor, categoria, editorial, isbn, anio, total, disponible);

        LibroDAO dao = new LibroDAO();
        dao.agregarLibro(nuevoLibro);

        request.getSession().setAttribute("mensaje", "ok");
        response.sendRedirect("SvLibros");
    }
}
