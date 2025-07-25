<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.bibliogest.modelo.Prestamo" %>
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
    <div class="col-md-11">
        <div class="card">
            <div class="card-header bg-secondary text-white">
                <i class="bi bi-list-check"></i> Préstamos registrados
            </div>
            <div class="card-body">

                <table class="table table-striped table-bordered table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Código</th>
                            <th>Lector</th>
                            <th>Bibliotecario</th>
                            <th>Libro</th>
                            <th>Fecha de préstamo</th>
                            <th>Fecha esperada de devolución</th>
                            <th>Fecha de devolución</th>
                            <th>Penalidad</th>
                            <th>Días Retraso</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        List<Prestamo> prestamos = (List<Prestamo>) request.getAttribute("prestamos");
                        if (prestamos != null && !prestamos.isEmpty()) {
                            for (Prestamo p : prestamos) {
                    %>
                        <tr>
                            <td><%= p.getCodigoPrestamo() %></td>
                            <td><%= p.getIdUsuarioSolicitante() %></td>
                            <td><%= p.getIdBibliotecario() %></td>
                            <td><%= p.getCodigoLibro() %></td>
                            <td><%= p.getFechaPrestamo() %></td>
                            <td><%= p.getFechaDevolucionEsperada() %></td>
                            <td><%= p.getFechaDevolucionReal() != null ? p.getFechaDevolucionReal() : "-" %></td>
                            <td>S/ <%= String.format("%.2f", p.getPenalizacion()) %></td>
                            <td><%= p.getDiasRetraso() %> días</td>
                            <td>
                            <%
                                if (p.getFechaDevolucionReal() == null) {
                            %>
                                <form action="<%= request.getContextPath() %>/SvPrestamo" method="post" class="d-inline">
                                    <input type="hidden" name="accion" value="devolver">
                                    <input type="hidden" name="codigoPrestamo" value="<%= p.getCodigoPrestamo() %>">
                                    <button type="submit" class="btn btn-warning btn-sm">
                                        <i class="bi bi-box-arrow-in-down"></i> Devolver
                                    </button>
                                </form>
                            <%
                                } else {
                            %>
                                <span class="badge bg-success">Devuelto</span>
                            <%
                                }
                            %>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="10" class="text-center">No se encontraron préstamos.</td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>

                <div class="text-center mt-4">
                    <a href="<%= request.getContextPath() %>/jsp/bibliotecario/dashboardBibliotecario.jsp" class="btn btn-secondary">
                        <i class="bi bi-arrow-left-circle"></i> Volver
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../shared/footer.jsp" %>
