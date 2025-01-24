<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="" />
                    <meta name="author" content="" />
                    <title>Dashboard - SB Admin</title>
                    <link href="/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../layout/header.jsp" />
                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp" />
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <h1 class="mt-4">Manage Products</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item" href="/admin">Dashborad</li>
                                        <li class="breadcrumb-item active">Products</li>
                                    </ol>
                                    <div class="container mt-5">
                                        <div class="row">
                                            <div class="col-12 mx-auto">
                                                <div class="d-flex justify-content-between">
                                                    <h3>Table products</h3>
                                                    <a href="http://localhost:8080/admin/product/create"
                                                        class="btn btn-primary">Create a
                                                        product</a>
                                                </div>
                                                <hr>
                                                <div>
                                                    <table class="table table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th scope="col">ID</th>
                                                                <th scope="col">Name</th>
                                                                <th scope="col">Price</th>
                                                                <th scope="col">Factory</th>
                                                                <th scope="col">Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="product" items="${products1}">
                                                                <tr>
                                                                    <th scope="row">${product.id}</th>
                                                                    <td>${product.name}</td>
                                                                    <!-- <td>${product.price}</td> -->
                                                                    <td>

                                                                        <fmt:formatNumber type="number"
                                                                            value="${product.price}" />đ

                                                                    </td>
                                                                    <td>${product.factory}</td>
                                                                    <td>
                                                                        <a href="/admin/product/${product.id}"
                                                                            class="btn btn-success">view</a>
                                                                        <a href="/admin/product/update/${product.id}"
                                                                            class="btn btn-warning">update</a>

                                                                        <a href="/admin/product/delete/${product.id}"
                                                                            class="btn btn-danger">delete</a>
                                                                        <a href="/admin/product/update/${product.id}"
                                                                            class="btn btn-warning">update2</a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                    <nav aria-label="Page navigation example">
                                                        <ul class="pagination justify-content-center">
                                                            <li class="page-item">
                                                                <a class="${1 eq currentPage ? 'disabled page-link' : 'page-link'}"
                                                                    href="/admin/product?page=${currentPage - 1}"
                                                                    aria-label="Previous">
                                                                    <span aria-hidden="true">&laquo;</span>
                                                                </a>
                                                            </li>
                                                            <c:forEach begin="0" end="${totalPages - 1}"
                                                                varStatus="loop">
                                                                <li class="page-item">
                                                                    <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"
                                                                        href="/admin/product?page=${loop.index + 1}">
                                                                        ${loop.index + 1}
                                                                    </a>
                                                                </li>
                                                            </c:forEach>
                                                            <li class="page-item">
                                                                <a class="${totalPages eq currentPage ? 'disabled page-link' : 'page-link'}"
                                                                    href="/admin/product?page=${currentPage + 1}"
                                                                    aria-label="Next">
                                                                    <span aria-hidden="true">&raquo;</span>
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </nav>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </main>
                            <jsp:include page="../layout/footer.jsp" />
                        </div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                        crossorigin="anonymous"></script>
                    <script src="/js/scripts.js"></script>
                </body>

                </html>