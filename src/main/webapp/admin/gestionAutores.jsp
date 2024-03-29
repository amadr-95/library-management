<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestión Autores</title>
    <jsp:include page="../components/sweetalert.jsp"/>
    <jsp:include page="../components/bootstrap.jsp"/>
</head>
<body class="d-flex flex-column min-vh-100">

<!-- Modal ver libros -->
<div class="modal fade" id="modalLibros" tabindex="-1" aria-labelledby="modalLibrosLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalLibrosLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <ul id="listaLibros" class="list-group">
                    <!-- Aquí se mostrarán los títulos de los libros -->
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Modal añadir autor -->
<div class="modal fade" id="modalAutor" tabindex="-1" aria-labelledby="modalAutorLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalAutorLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form method="post">
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre del autor</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Guardar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal editar autor -->
<div class="modal fade" id="modalAutorEditar" tabindex="-1" aria-labelledby="modalAutorLabelEditar" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalAutorLabelEditar"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form method="post">
                    <input type="hidden" id="idEditar" name="id">
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre del autor</label>
                        <input type="text" class="form-control" id="nombreEditar" name="nombre" value="${autorEditar.nombre}" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Editar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../components/header.jsp"/>

<main class="flex-grow-1">
    <h1 class="text-center my-5">Gestión de Autores</h1>

    <c:choose>
    <c:when test="${empty listaAutores}">
        <p class="text-center">No hay autores disponibles en la lista</p>
    </c:when>
    <c:otherwise>
    <section class="container">
        <button type="button" class="btn btn-success mb-4" data-bs-toggle="modal" data-bs-target="#modalAutor">
            Nuevo Autor
        </button>
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                    ${error}
            </div>
        </c:if>
        <table class="table table-striped text-center">
            <tr class="align-middle">
                <th>ID</th>
                <th>Nombre del autor</th>
                <th>Libros</th>
                <th>Acciones</th>
            </tr>
            <c:forEach items="${listaAutores}" var="autor">
                <tr class="align-middle">
                    <td>${autor.id}</td>
                    <td>${autor.nombre}</td>
                    <td>
                        <c:choose>
                            <c:when test="${autor.libros.size() == 0}">
                                <span class="text-muted fw-light">No hay libros</span>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-primary ver-libros">Ver Libros (${autor.libros.size()})</button>
                                <ul class="list-group" style="display: none;">
                                    <c:forEach items="${autor.libros}" var="libro">
                                        <li class="list-group-item">${libro.titulo}</li>
                                    </c:forEach>
                                </ul>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="EditarAutor?id=${autor.id}" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAutorEditar">Editar</a>
                        <a href="EliminarAutor?id=${autor.id}"
                           class="btn btn-danger eliminar-autor">Eliminar</a>
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
    //confirmar la eliminación de un autor
    document.querySelectorAll('.eliminar-autor').forEach(autor => {
        autor.addEventListener('click', function (e) {
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

    // Mostrar los libros de un autor en una ventana modal
    document.querySelectorAll('.ver-libros').forEach(link => {
        link.addEventListener('click', function (e) {
            e.preventDefault();
            // Obtener el nombre del autor
            const nombreAutor = this.closest('tr').querySelector('td:nth-child(2)').textContent;
            document.getElementById('modalLibrosLabel').textContent = "Libros de " + nombreAutor;
            const listaLibros = document.getElementById('listaLibros');
            listaLibros.innerHTML = ''; // Limpiar la lista de libros
            // Obtener los elementos li de la lista de libros del autor
            const libros = this.closest('tr').querySelector('.list-group').querySelectorAll('li');
            libros.forEach(libro => {
                const li = document.createElement('li');
                li.classList.add('list-group-item');
                li.textContent = libro.textContent;
                listaLibros.appendChild(li);
            });
            // Mostrar la ventana modal
            new bootstrap.Modal(document.getElementById('modalLibros')).show();
        });
    });
</script>
</body>
</html>
