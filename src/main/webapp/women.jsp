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
    List<Product> displayList = new ArrayList<>();

    // --- 2. GET FILTER ---
    String selectedType = request.getParameter("type");

    if (allProducts != null) {
        for (Product p : allProducts) {

            // FILTER 1: Only look for "Women" shoes
            if ("Women".equalsIgnoreCase(p.getCategory())) {

                // FILTER 2: Check the 'type'
                if (selectedType == null || selectedType.isEmpty() || selectedType.equalsIgnoreCase(p.getType())) {
                    displayList.add(p);
                }
            }
        }
    }
%>

<div class="shop-container">

    <aside class="shop-sidebar">
        <div class="filter-group">
            <h3>Category</h3>
            <a href="women.jsp" style="display:block; margin:5px 0; color: #555; text-decoration: none;">All</a>
            <a href="women.jsp?type=Running" style="display:block; margin:5px 0; color: #555; text-decoration: none;">Running</a>
            <a href="women.jsp?type=Casual" style="display:block; margin:5px 0; color: #555; text-decoration: none;">Casual</a>
            <a href="women.jsp?type=Basketball" style="display:block; margin:5px 0; color: #555; text-decoration: none;">Basketball</a>
            <a href="women.jsp?type=Hiking" style="display:block; margin:5px 0; color: #555; text-decoration: none;">Hiking</a>
        </div>
    </aside>

    <main class="shop-content">

        <div class="shop-header">
            <h2>Women's Shoes</h2>
            <p>Showing <%= displayList.size() %> products</p>
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
                    <span class="brand">Nike</span>
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

            <% if (displayList.isEmpty()) { %>
            <div style="grid-column: 1/-1; text-align: center; padding: 40px;">
                <h3>No women's products found.</h3>
            </div>
            <% } %>

        </div>
    </main>
</div>

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />