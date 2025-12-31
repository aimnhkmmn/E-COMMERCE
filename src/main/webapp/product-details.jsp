<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ecommerce.Product" %>
<%@ page import="com.ecommerce.ProductLoader" %>
<%@ page import="java.util.List" %>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/men-style.css">
<%
    // 1. Get the ID from the URL (e.g., ?id=2)
    String idParam = request.getParameter("id");
    Product selectedProduct = null;

    // 2. Load all products
    String jsonPath = application.getRealPath("/data/products.json");
    List<Product> allProducts = ProductLoader.loadProducts(jsonPath);

    // 3. Find the matching product
    if (idParam != null && allProducts != null) {
        int targetId = Integer.parseInt(idParam);
        for (Product p : allProducts) {
            if (p.getId() == targetId) {
                selectedProduct = p;
                break;
            }
        }
    }
%>

<div class="shop-container" style="justify-content: center; margin-top: 50px;">

    <% if (selectedProduct != null) { %>

    <div class="detail-image" style="flex: 1; max-width: 500px;">
        <img src="${pageContext.request.contextPath}/<%= selectedProduct.getImage() %>"
             alt="<%= selectedProduct.getName() %>" style="width: 100%; border-radius: 10px;">
    </div>

    <div class="detail-info" style="flex: 1; max-width: 500px; padding-left: 50px;">
        <h4 style="color: #888; text-transform: uppercase;">Men's Shoe</h4>
        <h1 style="font-size: 2.5rem; margin: 10px 0;"><%= selectedProduct.getName() %></h1>
        <h2 style="font-size: 1.8rem; margin-bottom: 20px;">$<%= selectedProduct.getPrice() %></h2>

        <p style="color: #555; line-height: 1.6; margin-bottom: 30px;">
            Experience ultimate comfort and style with the <%= selectedProduct.getName() %>.
            Perfect for daily wear or your next adventure.
        </p>

        <div class="size-selector" style="margin-bottom: 30px;">
            <h4 style="margin-bottom: 10px;">Select Size</h4>
            <div class="size-grid" style="grid-template-columns: repeat(5, 1fr);">
                <button>7</button> <button>8</button> <button>9</button>
                <button>10</button> <button>11</button>
            </div>
        </div>

        <button class="btn-add-cart" style="font-size: 1.1rem; padding: 15px;">Add to Cart</button>
    </div>

    <% } else { %>
    <h1>Product not found!</h1>
    <p>Go back to <a href="men.jsp">Shop</a></p>
    <% } %>

</div>

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />