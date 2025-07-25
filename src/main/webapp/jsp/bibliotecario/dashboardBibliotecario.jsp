<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.mycompany.bibliogest.modelo.Usuario" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"bibliotecario".equalsIgnoreCase(usuario.getRol())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<%@ include file="../shared/header.jsp" %>

<div class="text-center mb-4">
    <h1 class="text-success fw-bold">Panel del bibliotecario</h1>
    <h5 class="text-muted">Bienvenido, <%= usuario.getNombres() %> <%= usuario.getApellidos() %></h5>
</div>

<div class="row justify-content-center">
    <div class="col-md-8">

        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                Datos de usuario:
            </div>
            <div class="card-body">
                <p><strong>Nombre:</strong> <%= usuario.getNombres() %> <%= usuario.getApellidos() %></p>
                <p><strong>Correo:</strong> <%= usuario.getCorreo() %></p>
            </div>
        </div>

        <div class="card">
            <div class="card-header bg-dark text-white">
                Opciones
            </div>
            <div class="card-body">
                <ul class="list-group">
                    <li class="list-group-item">
                        <a class="text-decoration-none" href="<%= request.getContextPath() %>/SvPrestamo">
                            Registrar préstamo
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a class="text-decoration-none" href="<%= request.getContextPath() %>/jsp/bibliotecario/agregarLibro.jsp">
                            Agregar nuevo libro
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a class="text-decoration-none" href="<%= request.getContextPath() %>/SvLibros">
                            Catálogo de libros
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a class="text-decoration-none" href="<%= request.getContextPath() %>/SvPrestamosActivos">
                            Préstamos activos
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a class="text-decoration-none" href="<%= request.getContextPath() %>/SvReporte">
                            Reportes de préstamo
                        </a>
                    </li>
                    
                    <li class="list-group-item">
                        <a class="text-decoration-none" href="<%= request.getContextPath() %>/SvListaDevoluciones">
                            Registrar devolución
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="text-center mt-4">
            <a href="<%= request.getContextPath() %>/SvLogout" class="btn btn-outline-danger">
                Cerrar sesión
            </a>
        </div>
    </div>
</div>

<%@ include file="../shared/footer.jsp" %>
