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

    // --- 2. GET FILTER FROM URL ---
    // If user clicks a checkbox, the URL will look like: men.jsp?type=Running
    String selectedType = request.getParameter("type");

    if (allProducts != null) {
        for (Product p : allProducts) {

            // First, make sure it's a Men's shoe
            if ("Men".equalsIgnoreCase(p.getCategory())) {

                // --- 3. APPLY FILTER LOGIC ---
                // If NO filter is selected, show everything.
                // If a filter IS selected, only show shoes that match that type.
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
            <a href="men.jsp" style="display:block; margin:5px 0; color: #555; text-decoration: none;">All</a>
            <a href="men.jsp?type=Running" style="display:block; margin:5px 0; color: #555; text-decoration: none;">Running</a>
            <a href="men.jsp?type=Casual" style="display:block; margin:5px 0; color: #555; text-decoration: none;">Casual</a>
            <a href="men.jsp?type=Basketball" style="display:block; margin:5px 0; color: #555; text-decoration: none;">Basketball</a>
        </div>

    </aside>

    <main class="shop-content">

        <div class="shop-header">
            <h2>Men's Shoes</h2>
            <p>Showing <%= displayList.size() %> products</p>
        </div>

        <div class="product-grid">

            <%
                // Loop through our PRE-FILTERED list
                for (Product p : displayList) {
            %>

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

                    <div class="price-row">
                        <span class="current-price">$<%= p.getPrice() %></span>
                    </div>

                    <button class="btn-add-cart">Add to Cart</button>
                </div>
            </div>

            <% } // End Loop %>

            <% if (displayList.isEmpty()) { %>
            <p>No products found in this category.</p>
            <% } %>

        </div>
    </main>
</div>

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />