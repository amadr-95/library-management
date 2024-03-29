<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<fmt:setLocale value="en_US"/>
<fmt:bundle basename="myProp">
    <header>
        <nav class="navbar navbar-expand-lg navbar-light bg-dark p-3">
            <div class="container">
                <a class="navbar-brand text-white" href="${pageContext.request.contextPath}/Inicio"><fmt:message
                        key="biblioteca.inicio"/></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <c:choose>
                            <%-- Cuando existe un usuario en la sesion --%>
                            <c:when test="${not empty sessionScope.usuario}">
                                <li class="nav-item">
                                    <a class="nav-link text-white"
                                       href="${pageContext.request.contextPath}/MenuPrincipal">
                                        <fmt:message key="saludo"/>
                                        <c:out value="${sessionScope.usuario.nombre}" />
                                        <sub>
                                            <c:out
                                                    value="(${sessionScope.usuario.rol})">
                                            </c:out>
                                        </sub>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white"
                                       href="${pageContext.request.contextPath}/CerrarSesion">
                                        <fmt:message key="cerrar.sesion"/>
                                    </a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <a class="nav-link text-white" href="Registro"><fmt:message key="registro"/></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white" href="Login"><fmt:message key="login"/></a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
</fmt:bundle>