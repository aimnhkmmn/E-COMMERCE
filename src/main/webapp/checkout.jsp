<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ecommerce.Product" %>
<%@ page import="com.ecommerce.Cart" %>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout.css">

<%
    Object cartObj = session.getAttribute("cart");
    Cart cart = (cartObj instanceof Cart) ? (Cart) cartObj : new Cart();

    double subtotal = cart.getTotal();
    double shipping = (subtotal > 0) ? 15.00 : 0;
    double total = subtotal + shipping;
%>

<body class="checkout-page-body">

<div class="checkout-backdrop">
    <div class="checkout-container">
        <div class="checkout-main">
            <h1>Checkout</h1>

            <form action="place-order.jsp" method="POST">
                <div class="form-section">
                    <h2>Shipping Address</h2>
                    <div class="form-row">
                        <label for="firstName">First Name</label>
                        <input type="text" id="firstName" name="firstName" placeholder="First Name" required>
                        <label for="lastName">Last Name</label>
                        <input type="text" id="lastName" name="lastName" placeholder="Last Name" required>
                    </div>
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" placeholder="Address" required>
                    <label for="city">City</label>
                    <input type="text" id="city" name="city" placeholder="City" required>
                    <div class="form-row">
                        <label for="state">State / Province</label>
                        <input type="text" id="state" name="state" placeholder="State / Province" required>
                        <label for="zip">Zip / Postal Code</label>
                        <input type="text" id="zip" name="zip" placeholder="Zip / Postal Code" required>
                    </div>
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="Email Address" required>
                </div>

                <div class="form-section">
                    <h2>Payment Method</h2>
                    <div class="payment-options">
                        <label class="payment-option">
                            <input type="radio" name="paymentMethod" value="creditCard" checked onchange="togglePaymentDetails()">
                            <span>Credit Card</span>
                        </label>
                        <label class="payment-option">
                            <input type="radio" name="paymentMethod" value="paypal" onchange="togglePaymentDetails()">
                            <span>PayPal</span>
                        </label>
                        <label class="payment-option">
                            <input type="radio" name="paymentMethod" value="googlePay" onchange="togglePaymentDetails()">
                            <span>Google Pay</span>
                        </label>
                    </div>
                </div>

                <div id="creditCardDetails" class="form-section">
                    <h2>Payment Details</h2>
                    <label for="cardNumber">Card Number</label>
                    <input type="text" id="cardNumber" name="cardNumber" placeholder="Card Number">
                    <div class="form-row">
                        <label for="expiry">MM / YY</label>
                        <input type="text" id="expiry" name="expiry" placeholder="MM / YY">
                        <label for="cvv">CVV</label>
                        <input type="text" id="cvv" name="cvv" placeholder="CVV">
                    </div>
                </div>

                <button type="submit" class="btn-place-order">Place Order</button>
            </form>
        </div>

        <aside class="checkout-summary">
            <h2>Order Summary</h2>
            <% if (cart.getItemCount() == 0) { %>
                <p>Your cart is empty.</p>
            <% } else { %>
                <div class="summary-items">
                    <% for (Product item : cart.getItems()) { %>
                        <div class="summary-item">
                            <img src="${pageContext.request.contextPath}/<%= item.getImage() %>" alt="<%= item.getName() %>" class="item-image">
                            <div class="item-details">
                                <span class="item-name"><%= item.getName() %></span>
                                <span class="item-price">$<%= String.format("%.2f", item.getPrice()) %></span>
                            </div>
                        </div>
                    <% } %>
                </div>
                <div class="summary-total">
                    <div class="total-row">
                        <span>Subtotal</span>
                        <span>$<%= String.format("%.2f", subtotal) %></span>
                    </div>
                    <div class="total-row">
                        <span>Shipping</span>
                        <span>$<%= String.format("%.2f", shipping) %></span>
                    </div>
                    <div class="total-row final-total">
                        <span>Total</span>
                        <span>$<%= String.format("%.2f", total) %></span>
                    </div>
                </div>
            <% } %>
        </aside>
    </div>
</div>

<script>
    function togglePaymentDetails() {
        const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
        const creditCardDetails = document.getElementById('creditCardDetails');
        if (paymentMethod === 'creditCard') {
            creditCardDetails.style.display = 'block';
        } else {
            creditCardDetails.style.display = 'none';
        }
    }
</script>

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />
</body>