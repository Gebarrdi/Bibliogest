package com.mycompany.bibliogest.dao;

import com.mycompany.bibliogest.modelo.Usuario;
import com.mycompany.bibliogest.util.Conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    public Usuario obtenerPorCredenciales(String correo, String contrasena) {
        Usuario u = null;
        Connection conn = Conexion.getConexion();

        System.out.println("Verificando credenciales: " + correo + " | " + contrasena);

        if (conn != null) {
            try {
                String sql = "SELECT * FROM usuario WHERE correo = ? AND contrasena = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, correo);
                ps.setString(2, contrasena);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    u = new Usuario();
                    u.setIdUsuario(rs.getString("id_usuario"));
                    u.setNombres(rs.getString("nombres"));
                    u.setApellidos(rs.getString("apellidos"));
                    u.setCorreo(rs.getString("correo"));
                    u.setContrasena(rs.getString("contrasena"));
                    u.setRol(rs.getString("rol"));
                    System.out.println("Usuario encontrado: " + u.getNombres() + " (" + u.getRol() + ")");
                } else {
                    System.out.println("No se encontró usuario con esas credenciales.");
                }

                rs.close();
                ps.close();
                Conexion.cerrarConexion();

            } catch (Exception e) {
                System.out.println("Error al buscar usuario: " + e.getMessage());
            }
        } else {
            System.out.println("No hay conexión a la base de datos.");
        }

        return u;
    }

    public List<Usuario> listarPorRol(String rol) {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuario WHERE rol = ?";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, rol);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getString("id_usuario"));
                u.setNombres(rs.getString("nombres"));
                u.setApellidos(rs.getString("apellidos"));
                u.setCorreo(rs.getString("correo"));
                u.setContrasena(rs.getString("contrasena"));
                u.setRol(rs.getString("rol"));
                lista.add(u);
            }

            rs.close();
        } catch (Exception e) {
            System.err.println("Error al listar usuarios por rol: " + e.getMessage());
            e.printStackTrace();
        }

        return lista;
    }

    // 🔽 NUEVOS MÉTODOS 🔽

    public List<Usuario> listarUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuario";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getString("id_usuario"));
                u.setNombres(rs.getString("nombres"));
                u.setApellidos(rs.getString("apellidos"));
                u.setCorreo(rs.getString("correo"));
                u.setContrasena(rs.getString("contrasena"));
                u.setRol(rs.getString("rol"));
                lista.add(u);
            }

        } catch (SQLException e) {
            System.err.println("Error al listar todos los usuarios: " + e.getMessage());
        }

        return lista;
    }

    public void eliminarUsuario(String idUsuario) {
        String sql = "DELETE FROM usuario WHERE id_usuario = ?";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, idUsuario);
            ps.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Error al eliminar usuario: " + e.getMessage());
        }
    }

    public void cambiarRol(String idUsuario, String nuevoRol) {
        String sql = "UPDATE usuario SET rol = ? WHERE id_usuario = ?";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, nuevoRol);
            ps.setString(2, idUsuario);
            ps.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Error al cambiar rol: " + e.getMessage());
        }
    }
    
    public void registrarUsuario(Usuario u) {
        String sql = "INSERT INTO usuario (nombres, apellidos, correo, contrasena, rol) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, u.getNombres());
            ps.setString(2, u.getApellidos());
            ps.setString(3, u.getCorreo());
            ps.setString(4, u.getContrasena());
            ps.setString(5, u.getRol());

            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al registrar usuario: " + e.getMessage());
            e.printStackTrace();
        }
    }       
}
