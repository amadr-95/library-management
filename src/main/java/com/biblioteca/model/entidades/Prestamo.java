package com.biblioteca.model.entidades;

import jakarta.json.bind.annotation.JsonbTransient;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.Period;

@Entity
@Table(name = "prestamos")
public class Prestamo {
    @Id
    @SequenceGenerator(
            name = "prestamo_sequence",
            sequenceName = "prestamo_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "prestamo_sequence"
    )
    private Long id;

    @Column(name = "fecha_prestamo", nullable = false)
    private LocalDate fechaPrestamo;

    @Column(name = "fecha_devolucion")
    private LocalDate fechaDevolucion;

    @ManyToOne
    @JsonbTransient
    @JoinColumn(name = "libro_id", nullable = false)
    private Libro libro;

    @ManyToOne
    @JsonbTransient
    @JoinColumn(name = "usuario_id", nullable = false)
    private Usuario usuario;

    public Prestamo() {
    }

    public Prestamo(LocalDate fechaPrestamo, Libro libro, Usuario usuario) {
        this.fechaPrestamo = fechaPrestamo;
        this.fechaDevolucion = null;
        this.libro = libro;
        this.usuario = usuario;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDate getFechaPrestamo() {
        return fechaPrestamo;
    }

    public void setFechaPrestamo(LocalDate fechaPrestamo) {
        this.fechaPrestamo = fechaPrestamo;
    }

    public LocalDate getFechaDevolucion() {
        return fechaDevolucion;
    }

    public void setFechaDevolucion(LocalDate fechaDevolucion) {
        this.fechaDevolucion = fechaDevolucion;
    }

    public Libro getLibro() {
        return libro;
    }

    public void setLibro(Libro libro) {
        this.libro = libro;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public int getDiasPrestamo() {
        return fechaDevolucion == null ?
                Period.between(fechaPrestamo, LocalDate.now()).getDays() : //dinamico
                Period.between(fechaPrestamo, fechaDevolucion).getDays(); //fijo
    }

    public LocalDate getFechaDevolucionMaxima() {
        return fechaPrestamo.plusDays(15);
    }
}
