<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.bibliogest.modelo.Usuario" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"administrador".equalsIgnoreCase(usuario.getRol())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Usuario> usuarios = (List<Usuario>) request.getAttribute("listaUsuarios");
%>

<%@ include file="../shared/header.jsp" %>

<div class="text-center mb-4">
    <h1 class="text-primary fw-bold">Bienvenido, <%= usuario.getNombres() %> <%= usuario.getApellidos() %> (Administrador)</h1>
    <p class="text-muted">Página de gestión de usuarios de Bibliogest.</p>
</div>

<div class="text-end mb-3">
    <a href="<%= request.getContextPath() %>/jsp/admin/crearUsuario.jsp" class="btn btn-success">
        Crear nuevo usuario
    </a>
</div>

<div class="card">
    <div class="card-header bg-secondary text-white">
        Lista de usuarios
    </div>
    <div class="card-body">
        <table class="table table-striped table-hover table-bordered align-middle">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Correo</th>
                    <th>Rol</th>
                    <th class="text-center">Acciones</th>
                </tr>
            </thead>
            <tbody>
            <%
                if (usuarios != null) {
                    for (Usuario u : usuarios) {
            %>
                <tr>
                    <td><%= u.getIdUsuario() %></td>
                    <td><%= u.getNombres() %></td>
                    <td><%= u.getApellidos() %></td>
                    <td><%= u.getCorreo() %></td>
                    <td><%= u.getRol() %></td>
                    <td class="text-center">
                        <div class="d-flex justify-content-center gap-2">
                           
                            <form action="<%= request.getContextPath() %>/SvAdmin" method="post">
                                <input type="hidden" name="accion" value="eliminar">
                                <input type="hidden" name="idUsuario" value="<%= u.getIdUsuario() %>">
                                <button type="submit" class="btn btn-danger btn-sm">
                                    Eliminar
                                </button>
                            </form>

                            <form action="<%= request.getContextPath() %>/SvAdmin" method="post" class="d-flex">
                                <input type="hidden" name="accion" value="cambiarRol">
                                <input type="hidden" name="idUsuario" value="<%= u.getIdUsuario() %>">
                                <select name="nuevoRol" class="form-select form-select-sm me-2">
                                    <option value="lector" <%= u.getRol().equals("lector") ? "selected" : "" %>>Lector</option>
                                    <option value="bibliotecario" <%= u.getRol().equals("bibliotecario") ? "selected" : "" %>>Bibliotecario</option>
                                    <option value="administrador" <%= u.getRol().equals("administrador") ? "selected" : "" %>>Administrador</option>
                                </select>
                                <button type="submit" class="btn btn-primary btn-sm">
                                    Actualizar
                                </button>
                            </form>

                        </div>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="6" class="text-center text-danger">
                        No se encontraron usuarios. Asegúrese de ingresar desde <code>/SvAdmin</code>.
                    </td>
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

<%@ include file="../shared/footer.jsp" %>
