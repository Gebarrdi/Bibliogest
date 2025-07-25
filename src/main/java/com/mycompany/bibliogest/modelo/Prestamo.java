package com.mycompany.bibliogest.modelo;

import java.util.Date;

public class Prestamo {
    private String codigoPrestamo;
    private String idUsuarioSolicitante;  // Lector
    private String idBibliotecario;
    private String codigoLibro;
    private Date fechaPrestamo;
    private Date fechaDevolucionEsperada;
    private Date fechaDevolucionReal;
    private double penalizacion;
    private int diasRetraso;

    public Prestamo() {}

    public Prestamo(String codigoPrestamo, String idUsuarioSolicitante, String idBibliotecario,
                    String codigoLibro, Date fechaPrestamo, Date fechaDevolucionEsperada,
                    Date fechaDevolucionReal, double penalizacion, int diasRetraso) {
        this.codigoPrestamo = codigoPrestamo;
        this.idUsuarioSolicitante = idUsuarioSolicitante;
        this.idBibliotecario = idBibliotecario;
        this.codigoLibro = codigoLibro;
        this.fechaPrestamo = fechaPrestamo;
        this.fechaDevolucionEsperada = fechaDevolucionEsperada;
        this.fechaDevolucionReal = fechaDevolucionReal;
        this.penalizacion = penalizacion;
        this.diasRetraso = diasRetraso;
    }

    public String getCodigoPrestamo() {
        return codigoPrestamo;
    }

    public void setCodigoPrestamo(String codigoPrestamo) {
        this.codigoPrestamo = codigoPrestamo;
    }

    public String getIdUsuarioSolicitante() {
        return idUsuarioSolicitante;
    }

    public void setIdUsuarioSolicitante(String idUsuarioSolicitante) {
        this.idUsuarioSolicitante = idUsuarioSolicitante;
    }

    public String getIdBibliotecario() {
        return idBibliotecario;
    }

    public void setIdBibliotecario(String idBibliotecario) {
        this.idBibliotecario = idBibliotecario;
    }

    public String getCodigoLibro() {
        return codigoLibro;
    }

    public void setCodigoLibro(String codigoLibro) {
        this.codigoLibro = codigoLibro;
    }

    public Date getFechaPrestamo() {
        return fechaPrestamo;
    }

    public void setFechaPrestamo(Date fechaPrestamo) {
        this.fechaPrestamo = fechaPrestamo;
    }

    public Date getFechaDevolucionEsperada() {
        return fechaDevolucionEsperada;
    }

    public void setFechaDevolucionEsperada(Date fechaDevolucionEsperada) {
        this.fechaDevolucionEsperada = fechaDevolucionEsperada;
    }

    public Date getFechaDevolucionReal() {
        return fechaDevolucionReal;
    }

    public void setFechaDevolucionReal(Date fechaDevolucionReal) {
        this.fechaDevolucionReal = fechaDevolucionReal;
    }

    public double getPenalizacion() {
        return penalizacion;
    }

    public void setPenalizacion(double penalizacion) {
        this.penalizacion = penalizacion;
    }

    public int getDiasRetraso() {
        return diasRetraso;
    }

    public void setDiasRetraso(int diasRetraso) {
        this.diasRetraso = diasRetraso;
    }

    public int calcularDiasRetraso() {
        if (fechaDevolucionReal == null || fechaDevolucionEsperada == null) {
            return 0;
        }
        long diferencia = fechaDevolucionReal.getTime() - fechaDevolucionEsperada.getTime();
        int dias = (int) (diferencia / (1000 * 60 * 60 * 24));
        return Math.max(dias, 0);
    }

    public double calcularPenalizacion() {
        diasRetraso = calcularDiasRetraso();
        return diasRetraso * 0.5;
    }

    public String getIdUsuarioLector() {
        return idUsuarioSolicitante;
    }
    
    public void setIdUsuarioLector(String idUsuarioLector) {
    this.idUsuarioSolicitante = idUsuarioLector;
    }

    public String getIdUsuarioBibliotecario() {
        return idBibliotecario;
    }
}
