<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ecommerce.Product" %>
<%@ page import="com.ecommerce.ProductLoader" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.stream.Collectors" %>

<%
    String jsonPath = application.getRealPath("/data/products.json");
    List<Product> allProducts = ProductLoader.loadProducts(jsonPath);
    String selectedType = request.getParameter("type");
    String[] selectedBrands = request.getParameterValues("brand");
    String sortBy = request.getParameter("sort");

    List<Product> filteredList = allProducts.stream()
        .filter(p -> "Women".equalsIgnoreCase(p.getCategory()))
        .filter(p -> selectedType == null || selectedType.isEmpty() || selectedType.equalsIgnoreCase(p.getType()))
        .filter(p -> selectedBrands == null || Arrays.asList(selectedBrands).contains(p.getBrand()))
        .collect(Collectors.toList());

    if ("price_asc".equals(sortBy)) {
        filteredList.sort(Comparator.comparingDouble(Product::getPrice));
    } else if ("price_desc".equals(sortBy)) {
        filteredList.sort(Comparator.comparingDouble(Product::getPrice).reversed());
    }

    int currentPage = 1;
    if (request.getParameter("page") != null) {
        currentPage = Integer.parseInt(request.getParameter("page"));
    }
    int productsPerPage = 22;
    int totalProducts = filteredList.size();
    int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);
    int start = (currentPage - 1) * productsPerPage;
    int end = Math.min(start + productsPerPage, totalProducts);
    List<Product> displayList = filteredList.subList(start, end);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Women's Shoes - FootWearHub</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/shop-style.css">
</head>
<body>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />

<main class="content-wrapper">
    <div class="shop-container">
        <aside class="shop-sidebar">
            <form id="filterForm" method="get" action="women.jsp">
                <div class="filter-group">
                    <h3>Category</h3>
                    <div class="type-filter">
                        <a href="women.jsp" class="<%= selectedType == null ? "active" : "" %>">All</a>
                        <a href="women.jsp?type=Running" class="<%= "Running".equals(selectedType) ? "active" : "" %>">Running</a>
                        <a href="women.jsp?type=Casual" class="<%= "Casual".equals(selectedType) ? "active" : "" %>">Casual</a>
                        <a href="women.jsp?type=Basketball" class="<%= "Basketball".equals(selectedType) ? "active" : "" %>">Basketball</a>
                    </div>
                </div>
                <div class="filter-group">
                    <h3>Brand</h3>
                    <div class="brand-filter">
                        <label><input type="checkbox" name="brand" value="Nike" onchange="submitForm()" <%= (selectedBrands != null && Arrays.asList(selectedBrands).contains("Nike")) ? "checked" : "" %>> Nike</label>
                        <label><input type="checkbox" name="brand" value="Adidas" onchange="submitForm()" <%= (selectedBrands != null && Arrays.asList(selectedBrands).contains("Adidas")) ? "checked" : "" %>> Adidas</label>
                        <label><input type="checkbox" name="brand" value="Puma" onchange="submitForm()" <%= (selectedBrands != null && Arrays.asList(selectedBrands).contains("Puma")) ? "checked" : "" %>> Puma</label>
                    </div>
                </div>
                <input type="hidden" name="sort" value="<%= sortBy != null ? sortBy : "" %>">
            </form>
        </aside>
        <main class="shop-content">
            <div class="shop-header">
                <h2>Women's Shoes</h2>
                <div class="sort-dropdown">
                    <form id="sortForm" method="get" action="women.jsp">
                        <select name="sort" onchange="submitSortForm()">
                            <option value="">Sort by</option>
                            <option value="price_asc" <%= "price_asc".equals(sortBy) ? "selected" : "" %>>Price: Low to High</option>
                            <option value="price_desc" <%= "price_desc".equals(sortBy) ? "selected" : "" %>>Price: High to Low</option>
                        </select>
                        <% if (selectedType != null) { %><input type="hidden" name="type" value="<%= selectedType %>"><% } %>
                        <% if (selectedBrands != null) { for (String brand : selectedBrands) { %><input type="hidden" name="brand" value="<%= brand %>"><% } } %>
                    </form>
                </div>
            </div>
            <div class="product-grid">
                <% for (Product p : displayList) { %>
                <div class="product-card">
                    <% if (p.isNew()) { %><div class="badge-new">New</div><% } else if (p.isSale()) { %><div class="badge-sale">Sale</div><% } %>
                    <a href="product-details.jsp?id=<%= p.getId() %>" class="card-image-box"><img src="<%= p.getImage() %>" alt="<%= p.getName() %>"></a>
                    <div class="card-details">
                        <span class="brand"><%= p.getBrand() %></span>
                        <h4><a href="product-details.jsp?id=<%= p.getId() %>"><%= p.getName() %></a></h4>
                        <p><%= p.getDescription() %></p>
                        <div class="price-row"><span class="current-price">$<%= p.getPrice() %></span></div>
                        <form action="addToCart.jsp" method="POST"><input type="hidden" name="productId" value="<%= p.getId() %>"><button type="submit" class="btn-add-cart">Add to Cart</button></form>
                    </div>
                </div>
                <% } %>
                <% if (displayList.isEmpty()) { %><p>No products found matching your criteria.</p><% } %>
            </div>
            <div class="pagination">
                <%-- Pagination links here --%>
            </div>
        </main>
    </div>
</main>

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />

<script>
    function submitForm() { document.getElementById('filterForm').submit(); }
    function submitSortForm() { document.getElementById('sortForm').submit(); }
</script>

</body>
</html>