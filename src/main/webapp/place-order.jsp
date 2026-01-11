<%@ page contentType="text/html; charset=UTF-8" %>

<jsp:include page="HomePageHTML/HomePageHeader.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<div style="text-align: center; padding: 80px 20px;">
    <h1>Thank You For Your Order!</h1>
    <p>Your order has been placed successfully.</p>
    <p>A confirmation email has been sent to your address.</p>
    <br>
    <a href="index.jsp" class="btn-login" style="padding: 15px 30px;">Continue Shopping</a>
</div>

<%
    // session cleanup
    // since order is complete, we must empty the cart
    // removeAttribute deletes the "cart" object from the user's session
    session.removeAttribute("cart");
%>

<jsp:include page="HomePageHTML/HomePageFooter.jsp" />