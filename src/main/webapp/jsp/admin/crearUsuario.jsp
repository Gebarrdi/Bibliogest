<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.mycompany.bibliogest.modelo.Usuario" %>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"administrador".equalsIgnoreCase(usuario.getRol())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<%@ include file="../shared/header.jsp" %>

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header bg-primary text-white">
                Registrar nuevo usuario
            </div>
            <div class="card-body">
                <form action="<%= request.getContextPath() %>/SvCrearUsuario" method="post">

                    <div class="mb-3">
                        <label for="nombres" class="form-label">Nombres</label>
                        <input type="text" class="form-control" name="nombres" id="nombres" required pattern="[A-Za-z\\s]{2,}" title="Solo letras y mínimo 2 caracteres">
                    </div>

                    <div class="mb-3">
                        <label for="apellidos" class="form-label">Apellidos</label>
                        <input type="text" class="form-control" name="apellidos" id="apellidos" required>
                    </div>

                    <div class="mb-3">
                        <label for="correo" class="form-label">Correo electrónico</label>
                        <input type="email" class="form-control" name="correo" id="correo" required>
                    </div>

                    <div class="mb-3">
                        <label for="contrasena" class="form-label">Contraseña</label>
                        <input type="password" class="form-control" name="contrasena" id="contrasena" required minlength="6">
                    </div>

                    <div class="mb-3">
                        <label for="rol" class="form-label">Rol</label>
                        <select class="form-select" name="rol" id="rol" required>
                            <option value="" disabled selected>Seleccione un rol</option>
                            <option value="lector">Lector</option>
                            <option value="bibliotecario">Bibliotecario</option>
                            <option value="administrador">Administrador</option>
                        </select>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-success">
                            Registrar
                        </button>
                        <a href="<%= request.getContextPath() %>/SvAdmin" class="btn btn-secondary ms-2">
                            Cancelar
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="../shared/footer.jsp" %>
