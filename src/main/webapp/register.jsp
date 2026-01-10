<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FootwearHub - Sign Up</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #ffffff;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 40px 0;
            margin: 0;
        }

        .brand-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .brand-header h1 {
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 5px;
        }

        .brand-header p {
            color: #6c757d;
            font-size: 1rem;
        }

        .register-card {
            width: 100%;
            max-width: 480px;
            padding: 40px;
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            background-color: #fff;
        }

        .form-label {
            font-weight: 600;
            font-size: 0.85rem;
            margin-bottom: 6px;
        }

        .form-control {
            padding: 10px 14px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 0.95rem;
            margin-bottom: 18px;
        }

        .form-control:focus {
            border-color: #000;
            box-shadow: none;
        }

        textarea.form-control {
            min-height: 80px;
        }

        .btn-signup {
            background-color: #000;
            color: #fff;
            padding: 12px;
            font-weight: 600;
            border-radius: 8px;
            border: none;
            width: 100%;
            margin-top: 10px;
            transition: opacity 0.2s;
        }

        .btn-signup:hover {
            opacity: 0.8;
            color: #fff;
        }

        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 25px 0;
            color: #adb5bd;
            font-size: 0.8rem;
        }

        .divider::before, .divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #e9ecef;
        }

        .divider:not(:empty)::before { margin-right: 15px; }
        .divider:not(:empty)::after { margin-left: 15px; }

        .signin-text {
            text-align: center;
            font-size: 0.85rem;
            color: #495057;
        }

        .signin-text a {
            color: #000;
            font-weight: 600;
            text-decoration: none;
        }

        .return-link {
            margin-top: 25px;
            font-size: 0.85rem;
            color: #495057;
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="brand-header">
    <h1>FootwearHub</h1>
    <p>Create your account</p>
</div>

<div class="register-card">
    <form action="register" method="post">
        <div class="mb-1">
            <label for="fullName" class="form-label">Full Name</label>
            <input type="text" id="fullName" name="fullName" class="form-control" placeholder="Enter your full name" required>
        </div>

        <div class="mb-1">
            <label for="phone" class="form-label">Phone Number</label>
            <input type="tel" id="phone" name="phone" class="form-control" placeholder="Enter your phone number" required>
        </div>

        <div class="mb-1">
            <label for="email" class="form-label">Email</label>
            <input type="email" id="email" name="email" class="form-control" placeholder="Enter your email" required>
        </div>

        <div class="mb-1">
            <label for="password" class="form-label">Password</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="Create a password" required>
        </div>

        <div class="mb-1">
            <label for="confirmPassword" class="form-label">Confirm Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm your password" required>
        </div>

        <div class="mb-1">
            <label for="address" class="form-label">Address</label>
            <textarea id="address" name="address" class="form-control" placeholder="Enter your address" required></textarea>
        </div>

        <button type="submit" class="btn btn-signup">Sign Up</button>
    </form>

    <div class="divider">OR</div>

    <div class="signin-text">
        Already have an account? <a href="login.jsp">Sign in</a>
    </div>
</div>

<a href="index.jsp" class="return-link">← Return to store</a>

</body>
</html>