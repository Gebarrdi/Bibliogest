<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<% 
    String correo = request.getParameter("correo");
    String pass = request.getParameter("contrasena");
    System.out.println("🧪 Desde JSP: " + correo + " | " + pass);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Iniciar Sesión - BiblioGest</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center" style="height: 100vh;">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow">
                <div class="card-header text-white bg-primary text-center">
                    <h4>Iniciar sesión</h4>
                </div>
                <div class="card-body">
                    <form action="SvLogin" method="post">
                        <div class="mb-3">
                            <label for="correo" class="form-label">Correo electrónico</label>
                            <input type="email" class="form-control" name="correo" required>
                        </div>
                        <div class="mb-3">
                            <label for="contrasena" class="form-label">Contraseña</label>
                            <input type="password" class="form-control" name="contrasena" required>
                        </div>
                        <button type="submit" class="btn btn-success w-100">
                            Ingresar
                        </button>
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger mt-3">
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                    </form>
                </div>
                <div class="card-footer text-center">
                    ¿No tienes cuenta?
                    <a href="jsp/lector/registroLector.jsp" class="text-decoration-none">Regístrate aquí</a>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
