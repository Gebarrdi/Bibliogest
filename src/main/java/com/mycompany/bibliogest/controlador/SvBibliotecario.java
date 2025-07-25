package com.mycompany.bibliogest.controlador;

import com.mycompany.bibliogest.modelo.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/SvBibliotecario")
public class SvBibliotecario extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);

        if (sesion == null || sesion.getAttribute("usuario") == null) {
            System.out.println("Sesión no válida");
            response.sendRedirect("login.jsp");
            return;
        }

        Usuario u = (Usuario) sesion.getAttribute("usuario");

        if (!u.getRol().trim().equalsIgnoreCase("bibliotecario")) {
            System.out.println("Rol no autorizado: " + u.getRol());
            response.sendRedirect("login.jsp");
            return;
        }

        System.out.println("Bibliotecario autenticado: " + u.getNombres());

        request.getRequestDispatcher("jsp/bibliotecario/dashboardBibliotecario.jsp").forward(request, response);
    }
}
