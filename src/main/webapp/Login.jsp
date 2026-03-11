<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Seller Login</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
  
  <style>
    /* Background with gradient like dashboard */
    body {
      background: linear-gradient(135deg, #58126A, #F6B2E1);
      height: 100vh;
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      overflow: hidden;
      animation: fadeInDown 1s ease forwards;
    }

    /* Glassmorphic login card */
    .login-card {
      background: rgba(255, 255, 255, 0.15);
      backdrop-filter: blur(12px);
      border-radius: 20px;
      box-shadow: 0 8px 25px rgba(246, 178, 225, 0.6);
      padding: 40px 35px;
      width: 100%;
      max-width: 400px;
      color: #fff;
      animation: fadeUp 0.7s ease forwards;
      border: 1px solid rgba(246, 178, 225, 0.3);
      transition: transform 0.3s ease;
    }
    .login-card:hover {
      transform: scale(1.03);
      box-shadow: 0 12px 35px rgba(246, 178, 225, 0.8);
    }

    /* Title styling */
    .login-title {
      font-weight: 700;
      font-size: 1.8rem;
      text-align: center;
      margin-bottom: 25px;
      text-shadow: 0 2px 8px rgba(0,0,0,0.4);
    }

    /* Inputs */
    .form-control {
      background: rgba(255, 255, 255, 0.8);
      border: none;
      border-radius: 12px;
      color: #222;
      font-weight: 500;
      transition: box-shadow 0.3s ease, transform 0.2s ease;
      box-shadow: inset 0 0 5px rgba(0,0,0,0.1);
    }
    .form-control:focus {
      outline: none;
      box-shadow: 0 0 15px #F6B2E1;
      transform: scale(1.03);
      background: rgba(255,255,255,0.95);
    }

    /* Buttons matching dashboard pink/purple */
    .btn-login {
      background: #F6B2E1;
      color: #58126A;
      font-weight: 700;
      border-radius: 12px;
      border: none;
      transition: background 0.3s ease, transform 0.2s ease;
      box-shadow: 0 4px 10px rgba(246, 178, 225, 0.5);
    }
    .btn-login:hover {
      background: #58126A;
      color: #F6B2E1;
      transform: scale(1.05);
      box-shadow: 0 6px 15px rgba(88, 18, 106, 0.8);
    }

    /* Success and error messages */
    .text-success, .text-danger {
      font-weight: 600;
      text-shadow: 0 0 5px rgba(0,0,0,0.3);
    }

    /* Register link styling */
    p.text-center a {
      color: #F6B2E1;
      font-weight: 600;
      text-decoration: none;
      transition: color 0.3s ease;
    }
    p.text-center a:hover {
      color: #fff;
      text-decoration: underline;
    }

    /* Animations */
    @keyframes fadeInDown {
      from {opacity: 0; transform: translateY(-30px);}
      to {opacity: 1; transform: translateY(0);}
    }
    @keyframes fadeUp {
      from {opacity: 0; transform: translateY(30px);}
      to {opacity: 1; transform: translateY(0);}
    }
  </style>
</head>
<body>
  <div class="login-card">
    <h3 class="login-title">Seller Login</h3>

    <!-- Success message -->
    <p class="text-success text-center">
      <%
        String success = request.getParameter("success");
        if ("registered".equals(success)) {
          out.print("Registration successful! Please login.");
        }
      %>
    </p>

    <!-- Error messages -->
    <p class="text-danger text-center">
      <%
        String error = request.getParameter("error");
        if ("invalid".equals(error)) {
          out.print("Invalid Port ID or Password!");
        } else if ("length".equals(error)) {
          out.print("Password must be at least 8 characters long!");
        }
      %>
    </p>

    <form action="LoginServlet" method="post">
      <div class="mb-3">
        <label class="form-label">Port ID</label>
        <input type="text" name="port_id" class="form-control" placeholder="Enter your Port ID" required autofocus />
      </div>
      <div class="mb-3">
        <label class="form-label">Password</label>
        <input type="password" name="password" class="form-control" placeholder="Password" required />
      </div>

      <button type="submit" class="btn btn-login w-100">Login</button>

      <p class="text-center mt-3">
        Don’t have an account? <a href="Register.jsp">Register</a>
      </p>
    </form>
  </div>
</body>
</html>
