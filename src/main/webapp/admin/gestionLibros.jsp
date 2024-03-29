<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestión Libros</title>
    <jsp:include page="../components/bootstrap.jsp"/>
    <jsp:include page="../components/sweetalert.jsp"/>
</head>
<body class="d-flex flex-column min-vh-100">

<jsp:include page="../components/header.jsp"/>

<main class="flex-grow-1">
    <h1 class="text-center my-5">Gestión de Libros</h1>
    <c:choose>
    <c:when test="${empty listaLibros}">
        <p class="text-center">No hay libros disponibles en la lista</p>
    </c:when>
    <c:otherwise>
    <section class="container">
        <a href="CrearLibro" class="btn btn-success mb-4">Nuevo Libro</a>
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                    ${error}
            </div>
        </c:if>
        <table class="table table-striped text-center">
            <tr class="align-middle">
                <th>ID</th>
                <th>ISBN</th>
                <th>Titulo</th>
                <th>Autores</th>
                <th>Generos</th>
                <th>Imagen</th>
                <th>Ejemplares</th>
                <th>Préstamos</th>
                <th>Acciones</th>
            </tr>
            <c:forEach items="${listaLibros}" var="libro">
                <tr class="align-middle">
                    <td>${libro.id}</td>
                    <td>${libro.isbn}</td>
                    <td>${libro.titulo}</td>
                    <td>
                        <ul class="list-group">
                            <c:forEach items="${libro.autores}" var="autor">
                                <ol class="list-group-item">${autor.nombre}</ol>
                            </c:forEach>
                        </ul>
                    </td>
                    <td>
                        <ul class="list-group">
                            <c:forEach items="${libro.generos}" var="genero">
                                <li class="list-group-item">${genero.genero}</li>
                            </c:forEach>
                        </ul>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${empty libro.imagenPortada}">
                                <p class="text-muted fw-light">Sin portada</p>
                            </c:when>
                            <c:otherwise>
                                <img src="../img/${libro.imagenPortada}" alt="${libro.titulo}" width="100" height="auto">
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>${libro.numeroEjemplares}</td>
                    <td>
                        <c:set var="prestamosActivos" value="0"/>
                        <c:forEach items="${libro.prestamos}" var="prestamo">
                            <c:if test="${prestamo.fechaDevolucion == null}">
<%--                                contar los prestamos activos --%>
                                <c:set var="prestamosActivos" value="${prestamosActivos + 1}"/>
                            </c:if>
                        </c:forEach>
                        <c:out value="${prestamosActivos}"/>
                    </td>
                    <td>
                        <a href="EditarLibro?id=${libro.id}" class="btn btn-primary">Editar</a>
                        <a href="EliminarLibro?id=${libro.id}"
                           class="btn btn-danger eliminar-libro">Eliminar</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
        </c:otherwise>
        </c:choose>
    </section>
</main>

<jsp:include page="../components/footer.jsp"/>
<script>
    document.querySelectorAll('.eliminar-libro').forEach(libro => {
        libro.addEventListener('click', function (e) {
            // let nombre = e.target.parentElement.parentElement.children[0].textContent;
            e.preventDefault();
            Swal.fire({
                title: "¿Está seguro?",
                text: "Esta acción no se puede deshacer",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Sí, eliminar'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = e.target.href;
                }
            });
        });
    });
</script>
</body>
</html>
