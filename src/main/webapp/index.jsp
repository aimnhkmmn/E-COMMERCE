<%@ page contentType="text/html; charset=UTF-8" %>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />

<style>
    /* Styling to handle multiple buttons in one slide */
    .button-group {
        display: flex;
        gap: 10px;
        margin-top: 15px;
    }

    .add-to-cart-btn {
        background-color: #000;
        color: #fff;
        padding: 10px 20px;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .add-to-cart-btn:hover {
        background-color: #444;
    }
</style>

<section class="hero-carousel">

    <button class="carousel-btn prev-btn" onclick="scrollCarousel(-1)">&#10094;</button>
    <button class="carousel-btn next-btn" onclick="scrollCarousel(1)">&#10095;</button>

    <div class="carousel-track" id="heroTrack">

        <div class="carousel-slide">
            <div class="slide-content">
                <span>New Arrival</span>
                <h1>AIR MAX PULSE</h1>
                <p>Extreme comfort. Infinite style.</p>
                <div class="button-group">
                    <button>Shop Now</button>
                    <form action="addToCart.jsp" method="POST" style="margin:0;">
                        <input type="hidden" name="productId" value="1">
                        <input type="hidden" name="productName" value="Nike Air Max Pulse">
                        <input type="hidden" name="productPrice" value="120.00">
                        <input type="hidden" name="productImage" value="images/shoe1.jpg">
                        <button type="submit" class="add-to-cart-btn">Add to Cart</button>
                    </form>
                </div>
            </div>
            <img src="images/shoe1.jpg" alt="Shoe 1" class="slide-bg">
        </div>

        <div class="carousel-slide">
            <div class="slide-content">
                <span>Trending</span>
                <h1>SPEED DEMON</h1>
                <p>Built for speed. Designed for you.</p>
                <div class="button-group">
                    <button>See Details</button>
                    <form action="addToCart.jsp" method="POST" style="margin:0;">
                        <input type="hidden" name="productId" value="2">
                        <input type="hidden" name="productName" value="Adidas Speed Demon">
                        <input type="hidden" name="productPrice" value="140.00">
                        <input type="hidden" name="productImage" value="images/shoe2.jpg">
                        <button type="submit" class="add-to-cart-btn">Add to Cart</button>
                    </form>
                </div>
            </div>
            <img src="images/shoe2.jpg" alt="Shoe 2" class="slide-bg">
        </div>

        <div class="carousel-slide">
            <div class="slide-content">
                <span>Just Dropped</span>
                <h1>JORDAN RETRO</h1>
                <p>The legend returns.</p>
                <div class="button-group">
                    <button>Buy Now</button>
                    <form action="addToCart.jsp" method="POST" style="margin:0;">
                        <input type="hidden" name="productId" value="3">
                        <input type="hidden" name="productName" value="Jordan Retro High">
                        <input type="hidden" name="productPrice" value="180.00">
                        <input type="hidden" name="productImage" value="images/shoe3.jpg">
                        <button type="submit" class="add-to-cart-btn">Add to Cart</button>
                    </form>
                </div>
            </div>
            <img src="images/shoe3.jpg" alt="Shoe 3" class="slide-bg">
        </div>

    </div>
</section>

<section class="category-split">
    <div class="cat-box" onclick="location.href='men.jsp'">
        <h3>MEN</h3>
    </div>
    <div class="cat-box" onclick="location.href='women.jsp'">
        <h3>WOMEN</h3>
    </div>
    <div class="cat-box" onclick="location.href='kids.jsp'">
        <h3>KIDS</h3>
    </div>
</section>
<jsp:include page="HomePageHTML/HomePageFooter.jsp" />