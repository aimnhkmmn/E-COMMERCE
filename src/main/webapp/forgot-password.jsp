<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FootwearHub - Reset Password</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
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
            color: #1a1a1a;
        }

        .brand-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .brand-header h1 {
            font-weight: 700;
            font-size: 2.8rem;
            margin-bottom: 5px;
        }

        .brand-header p {
            color: #6c757d;
            font-size: 1.2rem;
        }

        .login-card {
            width: 100%;
            max-width: 480px;
            padding: 45px;
            border: 1.5px solid #000; /* Matching the sharp border in image */
            border-radius: 12px;
            background-color: #fff;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }

        .instruction-text {
            font-size: 1rem;
            color: #4b5563;
            line-height: 1.5;
            margin-bottom: 30px;
        }

        .form-label {
            font-weight: 700;
            font-size: 0.95rem;
            display: block;
            margin-bottom: 10px;
        }

        .form-control {
            padding: 14px 18px;
            border: 2px solid #000; /* Thick black border from image */
            border-radius: 10px;
            font-size: 1rem;
            margin-bottom: 30px;
            width: 100%;
        }

        .form-control::placeholder {
            color: #adb5bd;
        }

        .btn-reset {
            background-color: #000;
            color: #fff;
            padding: 14px;
            font-weight: 600;
            font-size: 1.1rem;
            border-radius: 10px;
            border: none;
            width: 100%;
            cursor: pointer;
            margin-bottom: 25px;
        }

        .divider {
            border-top: 1px solid #dee2e6;
            margin: 25px 0;
        }

        .back-to-signin {
            text-align: center;
            font-size: 0.95rem;
            color: #4b5563;
        }

        .back-to-signin a {
            color: #000;
            font-weight: 700;
            text-decoration: none;
        }

        .return-store-link {
            margin-top: 40px;
            font-size: 1rem;
            color: #4b5563;
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="brand-header">
    <h1>FootwearHub</h1>
    <p>Reset your password</p>
</div>

<div class="login-card">
    <p class="instruction-text">
        Enter your email address and we'll send you a link to reset your password.
    </p>

    <form action="forgotPassword" method="post">
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" id="email" name="email" class="form-control" placeholder="Enter your email" required>
        </div>

        <button type="submit" class="btn-reset">Send Reset Link</button>
    </form>

    <div class="divider"></div>

    <div class="back-to-signin">
        Remember your password? <a href="login.jsp">Back to sign in</a>
    </div>
</div>

<a href="index.jsp" class="return-store-link">← Return to store</a>

</body>
</html>