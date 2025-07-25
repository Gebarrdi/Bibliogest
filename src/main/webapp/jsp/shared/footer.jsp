<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

</div>

<footer class="bg-light text-center text-muted py-3 border-top fixed-bottom shadow-sm">
    <div class="container">
        <small>CODEMIND - Bibliogest</small>
    </div>
</footer>

<%
    Object requiereDT = request.getAttribute("requiereDataTables");
    boolean cargarDataTables = false;

    if (requiereDT != null && requiereDT instanceof Boolean) {
        cargarDataTables = (Boolean) requiereDT;
    }

    if (cargarDataTables) {
%>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.bootstrap5.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.0/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>

    <script>
        function inicializarTabla(idTabla) {
            $('#' + idTabla).DataTable({
                dom: 'Bfrtip',
                buttons: ['copy', 'excel', 'pdf', 'print'],
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
<%
    }
%>

</body>
</html>
