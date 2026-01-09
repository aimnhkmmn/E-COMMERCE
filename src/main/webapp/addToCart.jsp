<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ecommerce.Product" %>
<%@ page import="com.ecommerce.Cart" %>
<%@ page import="com.ecommerce.ProductLoader" %>
<%@ page import="java.util.List" %>

<%
    Object cartObj = session.getAttribute("cart");
    Cart cart = (cartObj instanceof Cart) ? (Cart) cartObj : new Cart();

    String productIdStr = request.getParameter("productId");
    if (productIdStr != null && !productIdStr.isEmpty()) {
        try {
            int productId = Integer.parseInt(productIdStr);
            String jsonPath = application.getRealPath("/data/products.json");
            List<Product> allProducts = ProductLoader.loadProducts(jsonPath);
            for (Product p : allProducts) {
                if (p.getId() == productId) {
                    cart.addProduct(p);
                    break;
                }
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid product ID: " + productIdStr);
        }
    }

    String removeIndexStr = request.getParameter("removeIndex");
    if (removeIndexStr != null) {
        try {
            int index = Integer.parseInt(removeIndexStr);
            cart.removeProduct(index);
        } catch (NumberFormatException e) {
            System.err.println("Invalid remove index: " + removeIndexStr);
        }
    }
    session.setAttribute("cart", cart);

    double totalPrice = cart.getTotal();
    int totalItems = cart.getItemCount();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FootWearHub - Your Bag</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cart-style.css">
</head>
<body>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />

<main class="content-wrapper">
    <div class="cart-wrapper">
        <div class="cart-header">
            <h1>YOUR BAG</h1>
            <span class="item-count-badge"><%= totalItems %> <%= totalItems == 1 ? "ITEM" : "ITEMS" %></span>
        </div>

        <% if (cart.getItemCount() == 0) { %>
        <div class="empty-msg">
            <p>Your bag is currently empty.</p>
            <a href="index.jsp" class="btn-back">START SHOPPING</a>
        </div>
        <% } else { %>
            <% for (int i = 0; i < cart.getItemCount(); i++) {
                Product item = cart.getItems().get(i);
            %>
            <div class="cart-item">
                <img src="<%= request.getContextPath() %>/<%= item.getImage() %>" alt="<%= item.getName() %>" class="item-img">
                <div class="item-details">
                    <span class="item-name"><%= item.getName() %></span>
                    <span class="item-id">ID: <%= item.getId() %></span>
                    <span class="item-price">RM <%= String.format("%.2f", item.getPrice()) %></span>
                </div>
                <a href="addToCart.jsp?removeIndex=<%= i %>" class="btn-remove">Remove</a>
            </div>
            <% } %>

            <div class="cart-footer">
                <a href="index.jsp" class="btn-back">← Back to Shop</a>
                <div class="checkout-floating-bar">
                    <div class="total-info-section">
                        <span class="total-label-small">TOTAL</span>
                        <span class="total-price-large">RM <%= String.format("%.2f", totalPrice) %></span>
                    </div>
                    <a href="checkout.jsp" class="btn-checkout-black">Checkout →</a>
                </div>
            </div>
        <% } %>
    </div>
</main>

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />

</body>
</html>