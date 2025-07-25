package com.mycompany.bibliogest.controlador;

import com.mycompany.bibliogest.dao.UsuarioDAO;
import com.mycompany.bibliogest.modelo.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/SvCrearUsuario")
public class SvCrearUsuario extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        String rol = request.getParameter("rol");

        Usuario nuevo = new Usuario();
        nuevo.setNombres(nombres);
        nuevo.setApellidos(apellidos);
        nuevo.setCorreo(correo);
        nuevo.setContrasena(contrasena);
        nuevo.setRol(rol);

        UsuarioDAO dao = new UsuarioDAO();
        dao.registrarUsuario(nuevo);

        response.sendRedirect("SvAdmin");
    }
}
