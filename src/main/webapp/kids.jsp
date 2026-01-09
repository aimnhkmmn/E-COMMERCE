<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ecommerce.Product" %>
<%@ page import="com.ecommerce.ProductLoader" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />
<link rel="stylesheet" href="css/shop-style.css">

<%
    // --- 1. SETUP ---
    String jsonPath = application.getRealPath("/data/products.json");
    List<Product> allProducts = ProductLoader.loadProducts(jsonPath);
    List<Product> filteredList = new ArrayList<>();

    // --- 2. GET FILTER FROM URL ---
    String selectedType = request.getParameter("type");

    if (allProducts != null) {
        for (Product p : allProducts) {
            if ("Kids".equalsIgnoreCase(p.getCategory())) {
                if (selectedType == null || selectedType.isEmpty() || selectedType.equalsIgnoreCase(p.getType())) {
                    filteredList.add(p);
                }
            }
        }
    }

    // --- 3. PAGINATION LOGIC ---
    int currentPage = 1;
    int productsPerPage = 22;
    if (request.getParameter("page") != null) {
        currentPage = Integer.parseInt(request.getParameter("page"));
    }

    int totalProducts = filteredList.size();
    int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);

    int start = (currentPage - 1) * productsPerPage;
    int end = Math.min(start + productsPerPage, totalProducts);

    List<Product> displayList = filteredList.subList(start, end);
%>

<div class="shop-container">

    <aside class="shop-sidebar">
        <div class="filter-group">
            <h3>Category</h3>
            <a href="kids.jsp" style="display:block; margin:5px 0; color: #555; text-decoration: none;">All</a>
            <a href="kids.jsp?type=Running" style="display:block; margin:5px 0; color: #555; text-decoration: none;">Running</a>
            <a href="kids.jsp?type=Casual" style="display:block; margin:5px 0; color: #555; text-decoration: none;">Casual</a>
            <a href="kids.jsp?type=Basketball" style="display:block; margin:5px 0; color: #555; text-decoration: none;">Basketball</a>
            <a href="kids.jsp?type=Hiking" style="display:block; margin:5px 0; color: #555; text-decoration: none;">Hiking</a>
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
                <% if (p.isNew()) { %>
                <div class="badge-new">New</div>
                <% } else if (p.isSale()) { %>
                <div class="badge-sale">Sale</div>
                <% } %>

                <div class="card-image-box">
                    <a href="product-details.jsp?id=<%= p.getId() %>">
                        <img src="${pageContext.request.contextPath}/<%= p.getImage() %>" alt="<%= p.getName() %>">
                    </a>
                </div>

                <div class="card-details">
                    <span class="brand"><%= p.getBrand() %></span>
                    <h4>
                        <a href="product-details.jsp?id=<%= p.getId() %>" style="text-decoration: none; color: inherit;">
                            <%= p.getName() %>
                        </a>
                    </h4>
                    <p><%= p.getDescription() %></p>
                    <div class="price-row">
                        <span class="current-price">$<%= p.getPrice() %></span>
                    </div>
                    <button class="btn-add-cart">Add to Cart</button>
                </div>
            </div>
            <% } %>
            <% if (displayList.isEmpty()) { %>
            <div style="grid-column: 1/-1; text-align: center; padding: 40px;">
                <h3>No kids' products found.</h3>
            </div>
            <% } %>
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

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />