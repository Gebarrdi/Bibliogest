package com.mycompany.bibliogest.dao;

import com.mycompany.bibliogest.modelo.Prestamo;
import com.mycompany.bibliogest.util.Conexion;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PrestamoDAO {

    public String generarCodigoPrestamo() {
        String codigo = "P001";
        String sql = "SELECT COUNT(*) FROM prestamo";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                int total = rs.getInt(1) + 1;
                codigo = String.format("P%03d", total);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return codigo;
    }

    public void registrarPrestamo(Prestamo p) {
        String sql = "INSERT INTO prestamo (codigo_prestamo, id_usuario_lector, id_usuario_bibliotecario, codigo_libro, fecha_prestamo, fecha_devolucion_esperada, estado, dias_retraso, penalizacion) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, p.getCodigoPrestamo());
            stmt.setString(2, p.getIdUsuarioSolicitante());
            stmt.setString(3, p.getIdBibliotecario());
            stmt.setString(4, p.getCodigoLibro());

            stmt.setDate(5, new java.sql.Date(p.getFechaPrestamo().getTime()));
            stmt.setDate(6, new java.sql.Date(p.getFechaDevolucionEsperada().getTime()));

            stmt.setString(7, "Activo");
            stmt.setInt(8, 0);
            stmt.setDouble(9, 0.0);

            stmt.executeUpdate();
            System.out.println("Préstamo registrado correctamente.");

        } catch (Exception e) {
            System.err.println("Error al registrar préstamo:");
            e.printStackTrace();
        }
    }
    
    public List<Prestamo> listarTodos() {
        List<Prestamo> lista = new ArrayList<>();
        String sql = "SELECT * FROM prestamo";

        try (Connection con = Conexion.getConexion();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Prestamo p = new Prestamo(
                    rs.getString("codigo_prestamo"),
                    rs.getString("id_usuario_lector"),
                    rs.getString("id_usuario_bibliotecario"),
                    rs.getString("codigo_libro"),
                    rs.getDate("fecha_prestamo"),
                    rs.getDate("fecha_devolucion_esperada"),
                    rs.getDate("fecha_devolucion_real"),
                    rs.getDouble("penalidad"),
                    rs.getInt("dias_retraso")
                );
                lista.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Prestamo obtenerPorCodigo(String codigo) {
        Prestamo p = null;
        String sql = "SELECT * FROM prestamo WHERE codigo_prestamo = ?";

        try (Connection con = Conexion.getConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, codigo);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                p = new Prestamo(
                    rs.getString("codigo_prestamo"),
                    rs.getString("id_usuario_lector"),
                    rs.getString("id_usuario_bibliotecario"),
                    rs.getString("codigo_libro"),
                    rs.getDate("fecha_prestamo"),
                    rs.getDate("fecha_devolucion_esperada"),
                    rs.getDate("fecha_devolucion_real"),
                    rs.getDouble("penalizacion"),
                    rs.getInt("dias_retraso")
                );
            }

            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return p;
    }     
   
    public List<Prestamo> listarPorLector(String idLector) {
        List<Prestamo> lista = new ArrayList<>();
        String sql = "SELECT * FROM prestamo WHERE id_usuario_lector = ?";

        try (Connection con = Conexion.getConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, idLector);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Prestamo p = new Prestamo(
                    rs.getString("codigo_prestamo"),
                    rs.getString("id_usuario_lector"),
                    rs.getString("id_usuario_bibliotecario"),
                    rs.getString("codigo_libro"),
                    rs.getDate("fecha_prestamo"),
                    rs.getDate("fecha_devolucion_esperada"),
                    rs.getDate("fecha_devolucion_real"),
                    rs.getDouble("penalizacion"),
                    rs.getInt("dias_retraso")
                );
                lista.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }
    
    public void registrarDevolucion(String codigoPrestamo, LocalDate fechaDevolucion) {
        String sql = "UPDATE prestamo SET fecha_devolucion_real = ?, dias_retraso = DATEDIFF(?, fecha_devolucion_esperada), " +
                     "penalizacion = (DATEDIFF(?, fecha_devolucion_esperada) * 1.5), estado = 'Devuelto' " +
                     "WHERE codigo_prestamo = ? AND fecha_devolucion_real IS NULL";


        try (Connection con = Conexion.getConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setDate(1, Date.valueOf(fechaDevolucion));
            stmt.setDate(2, Date.valueOf(fechaDevolucion));
            stmt.setDate(3, Date.valueOf(fechaDevolucion));
            stmt.setString(4, codigoPrestamo);

            int filas = stmt.executeUpdate();

            if (filas > 0) {
                System.out.println("Devolución registrada y estado actualizado a 'Devuelto'.");
            } else {
                System.out.println("No se registró la devolución (quizás ya fue devuelto).");
            }

        } catch (Exception e) {
            System.err.println("Error al registrar devolución:");
            e.printStackTrace();
        }
    }

    public List<Prestamo> listarPendientes() {
        List<Prestamo> lista = new ArrayList<>();
        String sql = "SELECT * FROM prestamo WHERE fecha_devolucion_real IS NULL";

        try (Connection con = Conexion.getConexion();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Prestamo p = new Prestamo(
                    rs.getString("codigo_prestamo"),
                    rs.getString("codigo_libro"),
                    rs.getString("id_usuario_lector"),
                    rs.getString("id_usuario_bibliotecario"),
                    rs.getDate("fecha_prestamo"),
                    rs.getDate("fecha_devolucion_esperada"),
                    rs.getDate("fecha_devolucion_real"),
                    rs.getDouble("penalizacion"),
                    rs.getInt("dias_retraso")   
                );
                lista.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }
    
    public List<Prestamo> obtenerPrestamosActivos() {
        List<Prestamo> lista = new ArrayList<>();

        String sql = "SELECT * FROM prestamo WHERE fecha_devolucion_real IS NULL";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Prestamo p = new Prestamo();
                p.setCodigoPrestamo(rs.getString("codigo_prestamo"));
                p.setIdUsuarioSolicitante(rs.getString("id_usuario_lector"));
                p.setIdBibliotecario(rs.getString("id_usuario_bibliotecario"));
                p.setCodigoLibro(rs.getString("codigo_libro"));
                p.setFechaPrestamo(rs.getDate("fecha_prestamo"));
                p.setFechaDevolucionEsperada(rs.getDate("fecha_devolucion_esperada"));
                p.setFechaDevolucionReal(rs.getDate("fecha_devolucion_real"));
                p.setPenalizacion(rs.getDouble("penalizacion"));
                p.setDiasRetraso(rs.getInt("dias_retraso"));

                lista.add(p);
            }

        } catch (Exception e) {
            System.err.println("Error al obtener préstamos activos: " + e.getMessage());
        }

        return lista;
    }  
}
