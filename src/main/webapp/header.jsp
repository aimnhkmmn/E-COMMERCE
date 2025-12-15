<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shoes E-commerce Project</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

<nav class="navbar">
    <a href="index.jsp" class="logo">MIUU JOKI</a>

    <ul class="nav-links">
        <li><a href="index.jsp">Home</a></li>
        <li><a href="products.jsp">Products</a></li>
        <li><a href="cart.jsp">My Cart</a></li>

        <%
            if (session.getAttribute("user") != null) {
        %>
        <li><a href="profile.jsp">My Profile</a></li>
        <li><a href="LogoutServlet" class="btn-nav">Logout</a></li>
        <% } else { %>
        <li><a href="login.jsp" class="btn-nav">Login</a></li>
        <% } %>
    </ul>
</nav>

<div style="padding: 20px;">