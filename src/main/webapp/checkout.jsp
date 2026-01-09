<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ecommerce.Product" %>
<%@ page import="com.ecommerce.Cart" %>

<%
    Object cartObj = session.getAttribute("cart");
    Cart cart = (cartObj instanceof Cart) ? (Cart) cartObj : new Cart();
    double subtotal = cart.getTotal();
    double shipping = (subtotal > 0) ? 15.00 : 0;
    double total = subtotal + shipping;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FootWearHub - Checkout</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/checkout.css">
</head>
<body class="checkout-page-body">

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />

<main class="content-wrapper">
    <div class="checkout-backdrop">
        <div class="checkout-container">
            <div class="checkout-main">
                <h1>Checkout</h1>
                <form action="place-order.jsp" method="POST">
                    <div class="form-section">
                        <h2>Shipping Address</h2>
                        <div class="form-row">
                            <div>
                                <label for="firstName">First Name</label>
                                <input type="text" id="firstName" name="firstName" required>
                            </div>
                            <div>
                                <label for="lastName">Last Name</label>
                                <input type="text" id="lastName" name="lastName" required>
                            </div>
                        </div>
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" required>
                        <div class="form-row">
                            <div>
                                <label for="city">City</label>
                                <input type="text" id="city" name="city" required>
                            </div>
                            <div>
                                <label for="state">State / Province</label>
                                <input type="text" id="state" name="state" required>
                            </div>
                            <div>
                                <label for="zip">Zip / Postal Code</label>
                                <input type="text" id="zip" name="zip" required>
                            </div>
                        </div>
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" required>
                    </div>

                    <div class="form-section">
                        <h2>Payment Method</h2>
                        <div class="payment-options">
                            <label class="payment-option"><input type="radio" name="paymentMethod" value="creditCard" checked onchange="togglePaymentDetails()"><span>Credit Card</span></label>
                            <label class="payment-option"><input type="radio" name="paymentMethod" value="paypal" onchange="togglePaymentDetails()"><span>PayPal</span></label>
                            <label class="payment-option"><input type="radio" name="paymentMethod" value="googlePay" onchange="togglePaymentDetails()"><span>Google Pay</span></label>
                        </div>
                    </div>

                    <div id="creditCardDetails" class="form-section">
                        <h2>Payment Details</h2>
                        <label for="cardNumber">Card Number</label>
                        <input type="text" id="cardNumber" name="cardNumber">
                        <div class="form-row">
                            <div>
                                <label for="expiry">MM / YY</label>
                                <input type="text" id="expiry" name="expiry">
                            </div>
                            <div>
                                <label for="cvv">CVV</label>
                                <input type="text" id="cvv" name="cvv">
                            </div>
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
                                <img src="<%= request.getContextPath() %>/<%= item.getImage() %>" alt="<%= item.getName() %>" class="item-image">
                                <div class="item-details">
                                    <span class="item-name"><%= item.getName() %></span>
                                    <span class="item-price">$<%= String.format("%.2f", item.getPrice()) %></span>
                                </div>
                            </div>
                        <% } %>
                    </div>
                    <div class="summary-total">
                        <div class="total-row"><span>Subtotal</span><span>$<%= String.format("%.2f", subtotal) %></span></div>
                        <div class="total-row"><span>Shipping</span><span>$<%= String.format("%.2f", shipping) %></span></div>
                        <div class="total-row final-total"><span>Total</span><span>$<%= String.format("%.2f", total) %></span></div>
                    </div>
                <% } %>
            </aside>
        </div>
    </div>
</main>

<script>
    function togglePaymentDetails() {
        const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
        const creditCardDetails = document.getElementById('creditCardDetails');
        creditCardDetails.style.display = (paymentMethod === 'creditCard') ? 'block' : 'none';
    }
    togglePaymentDetails(); // Run on page load
</script>

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />

</body>
</html>