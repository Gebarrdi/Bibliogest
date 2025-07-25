package com.mycompany.bibliogest.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

public class Conexion {

    private static final String URL = "jdbc:mysql://localhost:3306/bibliogest";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    private static Connection conn = null;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Error al cargar el driver JDBC: " + e.getMessage());
        }
    }

    public static Connection getConexion() {
        try {
            if (conn == null || conn.isClosed()) {
                conn = DriverManager.getConnection(URL, USER, PASSWORD);
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener conexión: " + e.getMessage());
        }
        return conn;
    }

    public static void cerrarConexion() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
                System.out.println("Conexión cerrada correctamente.");
            }

            AbandonedConnectionCleanupThread.checkedShutdown();
            System.out.println("Cleanup thread detenido correctamente.");

        } catch (SQLException e) {
            System.err.println("Error al cerrar conexión o al detener CleanupThread: " + e.getMessage());
        }
    }
}
