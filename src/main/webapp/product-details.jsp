<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ecommerce.Product" %>
<%@ page import="com.ecommerce.ProductLoader" %>
<%@ page import="java.util.List" %>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/product-details.css">

<%
    String idParam = request.getParameter("id");
    Product product = null;
    if (idParam != null) {
        try {
            int productId = Integer.parseInt(idParam);
            String jsonPath = application.getRealPath("/data/products.json");
            List<Product> allProducts = ProductLoader.loadProducts(jsonPath);
            for (Product p : allProducts) {
                if (p.getId() == productId) {
                    product = p;
                    break;
                }
            }
        } catch (NumberFormatException e) {
            // Handle invalid ID format
        }
    }
%>

<% if (product != null) { %>
<div class="details-container">
    <div class="details-left">
        <div class="image-showcase">
            <img src="${pageContext.request.contextPath}/<%= product.getImage() %>" alt="<%= product.getName() %>">
        </div>
    </div>
    <div class="details-right">
        <span class="product-brand"><%= product.getBrand() %></span>
        <h1 class="product-title"><%= product.getName() %></h1>
        <p class="product-description"><%= product.getDescription() %></p>
        <div class="product-price">$<%= String.format("%.2f", product.getPrice()) %></div>

        <form action="addToCart.jsp" method="POST">
            <input type="hidden" name="productId" value="<%= product.getId() %>">
            <input type="hidden" name="productName" value="<%= product.getName() %>">
            <input type="hidden" name="productPrice" value="<%= product.getPrice() %>">
            <input type="hidden" name="productImage" value="<%= product.getImage() %>">

            <div class="size-selection">
                <h3 class="size-title">Select Size</h3>
                <div class="size-options">
                    <button class="size-btn">7</button>
                    <button class="size-btn">8</button>
                    <button class="size-btn active">9</button>
                    <button class="size-btn">10</button>
                    <button class="size-btn">11</button>
                    <button class="size-btn">12</button>
                </div>
            </div>

            <div class="action-buttons">
                <button type="submit" class="btn-add-to-cart">Add to Cart</button>
                <button type="button" class="btn-wishlist">&#9825;</button>
            </div>
        </form>
    </div>
</div>
<% } else { %>
<div class="error-container">
    <h1>Product Not Found</h1>
    <p>Sorry, the product you are looking for does not exist.</p>
    <a href="${pageContext.request.contextPath}/index.jsp" class="btn-back">Back to Home</a>
</div>
<% } %>

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />