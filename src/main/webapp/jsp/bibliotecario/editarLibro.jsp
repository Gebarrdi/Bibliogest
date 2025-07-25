<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.mycompany.bibliogest.modelo.Libro" %>

<%
    Libro libro = (Libro) request.getAttribute("libro");
    if (libro == null) {
        response.sendRedirect("../../SvLibros");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar libro</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="mb-4 text-primary">
        Editar libro
    </h2>

    <form action="../../SvEditarLibro" method="post" class="card p-4 shadow-sm">

        <div class="row mb-3">
            <div class="col-md-4">
                <label for="codigoLibro" class="form-label">Código</label>
                <input type="text" name="codigoLibro" id="codigoLibro" class="form-control" 
                       value="<%= libro.getCodigoLibro() %>" readonly>
            </div>
            <div class="col-md-8">
                <label for="titulo" class="form-label">Título</label>
                <input type="text" name="titulo" id="titulo" class="form-control" 
                       value="<%= libro.getTitulo() %>" required>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label for="autor" class="form-label">Autor</label>
                <input type="text" name="autor" id="autor" class="form-control" 
                       value="<%= libro.getAutor() %>" required>
            </div>
            <div class="col-md-6">
                <label for="categoria" class="form-label">Categoría</label>
                <input type="text" name="categoria" id="categoria" class="form-control" 
                       value="<%= libro.getCategoria() %>" required>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label for="editorial" class="form-label">Editorial</label>
                <input type="text" name="editorial" id="editorial" class="form-control" 
                       value="<%= libro.getEditorial() %>" required>
            </div>
            <div class="col-md-6">
                <label for="isbn" class="form-label">ISBN</label>
                <input type="text" name="isbn" id="isbn" class="form-control" 
                       value="<%= libro.getIsbn() %>" required>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-4">
                <label for="anioPublicacion" class="form-label">Año de publicación</label>
                <input type="number" name="anioPublicacion" id="anioPublicacion" class="form-control" 
                       value="<%= libro.getAnioPublicacion() %>" required>
            </div>
            <div class="col-md-4">
                <label for="cantidadTotal" class="form-label">Cantidad total</label>
                <input type="number" name="cantidadTotal" id="cantidadTotal" class="form-control" 
                       value="<%= libro.getCantidadTotal() %>" required>
            </div>
            <div class="col-md-4">
                <label for="cantidadDisponible" class="form-label">Cantidad disponible</label>
                <input type="number" name="cantidadDisponible" id="cantidadDisponible" class="form-control" 
                       value="<%= libro.getCantidadDisponible() %>" required>
            </div>
        </div>

        <div class="d-flex justify-content-between">
            <a href="<%= request.getContextPath() %>/SvLibros" class="btn btn-secondary">
                Cancelar
            </a>    
            <button type="submit" class="btn btn-primary">
                Guardar cambios
            </button>
        </div>
    </form>
</div>

</body>
</html>
