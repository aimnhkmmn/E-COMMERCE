<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />

<section class="hero-carousel">

    <button class="carousel-btn prev-btn" onclick="scrollCarousel(-1)">&#10094;</button>
    <button class="carousel-btn next-btn" onclick="scrollCarousel(1)">&#10095;</button>

    <div class="carousel-track" id="heroTrack">

        <div class="carousel-slide">
            <div class="slide-content">
                <span>New Arrival</span>
                <h1>AIR MAX PULSE</h1>
                <p>Extreme comfort. Infinite style.</p>
                <button>Shop Now</button>
            </div>
            <img src="images/shoe1.jpg" alt="Shoe 1" class="slide-bg">
        </div>

        <div class="carousel-slide">
            <div class="slide-content">
                <span>Trending</span>
                <h1>SPEED DEMON</h1>
                <p>Built for speed. Designed for you.</p>
                <button>See Details</button>
            </div>
            <img src="images/shoe2.jpg" alt="Shoe 2" class="slide-bg">
        </div>

        <div class="carousel-slide">
            <div class="slide-content">
                <span>Just Dropped</span>
                <h1>JORDAN RETRO</h1>
                <p>The legend returns.</p>
                <button>Buy Now</button>
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