<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.bibliogest.modelo.Prestamo" %>
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

    List<Prestamo> prestamos = (List<Prestamo>) request.getAttribute("prestamosPendientes");
%>

<%@ include file="../shared/header.jsp" %>

<div class="container mt-5">
    <h2 class="text-primary mb-4">
        Registrar devolución de libros
    </h2>

    <div class="table-responsive">
        <table class="table table-striped table-bordered align-middle shadow-sm">
            <thead class="table-dark text-center">
                <tr>
                    <th>Código</th>
                    <th>Lector</th>
                    <th>Libro</th>
                    <th>Fecha de préstamo</th>
                    <th>Fecha esperada de devolución</th>
                    <th>Días de retraso</th>
                    <th>Penalización (S/.)</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody>
            <%
                if (prestamos != null && !prestamos.isEmpty()) {
                    for (Prestamo p : prestamos) {
            %>
                <tr>
                    <td><%= p.getCodigoPrestamo() %></td>
                    <td><%= p.getIdUsuarioLector() %></td>
                    <td><%= p.getCodigoLibro() %></td>
                    <td><%= p.getFechaPrestamo() %></td>
                    <td><%= p.getFechaDevolucionEsperada() %></td>
                    <td class="text-center"><%= p.getDiasRetraso() %></td>
                    <td class="text-center">S/ <%= String.format("%.2f", p.getPenalizacion()) %></td>
                    <td class="text-center">
                        <form action="<%= request.getContextPath() %>/SvRegistrarDevolucion" method="post">
                            <input type="hidden" name="codigoPrestamo" value="<%= p.getCodigoPrestamo() %>">
                            <button type="submit" class="btn btn-success btn-sm">
                                Devolver
                            </button>
                        </form>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="8" class="text-center text-muted">No hay préstamos pendientes por devolución.</td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <div class="mt-4">
        <a href="<%= request.getContextPath() %>/jsp/bibliotecario/dashboardBibliotecario.jsp" class="btn btn-secondary">
            Volver
        </a>
    </div>
</div>

<%@ include file="../shared/footer.jsp" %>
