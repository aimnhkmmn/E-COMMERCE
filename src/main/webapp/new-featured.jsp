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
    // On this page, we filter by Gender (Category)
    String selectedCategory = request.getParameter("category");

    if (allProducts != null) {
        for (Product p : allProducts) {

            // MAIN RULE: Only show "New" products
            if (p.isNew()) {

                // SIDEBAR FILTER: Check if user clicked "Men", "Women", etc.
                if (selectedCategory == null || selectedCategory.isEmpty() || selectedCategory.equalsIgnoreCase(p.getCategory())) {
                    displayList.add(p);
                }
            }
        }
    }
%>

<div class="shop-container">

    <aside class="shop-sidebar">
        <div class="filter-group">
            <h3>Filter by</h3>
            <a href="new-featured.jsp" style="display:block; margin:5px 0; color: #555; text-decoration: none; font-weight: bold;">Show All</a>
            <a href="new-featured.jsp?category=Men" style="display:block; margin:5px 0; color: #555; text-decoration: none;">Men</a>
            <a href="new-featured.jsp?category=Women" style="display:block; margin:5px 0; color: #555; text-decoration: none;">Women</a>
            <a href="new-featured.jsp?category=Kids" style="display:block; margin:5px 0; color: #555; text-decoration: none;">Kids</a>
        </div>
    </aside>

    <main class="shop-content">

        <div class="shop-header">
            <h2>New Arrivals & Featured</h2>
            <p>Showing <%= displayList.size() %> fresh drops</p>
        </div>

        <div class="product-grid">

            <% for (Product p : displayList) { %>

            <div class="product-card">

                <div class="badge-new">New</div>

                <div class="card-image-box">
                    <a href="product-details.jsp?id=<%= p.getId() %>">
                        <img src="${pageContext.request.contextPath}/<%= p.getImage() %>" alt="<%= p.getName() %>">
                    </a>
                </div>

                <div class="card-details">
                    <span class="brand">Just In</span>
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
                <h3>No new arrivals found right now.</h3>
                <p>Check back later for updates!</p>
            </div>
            <% } %>

        </div>
    </main>
</div>

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />