<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.mycompany.bibliogest.modelo.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel de reportes</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">

    <style>
        body {
            background-color: #f8f9fa;
            padding-bottom: 60px;
        }
        h1, h4 {
            font-weight: bold;
        }

        div.dt-buttons {
            margin-bottom: 0rem;
        }

        .dt-button {
            margin-right: 6px;
        }
    </style>
</head>
<body>

<div class="container mt-5">

    <h1 class="mb-4 text-primary">
        Panel de reportes
    </h1>

    <div class="mb-5">
        <h4 class="text-secondary mb-3">
            Libros más prestados
        </h4>
        <div class="table-responsive">
            <table id="tablaLibros" class="table table-bordered table-hover align-middle">
                <thead class="table-primary text-center">
                    <tr>
                        <th>Código</th>
                        <th>Título</th>
                        <th>Autor</th>
                        <th>Categoría</th>
                        <th>Editorial</th>
                        <th>Año</th>
                        <th>Stock</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<Libro> librosMasPrestados = (List<Libro>) request.getAttribute("librosMasPrestados");
                    if (librosMasPrestados != null) {
                        for (Libro l : librosMasPrestados) {
                %>
                <tr>
                    <td><%= l.getCodigoLibro() %></td>
                    <td><%= l.getTitulo() %></td>
                    <td><%= l.getAutor() %></td>
                    <td><%= l.getCategoria() %></td>
                    <td><%= l.getEditorial() %></td>
                    <td class="text-center"><%= l.getAnioPublicacion() %></td>
                    <td class="text-center"><%= l.getCantidadDisponible() %> / <%= l.getCantidadTotal() %></td>
                </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

    <div class="mb-5">
        <h4 class="text-secondary mb-3">
            Usuarios más activos
        </h4>
        <div class="table-responsive">
            <table id="tablaUsuarios" class="table table-bordered table-hover align-middle">
                <thead class="table-info text-center">
                    <tr>
                        <th>ID</th>
                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th>Correo</th>
                        <th>Rol</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<Usuario> usuariosMasActivos = (List<Usuario>) request.getAttribute("usuariosMasActivos");
                    if (usuariosMasActivos != null) {
                        for (Usuario u : usuariosMasActivos) {
                %>
                <tr>
                    <td><%= u.getIdUsuario() %></td>
                    <td><%= u.getNombres() %></td>
                    <td><%= u.getApellidos() %></td>
                    <td><%= u.getCorreo() %></td>
                    <td class="text-center"><%= u.getRol().toUpperCase() %></td>
                </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

    <div class="mb-5">
        <h4 class="text-secondary mb-3">
            Préstamos vencidos
        </h4>
        <div class="table-responsive">
            <table id="tablaPrestamos" class="table table-bordered table-hover align-middle">
                <thead class="table-danger text-center">
                    <tr>
                        <th>Código de préstamo</th>
                        <th>Usuario</th>
                        <th>Libro</th>
                        <th>Fecha esperada de devolución</th>
                        <th>Días de retraso</th>
                        <th>Penalización</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<Prestamo> prestamosVencidos = (List<Prestamo>) request.getAttribute("prestamosVencidos");
                    if (prestamosVencidos != null) {
                        for (Prestamo p : prestamosVencidos) {
                %>
                <tr>
                    <td><%= p.getCodigoPrestamo() %></td>
                    <td><%= p.getIdUsuarioLector() %></td>
                    <td><%= p.getCodigoLibro() %></td>
                    <td class="text-center"><%= p.getFechaDevolucionEsperada() %></td>
                    <td class="text-center"><%= p.getDiasRetraso() %> días</td>
                    <td class="text-end">S/ <%= String.format("%.2f", p.getPenalizacion()) %></td>
                </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

    <div class="text-center mt-4">
        <a href="<%= request.getContextPath() %>/jsp/bibliotecario/dashboardBibliotecario.jsp" class="btn btn-secondary ms-2">
            Volver
        </a>
    </div>

</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.0/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>

<script>
    function inicializarTabla(idTabla) {
        $('#' + idTabla).DataTable({
            dom: '<"row mb-3"<"col-md-6 dt-buttons"B><"col-md-6 text-end"f>>rtip',
            buttons: [
                {
                    extend: 'copy',
                    className: 'btn btn-sm btn-outline-dark me-1',
                    text: '<i class="bi bi-clipboard"></i> Copiar'
                },
                {
                    extend: 'excel',
                    className: 'btn btn-sm btn-outline-success me-1',
                    text: '<i class="bi bi-file-earmark-excel"></i> Excel'
                },
                {
                    extend: 'pdf',
                    className: 'btn btn-sm btn-outline-danger me-1',
                    text: '<i class="bi bi-file-earmark-pdf"></i> PDF'
                },
                {
                    extend: 'print',
                    className: 'btn btn-sm btn-outline-primary',
                    text: '<i class="bi bi-printer"></i> Imprimir'
                }
            ],
            language: {
                url: '//cdn.datatables.net/plug-ins/1.13.4/i18n/es-ES.json'
            }
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        inicializarTabla("tablaLibros");
        inicializarTabla("tablaUsuarios");
        inicializarTabla("tablaPrestamos");
    });
</script>

</body>
</html>
