<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ecommerce.Product" %>
<%@ page import="com.ecommerce.Cart" %>
<%@ page import="com.ecommerce.CartItem" %>
<%@ page import="com.ecommerce.ProductLoader" %>
<%@ page import="java.util.List" %>

<%
    // cart initialization
    // Retrieve existing cart from session or create a new one if it doesn't exist
    Object cartObj = session.getAttribute("cart");
    Cart cart = (cartObj instanceof Cart) ? (Cart) cartObj : new Cart();

    // add item logic
    // get parameter passed from product page
    String productIdStr = request.getParameter("productId");
    String size = request.getParameter("size");

    // if ID and Size are present, we are adding a new item
    if (productIdStr != null && !productIdStr.isEmpty() && size != null && !size.isEmpty()) {
        try {
            int productId = Integer.parseInt(productIdStr);
            // load product from JSON file
            String jsonPath = application.getRealPath("/data/products.json");
            List<Product> allProducts = ProductLoader.loadProducts(jsonPath);
            // find the matching product and add it to the cart object
            for (Product p : allProducts) {
                if (p.getId() == productId) {
                    cart.addProduct(p, size);
                    break;
                }
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid product ID: " + productIdStr);
        }
    }

    // remove item logic
    // check if the user clicked a "Remove" button
    String removeIndexStr = request.getParameter("removeIndex");
    if (removeIndexStr != null) {
        try {
            int index = Integer.parseInt(removeIndexStr);
            cart.removeItem(index);
        } catch (NumberFormatException e) {
            System.err.println("Invalid remove index: " + removeIndexStr);
        }
    }

    // final update
    // save the updated cart back to the session so data persists
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
                CartItem item = cart.getItems().get(i);
                Product product = item.getProduct();
            %>
            <div class="cart-item">
                <img src="<%= request.getContextPath() %>/<%= product.getImage() %>" alt="<%= product.getName() %>" class="item-img">
                <div class="item-details">
                    <span class="item-name"><%= product.getName() %></span>
                    <span class="item-size">Size: <%= item.getSize() %></span>
                    <span class="item-id">ID: <%= product.getId() %></span>
                    <span class="item-price">RM <%= String.format("%.2f", product.getPrice()) %></span>
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