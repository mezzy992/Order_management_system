<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Seller Registration</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background: #000;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      color: #fff;
      animation: fadeIn 1s ease-in-out;
    }

    body::before {
      content: '';
      position: absolute;
      width: 200%;
      height: 200%;
      background: linear-gradient(45deg, #58126A, #F6B2E1, #6a11cb, #2575fc);
      background-size: 400% 400%;
      animation: gradientMove 15s ease infinite;
      z-index: -1;
    }
    @keyframes gradientMove {
      0% {background-position: 0% 50%;}
      50% {background-position: 100% 50%;}
      100% {background-position: 0% 50%;}
    }

    .form-container {
      background: rgba(255, 255, 255, 0.08);
      backdrop-filter: blur(15px);
      border: 1px solid rgba(255, 255, 255, 0.2);
      padding: 50px 40px;
      border-radius: 20px;
      box-shadow: 0 12px 35px rgba(0,0,0,0.7);
      width: 420px;
      text-align: center;
      position: relative;
      z-index: 1;
      animation: slideUp 0.9s ease-out;
    }

    .form-container h2 {
      font-size: 28px;
      font-weight: 700;
      margin-bottom: 30px;
      color: #fff !important;              /* solid white */
      -webkit-text-fill-color: #fff !important; /* ensures white in Safari/Chrome */
      background: none !important;         /* remove gradient */
      text-shadow: none !important;        /* remove blur */
    }

    .form-container input {
      width: 100%;
      padding: 14px 16px;
      margin: 12px 0;
      border-radius: 12px;
      border: none;
      outline: none;
      font-size: 15px;
      color: #333;
      background: rgba(255,255,255,0.9);
      transition: all 0.3s ease-in-out;
    }
    .form-container input:focus {
      box-shadow: 0 0 18px #F6B2E1;
      transform: scale(1.02);
    }

    .form-container button {
      width: 100%;
      padding: 14px;
      margin-top: 15px;
      background: linear-gradient(90deg, #58126A, #F6B2E1);
      color: #fff;
      border: none;
      border-radius: 12px;
      font-weight: 700;
      font-size: 16px;
      cursor: pointer;
      transition: all 0.3s;
      box-shadow: 0 6px 20px rgba(0,0,0,0.4);
    }
    .form-container button:hover {
      background: linear-gradient(90deg, #F6B2E1, #58126A);
      transform: translateY(-3px) scale(1.02);
      box-shadow: 0 12px 35px rgba(246,178,225,0.6);
    }

    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }
    @keyframes slideUp {
      from { transform: translateY(60px); opacity: 0; }
      to { transform: translateY(0); opacity: 1; }
    }

    /* Error styling */
    .error {
      color: #ff4d6d;
      font-size: 14px;
      margin-top: 5px;
      display: none; /* hidden until JS shows it */
    }
  </style>
</head>
<body>
  <div class="form-container">
    <h2>🛍️ Seller Registration</h2>
    <form action="RegisterServlet" method="post" onsubmit="return validateForm()">
      <input type="text" name="port_id" placeholder="Port ID" required />
      <input type="text" name="name" placeholder="Full Name" required />
      <input type="email" name="email" placeholder="Email" required />
      <input type="text" name="location" placeholder="Location" required />
      <input type="password" id="password" name="password" placeholder="Password (min 8 characters)" required />
      <div id="error-msg" class="error">⚠️ Password must be at least 8 characters</div>
      <br><br>
      <button type="submit">Register</button>
    </form>
  </div>

  <script>
    function validateForm() {
      let password = document.getElementById("password").value;
      let errorMsg = document.getElementById("error-msg");

      if (password.length < 8) {
        errorMsg.style.display = "block"; // show error
        return false; // prevent submission
      } else {
        errorMsg.style.display = "none"; // hide error
        return true; // allow submission
      }
    }
  </script>
</body>
</html>