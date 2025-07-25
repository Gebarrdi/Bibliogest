package com.mycompany.bibliogest.controlador;

import com.mycompany.bibliogest.dao.ReporteDAO;
import com.mycompany.bibliogest.modelo.Libro;
import com.mycompany.bibliogest.modelo.Usuario;
import com.mycompany.bibliogest.modelo.Prestamo;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/SvReporte")
public class SvReporte extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        ReporteDAO dao = new ReporteDAO();

        List<Libro> librosMasPrestados = dao.obtenerLibrosMasPrestados();
        List<Usuario> usuariosMasActivos = dao.obtenerUsuariosMasActivos();
        List<Prestamo> prestamosVencidos = dao.obtenerPrestamosVencidos();

        request.setAttribute("librosMasPrestados", librosMasPrestados);
        request.setAttribute("usuariosMasActivos", usuariosMasActivos);
        request.setAttribute("prestamosVencidos", prestamosVencidos);

        request.getRequestDispatcher("jsp/bibliotecario/reportes.jsp").forward(request, response);
    }
}
