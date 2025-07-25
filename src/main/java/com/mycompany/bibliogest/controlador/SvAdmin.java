package com.mycompany.bibliogest.controlador;

import com.mycompany.bibliogest.dao.UsuarioDAO;
import com.mycompany.bibliogest.modelo.Usuario;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet("/SvAdmin")
public class SvAdmin extends HttpServlet {

    UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Usuario> lista = usuarioDAO.listarUsuarios();

        request.setAttribute("listaUsuarios", lista);
        request.getRequestDispatcher("/jsp/admin/dashboardAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String accion = request.getParameter("accion");
        String idUsuario = request.getParameter("idUsuario");

        if ("eliminar".equals(accion)) {
            usuarioDAO.eliminarUsuario(idUsuario);
        } else if ("cambiarRol".equals(accion)) {
            String nuevoRol = request.getParameter("nuevoRol");
            usuarioDAO.cambiarRol(idUsuario, nuevoRol);
        }

        response.sendRedirect("SvAdmin");
    }
}
