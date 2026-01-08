<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%
    // --- LOGIC: ADD/REMOVE ITEMS ---
    String productId = request.getParameter("productId");
    String productName = request.getParameter("productName");
    String productImage = request.getParameter("productImage");
    String removeIndex = request.getParameter("removeIndex");

    ArrayList<Map<String, String>> cart = (ArrayList<Map<String, String>>) session.getAttribute("cart");
    if (cart == null) { cart = new ArrayList<>(); }

    // Logic to Add Item
    if (productId != null && productName != null) {
        Map<String, String> product = new HashMap<>();
        product.put("id", productId);
        product.put("name", productName);
        product.put("image", (productImage != null && !productImage.isEmpty()) ? productImage : "images/shoe1.jpg");
        product.put("price", "299.00");
        cart.add(product);
        session.setAttribute("cart", cart);
    }

    // Logic to Remove Item
    if (removeIndex != null) {
        try {
            int index = Integer.parseInt(removeIndex);
            if (index >= 0 && index < cart.size()) {
                cart.remove(index);
                session.setAttribute("cart", cart);
            }
        } catch (Exception e) {}
    }

    // Calculate Grand Total
    double total = 0;
    for(Map<String, String> item : cart) {
        total += Double.parseDouble(item.get("price"));
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FootWearHub - Your Bag</title>
    <style>
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
        }
        .cart-header h1 {
            font-size: 2.5em;
            letter-spacing: -1px;
            margin: 0;
        }
        .cart-item {
            display: flex;
            align-items: center;
            background: #111;
            margin-bottom: 15px;
            padding: 20px;
            border-radius: 10px;
            border: 1px solid #222;
        }
        .item-img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
            background: #222;
        }
        .item-details {
            flex-grow: 1;
            padding-left: 25px;
        }
        .item-name {
            font-size: 1.4em;
            font-weight: bold;
            text-transform: uppercase;
        }
        .item-id { color: #888; font-size: 0.9em; margin: 5px 0; }
        .item-price { font-size: 1.2em; font-weight: bold; margin-top: 10px; color: #fff; }

        /* BUTTONS */
        .btn-white {
            background-color: #fff;
            color: #000;
            padding: 12px 25px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: bold;
            display: inline-block;
            transition: opacity 0.3s;
        }
        .btn-white:hover { opacity: 0.8; }

        .btn-outline {
            color: #fff;
            text-decoration: none;
            border: 1px solid #fff;
            padding: 10px 20px;
            border-radius: 30px;
            font-size: 0.9em;
        }

        .btn-remove {
            color: #ff4444;
            text-decoration: none;
            font-size: 0.85em;
            margin-top: 10px;
            display: inline-block;
        }

        /* CHECKOUT BAR STYLING (MATCHING YOUR PHOTO) */
        .cart-footer {
            margin-top: 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0;
        }

        .checkout-bar {
            display: flex;
            align-items: center;
            background-color: #fff; /* White background as per image */
            border-radius: 4px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
        }

        .total-container {
            padding: 0 25px;
            color: #333;
            font-size: 1.1em;
        }

        .total-label {
            color: #000;
        }

        .total-value {
            color: #ee4d2d; /* Orange/Red price color */
            font-size: 1.5em;
            font-weight: 500;
            margin-left: 5px;
        }

        .btn-checkout-orange {
            background-color: #ee4d2d; /* Orange background */
            color: #fff;
            padding: 20px 50px;
            text-decoration: none;
            font-weight: bold;
            font-size: 1.1em;
            transition: background 0.3s;
            border: none;
            cursor: pointer;
        }

        .btn-checkout-orange:hover {
            background-color: #ff5722;
        }

        .empty-msg { text-align: center; padding: 100px 0; }
    </style>
</head>
<body>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />

<div class="cart-wrapper">
    <div class="cart-header">
        <h1>YOUR BAG</h1>
    </div>

    <% if (cart.isEmpty()) { %>
    <div class="empty-msg">
        <p style="font-size: 1.2em; color: #888;">Your bag is empty.</p>
        <br>
        <a href="index.jsp" class="btn-white">Shop Now</a>
    </div>
    <% } else { %>

    <% for (int i = 0; i < cart.size(); i++) {
        Map<String, String> item = cart.get(i);
    %>
    <div class="cart-item">
        <img src="<%= item.get("image") %>" alt="shoe" class="item-img">
        <div class="item-details">
            <div class="item-name"><%= item.get("name") %></div>
            <div class="item-id">ID: <%= item.get("id") %></div>
            <div class="item-price">RM <%= item.get("price") %></div>
            <a href="addToCart.jsp?removeIndex=<%= i %>" class="btn-remove">Remove</a>
        </div>
    </div>
    <% } %>

    <div class="cart-footer">
        <a href="index.jsp" class="btn-outline">← Back to Shop</a>

        <div class="checkout-bar">
            <div class="total-container">
                <span class="total-label">Total (<%= cart.size() %> item<%= cart.size() > 1 ? "s" : "" %>):</span>
                <span class="total-value">RM<%= String.format("%.2f", total) %></span>
            </div>
            <a href="checkout.jsp" class="btn-checkout-orange">Check Out</a>
        </div>
    </div>
    <% } %>
</div>

</body>
</html>