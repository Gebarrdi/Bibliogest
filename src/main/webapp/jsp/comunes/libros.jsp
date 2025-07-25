<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.mycompany.bibliogest.modelo.Libro" %>
<%@ page import="java.util.List" %>
<%
    List<Libro> libros = (List<Libro>) request.getAttribute("libros");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de libros</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-primary">
            Catálogo de libros
        </h2>
    </div>

    <% String mensaje = (String) session.getAttribute("mensaje"); %>
    <% if (mensaje != null) { %>
        <div class="alert alert-<%= mensaje.equals("ok") ? "success" : (mensaje.equals("editado") ? "info" : "danger") %> alert-dismissible fade show" role="alert">
            <i class="bi <%= mensaje.equals("ok") ? "bi-check-circle-fill" : (mensaje.equals("editado") ? "bi-pencil-fill" : "bi-trash-fill") %>"></i>
            <strong>
                <%= mensaje.equals("ok") ? "Libro registrado correctamente." :
                     mensaje.equals("editado") ? "Libro actualizado con éxito." :
                     "Libro eliminado correctamente." %>
            </strong>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Cerrar"></button>
        </div>
        <% session.removeAttribute("mensaje"); %>
    <% } %>

    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle shadow-sm">
            <thead class="table-primary text-center">
                <tr>
                    <th>Código</th>
                    <th>Título</th>
                    <th>Autor</th>
                    <th>Categoría</th>
                    <th>Editorial</th>
                    <th>ISBN</th>
                    <th>Año</th>
                    <th>Total</th>
                    <th>Disponible</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
            <% if (libros != null && !libros.isEmpty()) {
                for (Libro libro : libros) { %>
            <tr>
                <td><%= libro.getCodigoLibro() %></td>
                <td><%= libro.getTitulo() %></td>
                <td><%= libro.getAutor() %></td>
                <td><%= libro.getCategoria() %></td>
                <td><%= libro.getEditorial() %></td>
                <td><%= libro.getIsbn() %></td>
                <td class="text-center"><%= libro.getAnioPublicacion() %></td>
                <td class="text-center"><%= libro.getCantidadTotal() %></td>
                <td class="text-center"><%= libro.getCantidadDisponible() %></td>
                <td class="text-center">
                    <a href="SvEditarLibro?codigo=<%= libro.getCodigoLibro() %>" class="btn btn-sm btn-warning me-1">
                        <i class="bi bi-pencil-fill"></i>
                    </a>
                    <a href="SvEliminarLibro?codigo=<%= libro.getCodigoLibro() %>" class="btn btn-sm btn-danger"
                       onclick="return confirm('¿Estás seguro de eliminar este libro?');">
                        <i class="bi bi-trash-fill"></i>
                    </a>
                </td>
            </tr>
            <% }
            } else { %>
            <tr>
                <td colspan="10" class="text-center text-muted">No hay libros registrados.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
            
    <div class="text-center mt-4">
        <a href="<%= request.getContextPath() %>/jsp/bibliotecario/dashboardBibliotecario.jsp" class="btn btn-secondary ms-2">
            Volver
        </a>
    </div>             
            
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
