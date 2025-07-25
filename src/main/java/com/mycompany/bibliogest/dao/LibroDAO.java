package com.mycompany.bibliogest.dao;

import com.mycompany.bibliogest.modelo.Libro;
import com.mycompany.bibliogest.util.Conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LibroDAO {
    
    private Connection conn;

    public LibroDAO() {
        conn = Conexion.getConexion(); // sin "Connection" al inicio
    }

    public List<Libro> listarTodos() {
        List<Libro> lista = new ArrayList<>();
        String sql = "SELECT * FROM libro";

        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Libro libro = new Libro(
                    rs.getString("codigo_libro"),
                    rs.getString("titulo"),
                    rs.getString("autor"),
                    rs.getString("categoria"),
                    rs.getString("editorial"),
                    rs.getString("codigo_isbn"),
                    rs.getInt("anio_publicacion"),
                    rs.getInt("cantidad_total"),
                    rs.getInt("cantidad_disponible")
                );
                lista.add(libro);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    public void agregarLibro(Libro libro) {
        System.out.println("Insertando libro: " + libro.getTitulo());
        try {
            Connection con = Conexion.getConexion();
            String sql = "INSERT INTO libro (codigo_libro, titulo, autor, categoria, editorial, codigo_isbn, anio_publicacion, cantidad_total, cantidad_disponible) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, libro.getCodigoLibro());
            stmt.setString(2, libro.getTitulo());
            stmt.setString(3, libro.getAutor());
            stmt.setString(4, libro.getCategoria());
            stmt.setString(5, libro.getEditorial());
            stmt.setString(6, libro.getIsbn());
            stmt.setInt(7, libro.getAnioPublicacion());
            stmt.setInt(8, libro.getCantidadTotal());
            stmt.setInt(9, libro.getCantidadDisponible());

            int filas = stmt.executeUpdate();
            System.out.println("Libro agregado. Filas afectadas: " + filas);

            stmt.close();
            Conexion.cerrarConexion();
        } catch (Exception e) {
            System.err.println("Error al insertar libro:");
            e.printStackTrace();
        }
    }

    public void restarEjemplarDisponible(String codigoLibro) {
        String sql = "UPDATE libro SET cantidad_disponible = cantidad_disponible - 1 WHERE codigo_libro = ? AND cantidad_disponible > 0";

        try (Connection con = Conexion.getConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, codigoLibro);
            int filas = stmt.executeUpdate();
            
            if (filas > 0) {
                System.out.println("Ejemplar descontado del libro: " + codigoLibro);
            } else {
                System.out.println("No se pudo descontar. Ya no hay ejemplares disponibles.");
            }

        } catch (Exception e) {
            System.err.println("Error al descontar ejemplar:");
            e.printStackTrace();
        }
    }
    
    public List<Libro> listarDisponibles() {
        List<Libro> lista = new ArrayList<>();
        String sql = "SELECT * FROM libro WHERE cantidad_disponible > 0";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Libro libro = new Libro(
                    rs.getString("codigo_libro"),
                    rs.getString("titulo"),
                    rs.getString("autor"),
                    rs.getString("categoria"),
                    rs.getString("editorial"),
                    rs.getString("codigo_isbn"),
                    rs.getInt("anio_publicacion"),
                    rs.getInt("cantidad_total"),
                    rs.getInt("cantidad_disponible")
                );
                lista.add(libro);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public void sumarEjemplarDisponible(String codigoLibro) {
        String sql = "UPDATE libro SET cantidad_disponible = cantidad_disponible + 1 WHERE codigo_libro = ?";

        try (Connection con = Conexion.getConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, codigoLibro);
            int filas = stmt.executeUpdate();

            if (filas > 0) {
                System.out.println("Se aumentó 1 ejemplar disponible para: " + codigoLibro);
            } else {
                System.out.println("No se actualizó cantidad disponible.");
            }

        } catch (Exception e) {
            System.err.println("Error al aumentar ejemplar disponible:");
            e.printStackTrace();
        }
    }
    
    public Libro buscarPorCodigo(String codigoLibro) {
        String sql = "SELECT * FROM libro WHERE codigo_libro = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, codigoLibro);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Libro(
                        rs.getString("codigo_libro"),
                        rs.getString("titulo"),
                        rs.getString("autor"),
                        rs.getString("categoria"),
                        rs.getString("editorial"),
                        rs.getString("codigo_isbn"),
                        rs.getInt("anio_publicacion"),
                        rs.getInt("cantidad_total"),
                        rs.getInt("cantidad_disponible")
                    );
                }
            }
        } catch (Exception e) {
            System.err.println("Error al buscar libro por código:");
            e.printStackTrace();
        }
        return null;
    }
    
    public void actualizarLibro(Libro libro) {
        String sql = "UPDATE libro SET titulo = ?, autor = ?, categoria = ?, editorial = ?, codigo_isbn = ?, anio_publicacion = ?, cantidad_total = ?, cantidad_disponible = ? WHERE codigo_libro = ?";

        try (Connection con = Conexion.getConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, libro.getTitulo());
            stmt.setString(2, libro.getAutor());
            stmt.setString(3, libro.getCategoria());
            stmt.setString(4, libro.getEditorial());
            stmt.setString(5, libro.getIsbn());
            stmt.setInt(6, libro.getAnioPublicacion());
            stmt.setInt(7, libro.getCantidadTotal());
            stmt.setInt(8, libro.getCantidadDisponible());
            stmt.setString(9, libro.getCodigoLibro());

            int filas = stmt.executeUpdate();
            if (filas > 0) {
                System.out.println("Libro actualizado: " + libro.getCodigoLibro());
            } else {
                System.out.println("No se actualizó el libro.");
            }

        } catch (Exception e) {
            System.err.println("Error al actualizar libro:");
            e.printStackTrace();
        }
    }
    
    public void eliminarLibroPorCodigo(String codigoLibro) {
        String sql = "DELETE FROM libro WHERE codigo_libro = ?";

        try (Connection con = Conexion.getConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, codigoLibro);
            int filas = stmt.executeUpdate();

            if (filas > 0) {
                System.out.println("Libro eliminado: " + codigoLibro);
            } else {
                System.out.println("No se encontró el libro para eliminar.");
            }

        } catch (Exception e) {
            System.err.println("Error al eliminar libro:");
            e.printStackTrace();
        }
    }      
}
