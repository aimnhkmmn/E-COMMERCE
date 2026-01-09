<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ecommerce.Product" %>
<%@ page import="com.ecommerce.ProductLoader" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
    String jsonPath = application.getRealPath("/data/products.json");
    List<Product> allProducts = ProductLoader.loadProducts(jsonPath);
    List<Product> displayList = new ArrayList<>();
    String selectedCategory = request.getParameter("category");

    for (Product p : allProducts) {
        if (p.isNew() && (selectedCategory == null || selectedCategory.isEmpty() || selectedCategory.equalsIgnoreCase(p.getCategory()))) {
            displayList.add(p);
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>New & Featured - FootWearHub</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/shop-style.css">
</head>
<body>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />

<main class="content-wrapper">
    <div class="shop-container">
        <aside class="shop-sidebar">
            <div class="filter-group">
                <h3>Filter by</h3>
                <a href="new-featured.jsp">Show All</a>
                <a href="new-featured.jsp?category=Men">Men</a>
                <a href="new-featured.jsp?category=Women">Women</a>
                <a href="new-featured.jsp?category=Kids">Kids</a>
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
                    <a href="product-details.jsp?id=<%= p.getId() %>" class="card-image-box">
                        <img src="<%= p.getImage() %>" alt="<%= p.getName() %>">
                    </a>
                    <div class="card-details">
                        <span class="brand">Just In</span>
                        <h4><a href="product-details.jsp?id=<%= p.getId() %>"><%= p.getName() %></a></h4>
                        <div class="price-row"><span class="current-price">$<%= p.getPrice() %></span></div>
                        <form action="addToCart.jsp" method="POST"><input type="hidden" name="productId" value="<%= p.getId() %>"><button type="submit" class="btn-add-cart">Add to Cart</button></form>
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
</main>

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />

</body>
</html>