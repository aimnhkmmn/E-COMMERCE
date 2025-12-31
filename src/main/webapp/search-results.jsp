<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ecommerce.Product" %>
<%@ page import="com.ecommerce.ProductLoader" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />

<link rel="stylesheet" href="css/shop-style.css">

<%
    // --- 1. GET THE SEARCH QUERY ---
    // The "q" matches the name="q" we put in the header input
    String query = request.getParameter("q");

    // --- 2. LOAD DATA ---
    String jsonPath = application.getRealPath("/data/products.json");
    List<Product> allProducts = ProductLoader.loadProducts(jsonPath);
    List<Product> searchResults = new ArrayList<>();

    // --- 3. FILTER LOGIC ---
    if (allProducts != null && query != null && !query.trim().isEmpty()) {
        String safeQuery = query.toLowerCase().trim(); // Convert to lowercase for easy matching

        for (Product p : allProducts) {
            // Check if the Product Name contains the Search Text
            if (p.getName().toLowerCase().contains(safeQuery)) {
                searchResults.add(p);
            }
            // Optional: You could also check p.getCategory() or p.getType() here
        }
    }
%>

<div class="shop-container" style="justify-content: center;">
    <main class="shop-content" style="width: 100%;">

        <div class="shop-header">
            <% if (query != null && !query.isEmpty()) { %>
            <h2>Search Results for "<%= query %>"</h2>
            <p>Found <%= searchResults.size() %> matches</p>
            <% } else { %>
            <h2>Search</h2>
            <p>Please enter a keyword</p>
            <% } %>
        </div>

        <div class="product-grid">

            <% for (Product p : searchResults) { %>

            <div class="product-card">
                <% if (p.isNew()) { %> <div class="badge-new">New</div> <% } %>
                <% if (p.isSale()) { %> <div class="badge-sale">Sale</div> <% } %>

                <div class="card-image-box">
                    <a href="product-details.jsp?id=<%= p.getId() %>">
                        <img src="${pageContext.request.contextPath}/<%= p.getImage() %>" alt="<%= p.getName() %>">
                    </a>
                </div>

                <div class="card-details">
                    <span class="brand">FootWearHub</span>
                    <h4>
                        <a href="product-details.jsp?id=<%= p.getId() %>" style="text-decoration: none; color: inherit;">
                            <%= p.getName() %>
                        </a>
                    </h4>

                    <div class="price-row">
                        <span class="current-price">$<%= p.getPrice() %></span>
                    </div>

                    <button class="btn-add-cart">Add to Cart</button>
                </div>
            </div>

            <% } %>

            <% if (searchResults.isEmpty() && query != null && !query.isEmpty()) { %>
            <div style="grid-column: 1/-1; text-align: center; padding: 50px;">
                <h3 style="color: #555;">No matches found.</h3>
                <p>Try checking your spelling or use general terms like "Nike" or "Adidas".</p>
                <a href="men.jsp" style="display:inline-block; margin-top:15px; text-decoration: underline; color: black;">Back to Shop</a>
            </div>
            <% } %>

        </div>
    </main>
</div>

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />