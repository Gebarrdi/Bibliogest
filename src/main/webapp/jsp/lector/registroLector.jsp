<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Registro de lector</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center" style="height: 100vh;">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow">
                <div class="card-header bg-success text-white text-center">
                    <h4><i class="bi bi-person-plus-fill"></i> Registro de nuevo lector</h4>
                </div>
                <div class="card-body">
                    <form action="SvCrearUsuario" method="post">

                        <div class="mb-3">
                            <label for="nombres" class="form-label">Nombres</label>
                            <input type="text" class="form-control" name="nombres" id="nombres"
                                   required pattern="[A-Za-z\\s]{2,}" title="Solo letras y mínimo 2 caracteres">
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

                        <input type="hidden" name="rol" value="lector">

                        <div class="text-center">
                            <button type="submit" class="btn btn-success w-100">
                                <i class="bi bi-check-circle-fill"></i> Registrarse
                            </button>
                        </div>
                    </form>
                </div>
                <div class="card-footer text-center">
                    ¿Ya tienes cuenta?
                    <a href="<%= request.getContextPath() %>/login.jsp" class="text-decoration-none">Inicia sesión</a>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
