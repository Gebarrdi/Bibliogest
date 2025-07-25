<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.mycompany.bibliogest.modelo.Usuario" %>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"bibliotecario".equalsIgnoreCase(usuario.getRol())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<%@ include file="../shared/header.jsp" %>

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header bg-primary text-white">
                Registrar nuevo Libro
            </div>
            <div class="card-body">
                <form action="<%= request.getContextPath() %>/SvLibros" method="post">

                    <div class="mb-3">
                        <label for="codigoLibro" class="form-label">Código</label>
                        <input type="text" class="form-control" id="codigoLibro" name="codigoLibro" required>
                    </div>

                    <div class="mb-3">
                        <label for="titulo" class="form-label">Título</label>
                        <input type="text" class="form-control" id="titulo" name="titulo" required>
                    </div>

                    <div class="mb-3">
                        <label for="autor" class="form-label">Autor</label>
                        <input type="text" class="form-control" id="autor" name="autor" required>
                    </div>

                    <div class="mb-3">
                        <label for="categoria" class="form-label">Categoría</label>
                        <input type="text" class="form-control" id="categoria" name="categoria" required>
                    </div>

                    <div class="mb-3">
                        <label for="editorial" class="form-label">Editorial</label>
                        <input type="text" class="form-control" id="editorial" name="editorial" required>
                    </div>

                    <div class="mb-3">
                        <label for="isbn" class="form-label">ISBN</label>
                        <input type="text" class="form-control" id="isbn" name="isbn" required>
                    </div>

                    <div class="mb-3">
                        <label for="anioPublicacion" class="form-label">Año de publicación</label>
                        <input type="number" class="form-control" id="anioPublicacion" name="anioPublicacion" min="1900" max="2025" required>
                    </div>

                    <div class="mb-3">
                        <label for="cantidadTotal" class="form-label">Cantidad total</label>
                        <input type="number" class="form-control" id="cantidadTotal" name="cantidadTotal" min="1" required>
                    </div>

                    <div class="mb-3">
                        <label for="cantidadDisponible" class="form-label">Cantidad disponible</label>
                        <input type="number" class="form-control" id="cantidadDisponible" name="cantidadDisponible" min="0" required>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-success">
                            Agregar libro
                        </button>
                        <a href="<%= request.getContextPath() %>/jsp/bibliotecario/dashboardBibliotecario.jsp" class="btn btn-secondary ms-2">
                            Volver
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="../shared/footer.jsp" %>
