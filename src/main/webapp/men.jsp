<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />

<link rel="stylesheet" href="css/shop-style.css">

<div class="shop-container">

    <aside class="shop-sidebar">
        <div class="filter-group">
            <h3>Category</h3>
            <label><input type="checkbox"> Running</label>
            <label><input type="checkbox"> Casual</label>
            <label><input type="checkbox"> Basketball</label>
            <label><input type="checkbox"> Hiking</label>
        </div>

        <div class="filter-group">
            <h3>Size</h3>
            <div class="size-grid">
                <button>7</button> <button>8</button> <button>9</button>
                <button>10</button> <button>11</button> <button>12</button>
            </div>
        </div>

        <div class="filter-group">
            <h3>Price Range</h3>
            <input type="range" min="0" max="500" class="price-slider">
            <div class="price-labels">
                <span>$0</span> <span>$500</span>
            </div>
        </div>
    </aside>

    <main class="shop-content">

        <div class="shop-header">
            <h2>Men's Shoes</h2>
            <p>Showing 4 products</p>
        </div>

        <div class="product-grid">

            <div class="product-card">
                <div class="badge-new">New</div>
                <div class="card-image-box">
                    <img src="${pageContext.request.contextPath}/images/shoe1.jpg" alt="Shoe">
                </div>
                <div class="card-details">
                    <span class="brand">Nike</span>
                    <h4>Air Max Pro Runner</h4>
                    <div class="price-row">
                        <span class="current-price">$129.99</span>
                        <span class="old-price">$159.99</span>
                    </div>
                    <button class="btn-add-cart">Add to Cart</button>
                </div>
            </div>

            <div class="product-card">
                <div class="badge-sale">20% OFF</div>
                <div class="card-image-box">
                    <img src="${pageContext.request.contextPath}/images/shoe2.jpg" alt="Shoe">
                </div>
                <div class="card-details">
                    <span class="brand">Adidas</span>
                    <h4>Ultraboost Light</h4>
                    <div class="price-row">
                        <span class="current-price">$140.00</span>
                        <span class="old-price">$180.00</span>
                    </div>
                    <button class="btn-add-cart">Add to Cart</button>
                </div>
            </div>

            <div class="product-card">
                <div class="card-image-box">
                    <img src="${pageContext.request.contextPath}/images/shoe3.jpg" alt="Shoe">
                </div>
                <div class="card-details">
                    <span class="brand">Puma</span>
                    <h4>RS-X Efekt</h4>
                    <div class="price-row">
                        <span class="current-price">$110.00</span>
                    </div>
                    <button class="btn-add-cart">Add to Cart</button>
                </div>
            </div>

            <div class="product-card">
                <div class="badge-new">New</div>
                <div class="card-image-box">
                    <img src="${pageContext.request.contextPath}/images/shoe1.jpg" alt="Shoe">
                </div>
                <div class="card-details">
                    <span class="brand">New Balance</span>
                    <h4>NB 9060</h4>
                    <div class="price-row">
                        <span class="current-price">$150.00</span>
                    </div>
                    <button class="btn-add-cart">Add to Cart</button>
                </div>
            </div>

        </div>
    </main>
</div>

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />