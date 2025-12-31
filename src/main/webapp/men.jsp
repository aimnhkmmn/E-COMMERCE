<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />
<%@ page import="com.ecommerce.Product" %>
<%@ page import="com.ecommerce.ProductLoader" %>
<%@ page import="java.util.List" %>

<link rel="stylesheet" href="css/shop-style.css">

<div class="shop-container">

    <aside class="shop-sidebar">
        <div class="filter-group">
            <h3>Category</h3>
            <label><input type="checkbox"> Running</label>
            <label><input type="checkbox"> Casual</label>
            <label><input type="checkbox"> Basketball</label>
            <label><input type="checkbox"> Hiking</label>
        </div>

        <div class="filter-group">
            <h3>Size</h3>
            <div class="size-grid">
                <button>7</button> <button>8</button> <button>9</button>
                <button>10</button> <button>11</button> <button>12</button>
            </div>
        </div>

        <div class="filter-group">
            <h3>Price Range</h3>
            <input type="range" min="0" max="500" class="price-slider">
            <div class="price-labels">
                <span>$0</span> <span>$500</span>
            </div>
        </div>
    </aside>

    <main class="shop-content">

        <div class="shop-header">
            <h2>Men's Shoes</h2>
            <p>Showing 4 products</p>
        </div>

        <%
            // 1. Find the REAL path to the JSON file on your server
            String jsonPath = application.getRealPath("/data/products.json");

            // 2. Use our helper class to load the list
            List<Product> allProducts = ProductLoader.loadProducts(jsonPath);
        %>
            <div class="product-grid">

                <%
                    // LOOP: Go through every product in our list
                    if (allProducts != null) {
                        for (Product p : allProducts) {

                            // FILTER: Only show "Men" shoes on this page
                            if ("Men".equalsIgnoreCase(p.getCategory())) {
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

                <%
                            } // End of Filter If
                        } // End of For Loop
                    } // End of Null Check
                %>
            </div>

    </main>
</div>

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />