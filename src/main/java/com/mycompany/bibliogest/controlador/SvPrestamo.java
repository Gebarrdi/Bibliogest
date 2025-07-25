package com.mycompany.bibliogest.controlador;

import com.mycompany.bibliogest.dao.LibroDAO;
import com.mycompany.bibliogest.dao.PrestamoDAO;
import com.mycompany.bibliogest.dao.UsuarioDAO;
import com.mycompany.bibliogest.modelo.Libro;
import com.mycompany.bibliogest.modelo.Prestamo;
import com.mycompany.bibliogest.modelo.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@WebServlet("/SvPrestamo")
public class SvPrestamo extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LibroDAO libroDAO = new LibroDAO();
        UsuarioDAO usuarioDAO = new UsuarioDAO();

        List<Libro> libros = libroDAO.listarTodos();
        List<Usuario> lectores = usuarioDAO.listarPorRol("lector");
        List<Usuario> bibliotecarios = usuarioDAO.listarPorRol("bibliotecario");

        request.setAttribute("libros", libros);
        request.setAttribute("lectores", lectores);
        request.setAttribute("bibliotecarios", bibliotecarios);

        request.getRequestDispatcher("jsp/bibliotecario/registrarPrestamo.jsp").forward(request, response);

        System.out.println("Libros disponibles: " + libros.size());
        System.out.println("Lectores encontrados: " + lectores.size());
        System.out.println("Bibliotecarios encontrados: " + bibliotecarios.size());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("devolver".equalsIgnoreCase(accion)) {
            String codigo = request.getParameter("codigoPrestamo");

            PrestamoDAO dao = new PrestamoDAO();
            Prestamo prestamo = dao.obtenerPorCodigo(codigo);

            if (prestamo != null) {
                Date hoy = new Date();
                LocalDate hoyLD = hoy.toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate();

                dao.registrarDevolucion(prestamo.getCodigoPrestamo(), LocalDate.now());

                LibroDAO libroDAO = new LibroDAO();
                libroDAO.sumarEjemplarDisponible(prestamo.getCodigoLibro());

                response.sendRedirect("SvPrestamo?devolucion=ok");
            } else {
                response.sendRedirect("SvPrestamo?devolucion=fail");
            }

            return;
        }

        try {
            String codigoLibro = request.getParameter("codigoLibro");
            String idLector = request.getParameter("idUsuarioLector");
            String idBibliotecario = request.getParameter("idUsuarioBibliotecario");
            String fechaPrestamoStr = request.getParameter("fechaPrestamo");
            String fechaDevolucionStr = request.getParameter("fechaDevolucionEsperada");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaPrestamo = sdf.parse(fechaPrestamoStr);
            Date fechaDevolucionEsperada = sdf.parse(fechaDevolucionStr);

            PrestamoDAO prestamoDAO = new PrestamoDAO();
            String codigoPrestamo = prestamoDAO.generarCodigoPrestamo();

            Prestamo nuevo = new Prestamo(
                    codigoPrestamo,
                    idLector,
                    idBibliotecario,
                    codigoLibro,
                    fechaPrestamo,
                    fechaDevolucionEsperada,
                    null,
                    0.0,
                    0
            );

            prestamoDAO.registrarPrestamo(nuevo);

            LibroDAO libroDAO = new LibroDAO();
            libroDAO.restarEjemplarDisponible(codigoLibro);

            response.sendRedirect("SvPrestamo?registro=ok");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("SvPrestamo?registro=fail");
        }
    }
}
