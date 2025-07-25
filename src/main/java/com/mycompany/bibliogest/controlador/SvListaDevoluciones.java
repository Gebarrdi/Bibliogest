package com.mycompany.bibliogest.controlador;

import com.mycompany.bibliogest.dao.PrestamoDAO;
import com.mycompany.bibliogest.modelo.Prestamo;
import com.mycompany.bibliogest.modelo.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/SvListaDevoluciones")
public class SvListaDevoluciones extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");

        if (usuario == null || !"bibliotecario".equalsIgnoreCase(usuario.getRol())) {
            response.sendRedirect("login.jsp");
            return;
        }

        PrestamoDAO dao = new PrestamoDAO();
        List<Prestamo> prestamosPendientes = dao.listarPendientes();

        request.setAttribute("prestamosPendientes", prestamosPendientes);
        request.getRequestDispatcher("jsp/bibliotecario/registrarDevoluciones.jsp").forward(request, response);
    }
}
