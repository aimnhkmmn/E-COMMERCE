<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FootWearHub</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

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
            <form action="search-results.jsp" method="get" style="display: flex; align-items: center;">

                <input type="text" name="q" placeholder="Search shoes..."
                       style="padding: 8px 15px; border: 1px solid #ccc; border-radius: 20px; outline: none; width: 200px;">

                <button type="submit" style="display: none;">Search</button>
            </form>
            <a href="#" class="nav-item">Cart (0)</a>
            <a href="login.jsp" class="btn-login">Login</a>
        </div>

    </div>
</nav>