<%@ page import="com.ecommerce.Cart" %>
<%
    int cartCount = 0;
    Object cartObj = session.getAttribute("cart");
    if (cartObj instanceof Cart) {
        cartCount = ((Cart) cartObj).getItemCount();
    }
%>

<nav class="navbar">
    <div class="nav-container">

        <div class="nav-left">
            <a href="index.jsp" class="logo">FootWearHub</a>

            <ul class="nav-links">
                <li><a href="new-featured.jsp">New & Featured</a></li>
                <li><a href="men.jsp">Men</a></li>
                <li><a href="women.jsp">Women</a></li>
                <li><a href="kids.jsp">Kids</a></li>
            </ul>
        </div>

        <div class="nav-actions">
            <form action="#" method="get" style="display: flex; align-items: center;">
                <label>
                    <input type="text" name="q" placeholder="Search shoes..."
                           style="padding: 8px 15px; border: 1px solid #ccc; border-radius: 20px; outline: none; width: 200px;">
                </label>
                <button type="submit" style="display: none;">Search</button>
            </form>

            <a href="addToCart.jsp" class="nav-item">Cart (<%= cartCount %>)</a>

            <a href="login.jsp" class="btn-login">Log in</a>
        </div>

    </div>
</nav>