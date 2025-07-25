<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.bibliogest.modelo.Prestamo" %>
<%@ page import="com.mycompany.bibliogest.modelo.Usuario" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"lector".equalsIgnoreCase(usuario.getRol())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Prestamo> prestamos = (List<Prestamo>) request.getAttribute("prestamos");
%>

<%@ include file="../shared/header.jsp" %>

<div class="text-center mb-4">
    <h1 class="text-primary fw-bold">Bienvenido, <%= usuario.getNombres() %> <%= usuario.getApellidos() %></h1>
    <p class="text-muted">Zona de lector</p>
</div>

<div class="row justify-content-center">
    <div class="col-md-11">
        <div class="card">
            <div class="card-header bg-success text-white">
                Mis préstamos
            </div>
            <div class="card-body">

                <table class="table table-bordered table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Código</th>
                            <th>Libro</th>
                            <th>Fecha de réstamo</th>
                            <th>Fecha esperada de devolución</th>
                            <th>Fecha de devolución</th>
                            <th>Días de retraso</th>
                            <th>Penalización (S/.)</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        if (prestamos != null && !prestamos.isEmpty()) {
                            for (Prestamo p : prestamos) {
                    %>
                        <tr>
                            <td><%= p.getCodigoPrestamo() %></td>
                            <td><%= p.getCodigoLibro() %></td>
                            <td><%= p.getFechaPrestamo() %></td>
                            <td><%= p.getFechaDevolucionEsperada() %></td>
                            <td><%= p.getFechaDevolucionReal() != null ? p.getFechaDevolucionReal() : "-" %></td>
                            <td><%= p.getDiasRetraso() %> días</td>
                            <td>S/ <%= String.format("%.2f", p.getPenalizacion()) %></td>
                            <td>
                                <%= p.getFechaDevolucionReal() != null ?
                                        "<span class='badge bg-success'>Devuelto</span>" :
                                        "<span class='badge bg-warning text-dark'>Pendiente</span>" %>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="8" class="text-center">No tienes préstamos registrados.</td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>

                <div class="text-center mt-4">
                    <a href="<%= request.getContextPath() %>/SvLogout" class="btn btn-outline-danger">
                        Cerrar sesión
                    </a>
                </div>

            </div>
        </div>
    </div>
</div>

<%@ include file="../shared/footer.jsp" %>
