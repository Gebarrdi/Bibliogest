package com.mycompany.bibliogest.controlador;

import com.mycompany.bibliogest.dao.UsuarioDAO;
import com.mycompany.bibliogest.modelo.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/SvLogin")
public class SvLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");

        UsuarioDAO dao = new UsuarioDAO();
        Usuario u = dao.obtenerPorCredenciales(correo, contrasena);

        if (u != null) {
            System.out.println("Usuario autenticado: " + u.getCorreo() + " | Rol: " + u.getRol());

            HttpSession sesion = request.getSession();
            sesion.setAttribute("usuario", u);

            String rol = u.getRol().toLowerCase();
            System.out.println("Rol detectado: " + rol);

            switch (rol) {
                case "administrador":
                    System.out.println("Redirigiendo a SvAdmin");
                    response.sendRedirect("SvAdmin");
                    break;
                case "bibliotecario":
                    System.out.println("Redirigiendo a SvBibliotecario");
                    response.sendRedirect("SvBibliotecario");
                    break;
                case "lector":
                    System.out.println("Redirigiendo a SvLector");
                    response.sendRedirect("SvLector");
                    break;
                default:
                    System.out.println("Rol no reconocido: " + rol);
                    request.setAttribute("error", "Rol no reconocido");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    break;
            }

        } else {
            System.out.println("Credenciales incorrectas: " + correo);
            request.setAttribute("error", "Credenciales incorrectas");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}

