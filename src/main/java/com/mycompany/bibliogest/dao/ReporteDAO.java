package com.mycompany.bibliogest.dao;

import com.mycompany.bibliogest.modelo.*;
import com.mycompany.bibliogest.util.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;

public class ReporteDAO {
    private final Connection conn;

    public ReporteDAO() {
        conn = Conexion.getConexion();
    }

    public List<Libro> obtenerLibrosMasPrestados() {
        List<Libro> lista = new ArrayList<>();
        String sql = "SELECT l.*, COUNT(p.codigo_libro) as total " +
                     "FROM prestamo p JOIN libro l ON p.codigo_libro = l.codigo_libro " +
                     "GROUP BY p.codigo_libro ORDER BY total DESC LIMIT 5";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Libro libro = new Libro();
                libro.setCodigoLibro(rs.getString("codigo_libro"));
                libro.setTitulo(rs.getString("titulo"));
                libro.setAutor(rs.getString("autor"));
                libro.setCategoria(rs.getString("categoria"));
                libro.setEditorial(rs.getString("editorial"));
                libro.setAnioPublicacion(rs.getInt("anio_publicacion"));
                libro.setCantidadTotal(rs.getInt("cantidad_total"));
                libro.setCantidadDisponible(rs.getInt("cantidad_disponible"));
                lista.add(libro);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Usuario> obtenerUsuariosMasActivos() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT u.*, COUNT(p.codigo_prestamo) AS total " +
                     "FROM prestamo p JOIN usuario u ON p.id_usuario_lector = u.id_usuario " +
                     "GROUP BY u.id_usuario ORDER BY total DESC LIMIT 5";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getString("id_usuario"));
                usuario.setNombres(rs.getString("nombres"));
                usuario.setApellidos(rs.getString("apellidos"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setContrasena(rs.getString("contrasena"));
                usuario.setRol(rs.getString("rol"));
                lista.add(usuario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Prestamo> obtenerPrestamosVencidos() {
        List<Prestamo> lista = new ArrayList<>();
        String sql = "SELECT * FROM prestamo WHERE fecha_devolucion_real IS NULL AND fecha_devolucion_esperada < CURDATE()";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Prestamo p = new Prestamo();
                p.setCodigoPrestamo(rs.getString("codigo_prestamo"));
                p.setIdUsuarioSolicitante(rs.getString("id_usuario_lector"));
                p.setIdBibliotecario(rs.getString("id_usuario_bibliotecario"));
                p.setCodigoLibro(rs.getString("codigo_libro"));
                p.setFechaPrestamo(rs.getDate("fecha_prestamo"));
                p.setFechaDevolucionEsperada(rs.getDate("fecha_devolucion_esperada"));
                p.setFechaDevolucionReal(null);

                int diasRetraso = calcularDiasRetraso(rs.getDate("fecha_devolucion_esperada"));
                double penalizacion = diasRetraso * 1.5;

                p.setDiasRetraso(diasRetraso);
                p.setPenalizacion(penalizacion);

                String updateSQL = "UPDATE prestamo SET dias_retraso = ?, penalizacion = ? WHERE codigo_prestamo = ?";
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSQL)) {
                    updateStmt.setInt(1, diasRetraso);
                    updateStmt.setDouble(2, penalizacion);
                    updateStmt.setString(3, p.getCodigoPrestamo());
                    updateStmt.executeUpdate();
                }

                lista.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    private int calcularDiasRetraso(Date fechaEsperada) {
        long ahora = System.currentTimeMillis();
        long esperado = fechaEsperada.getTime();
        long diferencia = ahora - esperado;
        return (int) Math.max(diferencia / (1000 * 60 * 60 * 24), 0);
    }
}
