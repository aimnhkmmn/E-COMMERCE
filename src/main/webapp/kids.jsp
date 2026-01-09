<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ecommerce.Product" %>
<%@ page import="com.ecommerce.ProductLoader" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
    String jsonPath = application.getRealPath("/data/products.json");
    List<Product> allProducts = ProductLoader.loadProducts(jsonPath);
    List<Product> filteredList = new ArrayList<>();
    String selectedType = request.getParameter("type");

    for (Product p : allProducts) {
        if ("Kids".equalsIgnoreCase(p.getCategory()) && (selectedType == null || selectedType.isEmpty() || selectedType.equalsIgnoreCase(p.getType()))) {
            filteredList.add(p);
        }
    }

    int currentPage = 1;
    if (request.getParameter("page") != null) {
        currentPage = Integer.parseInt(request.getParameter("page"));
    }
    int productsPerPage = 22;
    int totalProducts = filteredList.size();
    int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);
    int start = (currentPage - 1) * productsPerPage;
    int end = Math.min(start + productsPerPage, totalProducts);
    List<Product> displayList = filteredList.subList(start, end);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kids' Shoes - FootWearHub</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/shop-style.css">
</head>
<body>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />

<main class="content-wrapper">
    <div class="shop-container">
        <aside class="shop-sidebar">
            <div class="filter-group">
                <h3>Category</h3>
                <a href="kids.jsp">All</a>
                <a href="kids.jsp?type=Running">Running</a>
                <a href="kids.jsp?type=Casual">Casual</a>
                <a href="kids.jsp?type=Basketball">Basketball</a>
            </div>
        </aside>
        <main class="shop-content">
            <div class="shop-header">
                <h2>Kids' Shoes</h2>
                <p>Showing <%= displayList.size() %> of <%= totalProducts %> products</p>
            </div>
            <div class="product-grid">
                <% for (Product p : displayList) { %>
                <div class="product-card">
                    <% if (p.isNew()) { %><div class="badge-new">New</div><% } else if (p.isSale()) { %><div class="badge-sale">Sale</div><% } %>
                    <a href="product-details.jsp?id=<%= p.getId() %>" class="card-image-box">
                        <img src="<%= p.getImage() %>" alt="<%= p.getName() %>">
                    </a>
                    <div class="card-details">
                        <span class="brand"><%= p.getBrand() %></span>
                        <h4><a href="product-details.jsp?id=<%= p.getId() %>"><%= p.getName() %></a></h4>
                        <p><%= p.getDescription() %></p>
                        <div class="price-row"><span class="current-price">$<%= p.getPrice() %></span></div>
                        <form action="addToCart.jsp" method="POST"><input type="hidden" name="productId" value="<%= p.getId() %>"><button type="submit" class="btn-add-cart">Add to Cart</button></form>
                    </div>
                </div>
                <% } %>
                <% if (displayList.isEmpty()) { %><p>No products found.</p><% } %>
            </div>
            <div class="pagination">
                <a href="kids.jsp?page=<%= currentPage - 1 %><% if (selectedType != null) {%>&type=<%= selectedType %><% } %>" class="<%= (currentPage > 1) ? "" : "disabled" %>">&laquo;</a>
                <% for (int i = 1; i <= totalPages; i++) { %>
                <a href="kids.jsp?page=<%= i %><% if (selectedType != null) {%>&type=<%= selectedType %><% } %>" class="<%= (i == currentPage) ? "active" : "" %>"><%= i %></a>
                <% } %>
                <a href="kids.jsp?page=<%= currentPage + 1 %><% if (selectedType != null) {%>&type=<%= selectedType %><% } %>" class="<%= (currentPage < totalPages) ? "" : "disabled" %>">&raquo;</a>
            </div>
        </main>
    </div>
</main>

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />

</body>
</html>