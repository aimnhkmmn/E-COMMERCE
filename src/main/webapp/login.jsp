<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FootwearHub - Sign In</title>
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
            margin: 0;
        }

        .brand-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .brand-header h1 {
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 8px;
        }

        .brand-header p {
            color: #6c757d;
            font-size: 1.1rem;
        }

        .login-card {
            width: 100%;
            max-width: 450px;
            padding: 40px;
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            background-color: #fff;
        }

        .form-label {
            font-weight: 600;
            font-size: 0.9rem;
            margin-bottom: 8px;
        }

        .form-control {
            padding: 12px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            margin-bottom: 20px;
        }

        .form-control:focus {
            border-color: #000;
            box-shadow: none;
        }

        .forgot-link {
            display: block;
            text-align: right;
            font-size: 0.85rem;
            color: #6c757d;
            text-decoration: underline;
            margin-top: -15px;
            margin-bottom: 25px;
        }

        .btn-signin {
            background-color: #000;
            color: #fff;
            padding: 12px;
            font-weight: 600;
            border-radius: 8px;
            border: none;
            width: 100%;
            transition: opacity 0.2s;
        }

        .btn-signin:hover {
            opacity: 0.8;
            color: #fff;
        }

        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 30px 0;
            color: #adb5bd;
            font-size: 0.85rem;
        }

        .divider::before, .divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #e9ecef;
        }

        .divider:not(:empty)::before { margin-right: 15px; }
        .divider:not(:empty)::after { margin-left: 15px; }

        .signup-text {
            text-align: center;
            font-size: 0.9rem;
            color: #495057;
        }

        .signup-text a {
            color: #000;
            font-weight: 600;
            text-decoration: none;
        }

        .return-link {
            margin-top: 30px;
            font-size: 0.9rem;
            color: #495057;
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="brand-header">
    <h1>FootwearHub</h1>
    <p>Sign in to your account</p>
</div>

<div class="login-card">
    <form action="login" method="post">
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" id="email" name="email" class="form-control" placeholder="Enter your email" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
            <a href="forgot-password.jsp" class="forgot-link">Forgot password?</a>
        </div>

        <button type="submit" class="btn btn-signin">Sign In</button>
    </form>

    <div class="divider">OR</div>

    <div class="signup-text">
        New to FootwearHub? <a href="register.jsp">Sign up for an account</a>
    </div>
</div>

<a href="index.jsp" class="return-link">← Return to store</a>

</body>
</html>