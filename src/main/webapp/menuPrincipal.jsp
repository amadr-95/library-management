<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menú Principal</title>
    <jsp:include page="components/bootstrap.jsp"/>
    <style>
        .card {
            transition: transform 0.3s ease-in-out;
        }

        .card:hover {
            transform: scale(1.05);
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<jsp:include page="components/header.jsp"/>

<main class="flex-grow-1">
    <h1 class="text-center my-5">Menú Principal</h1>
    <section class="container">
        <div class="row">

            <c:choose>
                <c:when test="${admin}">
                    <!-- Si el rol es ADMINISTRADOR, muestra opciones de administrador -->
                    <div class="col-md-6 text-center">
                        <div class="card card-body">
                            <h5 class="card-title">Administrar empleados</h5>
                            <p class="card-text">Crea, edita y elimina empleados del sistema</p>
                                <%--Este enlace es al servlet--%>
                            <a href="admin/GestionEmpleados" class="btn btn-primary">Acceder</a>
                        </div>
                    </div>
                    <div class="col-md-6 text-center">
                        <div class="card card-body">
                            <h5 class="card-title">Administrar libros</h5>
                            <p class="card-text">Crea, edita y elimina libros del sistema</p>
                                <%--Este enlace es al servlet--%>
                            <a href="admin/GestionLibros" class="btn btn-primary">Acceder</a>
                        </div>
                    </div>
                    <div class="mt-4 col-md-6 text-center">
                        <div class="card card-body">
                            <h5 class="card-title">Administrar Autores y Generos</h5>
                            <p class="card-text">Crea, edita y elimina autores y géneros del sistema</p>
                                <%--Este enlace es al servlet--%>
                            <div class="d-flex gap-2">
                                <a href="admin/GestionAutores" class="w-50 btn btn-primary">Autores</a>
                                <a href="admin/GestionGeneros" class="w-50 btn btn-primary">Géneros</a>
                            </div>
                        </div>
                    </div>
                    <div class="mt-4 col-md-6 text-center ">
                        <div class="card card-body">
                            <h5 class="card-title">Gestionar Préstamos</h5>
                            <p class="card-text">Gestiona los préstamos de los usuarios</p>
                                <%--Este enlace es al servlet--%>
                            <a href="admin/ConsultarPrestamos" class="btn btn-primary">Acceder</a>
                        </div>
                    </div>
                </c:when>
                <c:when test="${empleado}">
                    <div class="col-md-6 text-center">
                        <div class="card card-body">
                            <h5 class="card-title">Registrar Préstamo</h5>
                            <p class="card-text">Asigna un préstamo a un socio</p>
                                <%--Este enlace es al servlet--%>
                            <a href="empleado/RealizarPrestamo" class="btn btn-primary">Acceder</a>
                        </div>
                    </div>
                    <div class="col-md-6 text-center">
                        <div class="card card-body">
                            <h5 class="card-title">Tarjeta 2</h5>
                            <p class="card-text">Texto 2</p>
                                <%--Este enlace es al servlet--%>
                            <a href="#" class="btn btn-primary">Acceder</a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- En caso de que el rol no coincida con ninguno de los anteriores -->
                    <p>Rol desconocido. Por favor, contacta al administrador.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
</main>

<jsp:include page="components/footer.jsp"/>

</body>
</html>

