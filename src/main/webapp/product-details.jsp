<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ecommerce.Product" %>
<%@ page import="com.ecommerce.ProductLoader" %>
<%@ page import="java.util.List" %>

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

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= (product != null) ? product.getName() : "Product Not Found" %> - FootWearHub</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/product-details.css">
</head>
<body>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />

<main class="content-wrapper">
    <% if (product != null) { %>
    <div class="details-container">
        <div class="details-left">
            <div class="image-showcase">
                <img src="<%= request.getContextPath() %>/<%= product.getImage() %>" alt="<%= product.getName() %>">
            </div>
        </div>
        <div class="details-right">
            <span class="product-brand"><%= product.getBrand() %></span>
            <h1 class="product-title"><%= product.getName() %></h1>
            <p class="product-description"><%= product.getDescription() %></p>
            <div class="product-price">$<%= String.format("%.2f", product.getPrice()) %></div>

            <form action="addToCart.jsp" method="POST">
                <input type="hidden" name="productId" value="<%= product.getId() %>">
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
        <a href="index.jsp" class="btn-back">Back to Home</a>
    </div>
    <% } %>
</main>

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />

</body>
</html>