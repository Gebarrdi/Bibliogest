<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.mycompany.bibliogest.modelo.Usuario" %>

<%
    HttpSession sesion = request.getSession(false);
    if (sesion != null && sesion.getAttribute("usuario") != null) {
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");

        if ("administrador".equalsIgnoreCase(usuario.getRol())) {
            response.sendRedirect("jsp/admin/dashboardAdmin.jsp");
        } else if ("bibliotecario".equalsIgnoreCase(usuario.getRol())) {
            response.sendRedirect("jsp/bibliotecario/dashboardBibliotecario.jsp");
        } else {
            response.sendRedirect("jsp/lector/dashboardLector.jsp");
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio - BiblioGest</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center" style="height: 100vh;">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-6">
            <div class="card shadow">
                <div class="card-header bg-primary text-white text-center">
                    <h3 class="mb-0">BiblioGest</h3>
                </div>
                <div class="card-body text-center">
                    <p class="lead mb-4">Sistema de gestión de préstamos de biblioteca.</p>

                    <div class="d-grid gap-3">
                        <a href="login.jsp" class="btn btn-outline-primary btn-lg">
                            Iniciar sesión
                        </a>
                        <a href="jsp/lector/registroLector.jsp" class="btn btn-success btn-lg">
                            Registrarse como lector
                        </a>
                    </div>
                </div>
                <div class="card-footer text-center text-muted">
                    Desarrollado por el equipo de Ingeniería de Sistemas e Informatica<br> Desarrollo Web Integrado
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
