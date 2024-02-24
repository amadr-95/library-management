package com.biblioteca.model.dao;

import com.biblioteca.model.entidades.Rol;
import com.biblioteca.model.entidades.Usuario;
import com.biblioteca.util.EntityManagerUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

import java.util.List;

public class UsuarioDao {

    public UsuarioDao() {
    }

    public Usuario autenticar(String email, String password) throws NoResultException {
        EntityManager entityManager = EntityManagerUtil.getEntityManager();
        entityManager.getTransaction().begin();
        String query = "SELECT u FROM Usuario u WHERE u.email = :email AND u.password = :password";

        Usuario usuarioLogueado = entityManager.createQuery(query, Usuario.class)
                .setParameter("email", email)
                .setParameter("password", password)
                .getSingleResult();
        entityManager.getTransaction().commit();
        entityManager.close();
        return usuarioLogueado;
    }

    public void insertarUsuario(Usuario usuario) {
        EntityManager entityManager = EntityManagerUtil.getEntityManager();
        entityManager.getTransaction().begin();
        entityManager.persist(usuario);
        entityManager.getTransaction().commit();
        entityManager.close();
    }

    public Usuario buscarUsuarioPorEmail(String email) throws NoResultException {
        EntityManager entityManager = EntityManagerUtil.getEntityManager();
        entityManager.getTransaction().begin();
        String query = "SELECT u FROM Usuario u WHERE u.email = :email";
        Usuario usuario = entityManager.createQuery(query, Usuario.class)
                .setParameter("email", email)
                .getSingleResult();
        entityManager.getTransaction().commit();
        entityManager.close();
        return usuario;
    }

    public List<Usuario> listarUsuariosPorRol(Rol rol) {
        EntityManager entityManager = EntityManagerUtil.getEntityManager();
        entityManager.getTransaction().begin();
        String query = "SELECT u FROM Usuario u WHERE u.rol = :rol";
        List<Usuario> usuarios = entityManager.createQuery(query, Usuario.class)
                .setParameter("rol", rol)
                .getResultList();
        entityManager.getTransaction().commit();
        entityManager.close();
        return usuarios;
    }
}
