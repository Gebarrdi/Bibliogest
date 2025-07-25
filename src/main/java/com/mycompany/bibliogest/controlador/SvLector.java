package com.mycompany.bibliogest.controlador;

import com.mycompany.bibliogest.dao.PrestamoDAO;
import com.mycompany.bibliogest.modelo.Prestamo;
import com.mycompany.bibliogest.modelo.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/SvLector")
public class SvLector extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession();
        Usuario lector = (Usuario) sesion.getAttribute("usuario");

        if (lector == null || !"lector".equalsIgnoreCase(lector.getRol())) {
            response.sendRedirect("../login.jsp");
            return;
        }

        PrestamoDAO dao = new PrestamoDAO();

        List<Prestamo> prestamos = dao.listarPorLector(lector.getIdUsuario());

        System.out.println("ID del lector: " + lector.getIdUsuario());
        System.out.println("Préstamos encontrados: " + prestamos.size());

        request.setAttribute("prestamos", prestamos);
        request.getRequestDispatcher("jsp/lector/dashboardLector.jsp").forward(request, response);
    }
}


