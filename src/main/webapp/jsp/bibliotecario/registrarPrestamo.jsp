<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.bibliogest.modelo.Libro" %>
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
            <div class="card-header bg-dark text-white">
                Registrar nuevo préstamo
            </div>
            <div class="card-body">
                <form action="<%= request.getContextPath() %>/SvPrestamo" method="post">
                    <!-- LIBRO -->
                    <div class="mb-3">
                        <label for="codigoLibro" class="form-label">Libro a prestar</label>
                        <select class="form-select" name="codigoLibro" required>
                            <option value="">Selecciona un libro</option>
                            <%
                                List<Libro> libros = (List<Libro>) request.getAttribute("libros");
                                if (libros != null && !libros.isEmpty()) {
                                    for (Libro libro : libros) {
                                        if (libro.getCantidadDisponible() > 0) {
                            %>
                            <option value="<%= libro.getCodigoLibro() %>">
                                <%= libro.getTitulo() %> (Disponibles: <%= libro.getCantidadDisponible() %>)
                            </option>
                            <%
                                        }
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="idUsuarioLector" class="form-label">Lector</label>
                        <select class="form-select" name="idUsuarioLector" required>
                            <option value="">-- Selecciona un lector --</option>
                            <%
                                List<Usuario> lectores = (List<Usuario>) request.getAttribute("lectores");
                                if (lectores != null && !lectores.isEmpty()) {
                                    for (Usuario u : lectores) {
                            %>
                            <option value="<%= u.getIdUsuario() %>">
                                <%= u.getNombres() %> <%= u.getApellidos() %>
                            </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="idUsuarioBibliotecario" class="form-label">Bibliotecario que registra</label>
                        <select class="form-select" name="idUsuarioBibliotecario" required>
                            <option value="">Selecciona bibliotecario</option>
                            <%
                                List<Usuario> bibliotecarios = (List<Usuario>) request.getAttribute("bibliotecarios");
                                if (bibliotecarios != null && !bibliotecarios.isEmpty()) {
                                    for (Usuario u : bibliotecarios) {
                            %>
                            <option value="<%= u.getIdUsuario() %>">
                                <%= u.getNombres() %> <%= u.getApellidos() %>
                            </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="fechaPrestamo" class="form-label">Fecha de préstamo</label>
                        <input type="date" class="form-control" name="fechaPrestamo"
                               value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" readonly>
                    </div>

                    <div class="mb-3">
                        <label for="fechaDevolucionEsperada" class="form-label">Fecha esperada de devolución</label>
                        <input type="date" class="form-control" name="fechaDevolucionEsperada" required>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-success">
                            Registrar préstamo
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
