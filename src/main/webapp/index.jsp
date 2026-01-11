<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FootWearHub</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        .button-group { display: flex; gap: 10px; margin-top: 15px; }
        .add-to-cart-btn { background-color: #000; color: #fff; padding: 10px 20px; border: none; cursor: pointer; transition: background-color 0.3s; }
        .add-to-cart-btn:hover { background-color: #444; }

        /* Styles for Category Boxes with Background Images */
        .cat-box {
            position: relative; /* Needed for the overlay */
            background-size: cover;
            background-position: center;
            color: white;
        }
        .cat-box::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.4); /* Dark overlay */
            z-index: 1;
            transition: background-color 0.3s;
        }
        .cat-box:hover::before {
            background-color: rgba(0, 0, 0, 0.2); /* Lighter overlay on hover */
        }
        .cat-box h3 {
            position: relative;
            z-index: 2;
        }
    </style>
</head>
<body>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />

<main class="content-wrapper">
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
                            <button type="submit" class="add-to-cart-btn">Add to Cart</button>
                        </form>
                    </div>
                </div>
                <img src="images/HomePageKasutMerah.jpg.jpg" alt="Shoe 1" class="slide-bg">
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
                            <button type="submit" class="add-to-cart-btn">Add to Cart</button>
                        </form>
                    </div>
                </div>
                <img src="images/HomePageNikePutih.jpg" alt="Shoe 2" class="slide-bg">
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
                            <button type="submit" class="add-to-cart-btn">Add to Cart</button>
                        </form>
                    </div>
                </div>
                <img src="images/HomepageAirJordan.jpg" alt="Shoe 3" class="slide-bg">
            </div>
        </div>
    </section>

    <section class="category-split">
        <div class="cat-box" style="background-image: url('<%= request.getContextPath() %>/images/men.jpg');" onclick="location.href='men.jsp'"><h3>MEN</h3></div>
        <div class="cat-box" style="background-image: url('<%= request.getContextPath() %>/images/women.jpg');" onclick="location.href='women.jsp'"><h3>WOMEN</h3></div>
        <div class="cat-box" style="background-image: url('<%= request.getContextPath() %>/images/kids.jpg');" onclick="location.href='kids.jsp'"><h3>KIDS</h3></div>
    </section>
</main>

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />

<script>
    // Auto-scroll functionality
    const track = document.getElementById('heroTrack');
    let scrollInterval;

    function startCarousel() {
        scrollInterval = setInterval(() => {
            const currentScroll = track.scrollLeft;
            const slideWidth = track.clientWidth;
            const nextScroll = currentScroll + slideWidth;

            if (nextScroll >= track.scrollWidth) {
                track.scrollTo({ left: 0, behavior: 'smooth' });
            } else {
                track.scrollTo({ left: nextScroll, behavior: 'smooth' });
            }
        }, 5000); // Change image every 5 seconds
    }

    function stopCarousel() {
        clearInterval(scrollInterval);
    }

    track.addEventListener('mouseenter', stopCarousel);
    track.addEventListener('mouseleave', startCarousel);

    // Manual scroll buttons
    function scrollCarousel(direction) {
        stopCarousel(); // Stop auto-scroll on manual click
        const slideWidth = track.clientWidth;
        track.scrollBy({ left: direction * slideWidth, behavior: 'smooth' });
        startCarousel(); // Restart auto-scroll
    }

    startCarousel(); // Start the carousel on page load
</script>

</body>
</html>