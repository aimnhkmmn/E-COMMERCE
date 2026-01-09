<%--
    FootWearHub - Cart Page
    Logic: Handles session-based cart, addition/removal, and total calculation.
    Style: Monochrome, professional, compact floating checkout bar.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%
    // --- SAFE CART INITIALIZATION ---
    Object cartObj = session.getAttribute("cart");
    ArrayList<Map<String, String>> cart;
    if (cartObj instanceof ArrayList) {
        cart = (ArrayList<Map<String, String>>) cartObj;
    } else {
        cart = new ArrayList<>();
    }

    // --- LOGIC: ADD/REMOVE ITEMS ---
    String productId = request.getParameter("productId");
    String productName = request.getParameter("productName");
    String productImage = request.getParameter("productImage");
    String productPrice = request.getParameter("productPrice");
    String removeIndexStr = request.getParameter("removeIndex");

    // Add Item Logic
    if (productId != null && !productId.isEmpty() && productName != null && !productName.isEmpty()) {
        Map<String, String> product = new HashMap<>();
        product.put("id", productId);
        product.put("name", productName);
        product.put("image", (productImage != null && !productImage.isEmpty()) ? productImage : "images/shoe1.jpg");
        product.put("price", (productPrice != null && !productPrice.isEmpty()) ? productPrice : "0.00");
        cart.add(product);
    }

    // Remove Item Logic
    if (removeIndexStr != null) {
        try {
            int index = Integer.parseInt(removeIndexStr);
            if (index >= 0 && index < cart.size()) {
                cart.remove(index);
            }
        } catch (NumberFormatException e) {
            // Log the error or show a message if needed
            System.err.println("Invalid remove index: " + removeIndexStr);
        }
    }
    session.setAttribute("cart", cart);

    // --- CALCULATE TOTALS ---
    double totalPrice = 0;
    for(Map<String, String> item : cart) {
        try {
            totalPrice += Double.parseDouble(item.get("price"));
        } catch (NumberFormatException e) {
            System.err.println("Invalid price for item: " + item.get("name"));
        }
    }
    int totalItems = cart.size();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FootWearHub - Your Bag</title>
    <style>
        /* BASE STYLES */
        body {
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            background-color: #000;
            color: #fff;
            margin: 0;
            padding: 0;
        }

        .cart-wrapper {
            max-width: 1000px;
            margin: 50px auto;
            padding: 20px;
        }

        .cart-header {
            border-bottom: 2px solid #333;
            padding-bottom: 20px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
        }

        .cart-header h1 {
            font-size: 2.2em;
            letter-spacing: -1px;
            margin: 0;
            text-transform: uppercase;
        }

        .item-count-badge {
            color: #888;
            font-size: 0.9em;
            letter-spacing: 1px;
        }

        /* PRODUCT CARD STYLES */
        .cart-item {
            display: flex;
            align-items: center;
            background: #111;
            margin-bottom: 15px;
            padding: 15px;
            border-radius: 8px;
            border: 1px solid #222;
        }

        .item-img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 6px;
            background: #222;
        }

        .item-details {
            flex-grow: 1;
            padding-left: 20px;
        }

        .item-name {
            font-size: 1.2em;
            font-weight: bold;
            text-transform: uppercase;
        }

        .item-id {
            color: #666;
            font-size: 0.85em;
            margin: 4px 0;
        }

        .item-price {
            font-size: 1.1em;
            font-weight: bold;
            margin-top: 8px;
        }

        .btn-remove {
            color: #ff4444;
            text-decoration: none;
            font-size: 0.8em;
            margin-top: 10px;
            display: inline-block;
            text-transform: uppercase;
        }

        /* REFINED COMPACT CHECKOUT BAR */
        .cart-footer {
            margin-top: 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 80px;
        }

        .btn-back {
            color: #fff;
            text-decoration: none;
            border: 1px solid #444;
            padding: 10px 20px;
            border-radius: 30px;
            font-size: 0.85em;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            border-color: #fff;
            background: rgba(255,255,255,0.05);
        }

        /* MONOCHROME FLOATING BAR (Matches image_770a8a.png) */
        .checkout-floating-bar {
            display: flex;
            align-items: center;
            background-color: #fff; /* High contrast */
            border-radius: 6px;
            overflow: hidden;
            border: 1px solid #ddd;
            /* Subtle white glow on black BG */
            box-shadow: 0 5px 20px rgba(255, 255, 255, 0.08);
            transition: transform 0.3s ease;
        }

        .checkout-floating-bar:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(255, 255, 255, 0.12);
        }

        .total-info-section {
            padding: 12px 30px;
            color: #000;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .total-label-small {
            font-size: 0.8em;
            font-weight: 500;
            color: #777;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .total-price-large {
            font-size: 1.5em; /* Proportional size */
            font-weight: 900;
            color: #000;
            letter-spacing: -0.5px;
        }

        .btn-checkout-black {
            background-color: #111; /* Dark black button */
            color: #fff;
            padding: 18px 45px;
            text-decoration: none;
            font-weight: 700;
            font-size: 0.95em;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: background 0.3s ease;
            border: none;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .btn-checkout-black:hover {
            background-color: #333;
        }

        .empty-msg {
            text-align: center;
            padding: 120px 0;
        }
    </style>
</head>
<body>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />

<div class="cart-wrapper">
    <div class="cart-header">
        <h1>YOUR BAG</h1>
        <span class="item-count-badge"><%= totalItems %> <%= totalItems == 1 ? "ITEM" : "ITEMS" %></span>
    </div>

    <% if (cart.isEmpty()) { %>
    <div class="empty-msg">
        <p style="font-size: 1.2em; color: #666;">Your bag is currently empty.</p>
        <br><br>
        <a href="index.jsp" class="btn-back">START SHOPPING</a>
    </div>
    <% } else { %>

    <%-- Loop through cart items --%>
    <% for (int i = 0; i < cart.size(); i++) {
        Map<String, String> item = cart.get(i);
    %>
    <div class="cart-item">
        <img src="<%= item.get("image") %>" alt="product" class="item-img">
        <div class="item-details">
            <div class="item-name"><%= item.get("name") %></div>
            <div class="item-id">ID: <%= item.get("id") %></div>
            <div class="item-price">RM <%= String.format("%.2f", Double.parseDouble(item.get("price"))) %></div>
            <a href="addToCart.jsp?removeIndex=<%= i %>" class="btn-remove">Remove</a>
        </div>
    </div>
    <% } %>

    <div class="cart-footer">
        <a href="index.jsp" class="btn-back">← BACK TO SHOP</a>

        <div class="checkout-floating-bar">
            <div class="total-info-section">
                <span class="total-label-small">TOTAL (<%= totalItems %> <%= totalItems == 1 ? "ITEM" : "ITEMS" %>)</span>
                <span class="total-price-large">RM <%= String.format("%.2f", totalPrice) %></span>
            </div>
            <a href="checkout.jsp" class="btn-checkout-black">
                CHECK OUT <span>→</span>
            </a>
        </div>
    </div>
    <% } %>
</div>

</body>
</html>