<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.mycompany.bibliogest.modelo.Usuario" %>

<%
    String rutaInicio = request.getContextPath() + "/inicio.jsp";
    Usuario usuarioHeader = (Usuario) session.getAttribute("usuario");

    if (usuarioHeader != null) {
        switch (usuarioHeader.getRol().toLowerCase()) {
            case "administrador":
                rutaInicio = request.getContextPath() + "/SvAdmin";
                break;
            case "bibliotecario":
                rutaInicio = request.getContextPath() + "/jsp/bibliotecario/dashboardBibliotecario.jsp";
                break;
            case "lector":
                rutaInicio = request.getContextPath() + "/SvLector";
                break;
        }
    }

    String uri = request.getRequestURI();
    boolean requiereDataTables = uri.contains("reportes.jsp");
    request.setAttribute("requiereDataTables", requiereDataTables);
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>BiblioGest</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background-color: #f8f9fa;
            padding-bottom: 60px;
        }

        .navbar-brand {
            font-weight: bold;
        }

        .auto-scroll-table {
            overflow-x: auto;
            width: 100%;
            margin-bottom: 1rem;
        }

        .auto-scroll-table table {
            min-width: 800px;
            width: 100%;
        }

        table th, table td {
            white-space: nowrap;
        }
    </style>

    <script>
        window.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll("table").forEach(function (tabla) {
                if (!tabla.closest(".auto-scroll-table")) {
                    const wrapper = document.createElement("div");
                    wrapper.className = "auto-scroll-table";
                    tabla.parentNode.insertBefore(wrapper, tabla);
                    wrapper.appendChild(tabla);
                }
            });
        });
    </script>

    <%
        if (requiereDataTables) {
    %>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.bootstrap5.min.css">
    <%
        }
    %>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="<%= rutaInicio %>">BiblioGest</a>
    </div>
</nav>

<div class="container">
