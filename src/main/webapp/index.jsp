<%@ page import="com.mycompany.bibliogest.modelo.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession sesion = request.getSession(false);
    if (sesion != null && sesion.getAttribute("usuario") != null) {
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");

        if ("administrador".equalsIgnoreCase(usuario.getRol())) {
            response.sendRedirect("jsp/admin/dashboardAdmin.jsp");
        } else if ("bibliotecario".equalsIgnoreCase(usuario.getRol())) {
            response.sendRedirect("jsp/bibliotecario/dashboardBibliotecario.jsp");
        } else if ("lector".equalsIgnoreCase(usuario.getRol())) {
            response.sendRedirect("jsp/lector/dashboardLector.jsp");
        } else {
            response.sendRedirect("login.jsp");
        }
    } else {
        response.sendRedirect("login.jsp");
    }
%>
