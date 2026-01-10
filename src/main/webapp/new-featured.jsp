<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ecommerce.Product" %>
<%@ page import="com.ecommerce.ProductLoader" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.stream.Collectors" %>

<%
    // --- 1. LOAD ALL PRODUCTS ---
    String jsonPath = application.getRealPath("/data/products.json");
    List<Product> allProducts = ProductLoader.loadProducts(jsonPath);

    // --- 2. GET FILTERS & SORTING FROM REQUEST ---
    String selectedCategory = request.getParameter("category"); // Men, Women, Kids
    String[] selectedBrands = request.getParameterValues("brand");
    String sortBy = request.getParameter("sort");

    // --- 3. APPLY FILTERS AND SORTING ---
    List<Product> filteredList = allProducts.stream()
            // BASE RULE: Only show "New" products on this page
            .filter(Product::isNew)
            // FILTER 1: Category (Men/Women/Kids)
            .filter(p -> selectedCategory == null || selectedCategory.isEmpty() || selectedCategory.equalsIgnoreCase(p.getCategory()))
            // FILTER 2: Brand (Nike, Adidas, etc.)
            .filter(p -> selectedBrands == null || Arrays.asList(selectedBrands).contains(p.getBrand()))
            .collect(Collectors.toList());

    // Apply Sorting
    if ("price_asc".equals(sortBy)) {
        filteredList.sort(Comparator.comparingDouble(Product::getPrice));
    } else if ("price_desc".equals(sortBy)) {
        filteredList.sort(Comparator.comparingDouble(Product::getPrice).reversed());
    }

    // --- 4. PAGINATION LOGIC ---
    int currentPage = 1;
    if (request.getParameter("page") != null) {
        try {
            currentPage = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) { currentPage = 1; }
    }

    int productsPerPage = 20;
    int totalProducts = filteredList.size();
    int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);

    // Safety check to prevent index errors
    int start = (currentPage - 1) * productsPerPage;
    if (start < 0) start = 0;
    int end = Math.min(start + productsPerPage, totalProducts);

    List<Product> displayList = new ArrayList<>();
    if (start < totalProducts) {
        displayList = filteredList.subList(start, end);
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
            <form id="filterForm" method="get" action="new-featured.jsp">

                <div class="filter-group">
                    <h3>Category</h3>
                    <div class="type-filter">
                        <a href="new-featured.jsp"
                           class="<%= selectedCategory == null ? "active" : "" %>">All</a>

                        <a href="new-featured.jsp?category=Men<%= sortBy != null ? "&sort=" + sortBy : "" %>"
                           class="<%= "Men".equalsIgnoreCase(selectedCategory) ? "active" : "" %>">Men</a>

                        <a href="new-featured.jsp?category=Women<%= sortBy != null ? "&sort=" + sortBy : "" %>"
                           class="<%= "Women".equalsIgnoreCase(selectedCategory) ? "active" : "" %>">Women</a>

                        <a href="new-featured.jsp?category=Kids<%= sortBy != null ? "&sort=" + sortBy : "" %>"
                           class="<%= "Kids".equalsIgnoreCase(selectedCategory) ? "active" : "" %>">Kids</a>
                    </div>
                    <% if (selectedCategory != null) { %>
                    <input type="hidden" name="category" value="<%= selectedCategory %>">
                    <% } %>
                </div>

                <div class="filter-group">
                    <h3>Brand</h3>
                    <div class="brand-filter">
                        <label>
                            <input type="checkbox" name="brand" value="Nike" onchange="submitForm()"
                                <%= (selectedBrands != null && Arrays.asList(selectedBrands).contains("Nike")) ? "checked" : "" %>> Nike
                        </label>
                        <label>
                            <input type="checkbox" name="brand" value="Adidas" onchange="submitForm()"
                                <%= (selectedBrands != null && Arrays.asList(selectedBrands).contains("Adidas")) ? "checked" : "" %>> Adidas
                        </label>
                        <label>
                            <input type="checkbox" name="brand" value="Puma" onchange="submitForm()"
                                <%= (selectedBrands != null && Arrays.asList(selectedBrands).contains("Puma")) ? "checked" : "" %>> Puma
                        </label>
                    </div>
                </div>

                <input type="hidden" name="sort" value="<%= sortBy != null ? sortBy : "" %>">
            </form>
        </aside>

        <main class="shop-content">

            <div class="shop-header">
                <div>
                    <h2>New Arrivals</h2>
                    <p>Showing <%= displayList.size() %> fresh drops</p>
                </div>

                <div class="sort-dropdown">
                    <form id="sortForm" method="get" action="new-featured.jsp">
                        <select name="sort" onchange="submitSortForm()">
                            <option value="">Sort by</option>
                            <option value="price_asc" <%= "price_asc".equals(sortBy) ? "selected" : "" %>>Price: Low to High</option>
                            <option value="price_desc" <%= "price_desc".equals(sortBy) ? "selected" : "" %>>Price: High to Low</option>
                        </select>

                        <% if (selectedCategory != null) { %>
                        <input type="hidden" name="category" value="<%= selectedCategory %>">
                        <% } %>
                        <% if (selectedBrands != null) {
                            for (String brand : selectedBrands) { %>
                        <input type="hidden" name="brand" value="<%= brand %>">
                        <%  }
                        } %>
                    </form>
                </div>
            </div>

            <div class="product-grid">
                <% for (Product p : displayList) { %>
                <div class="product-card">
                    <div class="badge-new">New</div>

                    <a href="product-details.jsp?id=<%= p.getId() %>" class="card-image-box">
                        <img src="<%= p.getImage() %>" alt="<%= p.getName() %>">
                    </a>

                    <div class="card-details">
                        <span class="brand"><%= p.getBrand() %></span>
                        <h4>
                            <a href="product-details.jsp?id=<%= p.getId() %>"><%= p.getName() %></a>
                        </h4>
                        <div class="price-row">
                            <span class="current-price">$<%= p.getPrice() %></span>
                        </div>

                        <form action="addToCart.jsp" method="POST">
                            <input type="hidden" name="productId" value="<%= p.getId() %>">
                            <button type="submit" class="btn-add-cart">Add to Cart</button>
                        </form>
                    </div>
                </div>
                <% } %>

                <% if (displayList.isEmpty()) { %>
                <div style="grid-column: 1/-1; text-align: center; padding: 40px;">
                    <h3>No new arrivals match your filters.</h3>
                    <p>Try clearing the filters to see more.</p>
                </div>
                <% } %>
            </div>

            <div class="pagination">
                <% if (totalPages > 1) { %>
                <% for (int i = 1; i <= totalPages; i++) { %>
                <a href="new-featured.jsp?page=<%= i %><%= selectedCategory != null ? "&category=" + selectedCategory : "" %><%= sortBy != null ? "&sort=" + sortBy : "" %>"
                   class="<%= (i == currentPage) ? "active" : "" %>">
                    <%= i %>
                </a>
                <% } %>
                <% } %>
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