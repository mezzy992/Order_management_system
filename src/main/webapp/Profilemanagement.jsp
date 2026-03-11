<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String portId = (String) session.getAttribute("port_id");
    if (portId == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>My Profile</title>
    <style>
        /* Animations */
        @keyframes fadeSlideUp {
            0% {
                opacity: 0;
                transform: translateY(20px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Body and layout */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #58126A 0%, #F6B2E1 75%, #ffffff 100%);
            min-height: 100vh;
            margin: 0;
            padding: 40px 20px;
            color: #58126A;

            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;

            animation: fadeSlideUp 1s ease forwards;
        }

        /* Form styling */
        form {
            background: #fff;
            padding: 35px 45px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(88, 18, 106, 0.3);
            width: 100%;
            max-width: 460px;
            color: #58126A;
            margin-bottom: 25px;

            animation: fadeSlideUp 1s ease forwards;
            animation-delay: 0.2s;
            opacity: 0;
            transform: translateY(20px);
            animation-fill-mode: forwards;
        }

        /* Heading */
        h2 {
            text-align: center;
            color: #58126A;
            margin-bottom: 35px;
            font-weight: 800;
            font-size: 2rem;
            text-shadow: 1px 1px 2px rgba(246, 178, 225, 0.6);
        }

        /* Table styles */
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 20px;
        }

        td:first-child {
            width: 38%;
            font-weight: 700;
            color: #58126A;
            padding-left: 8px;
            vertical-align: middle;
            font-size: 1rem;
        }

        /* Inputs */
        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px 16px;
            border-radius: 10px;
            border: 2px solid #F6B2E1;
            font-size: 1rem;
            font-weight: 500;
            color: #58126A;
            outline: none;
            transition: border-color 0.3s ease, box-shadow 0.3s ease, transform 0.2s ease;
            background-color: #fff;
            box-shadow: inset 0 0 5px #f6b2e1;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            border-color: #58126A;
            box-shadow: 0 0 10px #58126A;
            transform: scale(1.03);
        }

        input[readonly] {
            background-color: #f4e9fa;
            color: #7d5ba6;
            cursor: not-allowed;
            border-color: #d7c6e3;
            box-shadow: none;
            transform: none !important;
        }

        /* Buttons */
        button {
            cursor: pointer;
            padding: 12px 28px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 1rem;
            border: none;
            margin: 12px 10px 0 10px;
            transition: background-color 0.3s ease, color 0.3s ease, box-shadow 0.3s ease, transform 0.2s ease;
            box-shadow: 0 0 12px rgba(246, 178, 225, 0.7);
            color: #fff;
            user-select: none;
        }

        button[name="action"][value="update"] {
            background-color: #58126A;
        }

        button[name="action"][value="update"]:hover,
        button[name="action"][value="update"]:focus {
            background-color: #7d3fbf;
            box-shadow: 0 0 20px #7d3fbf;
            transform: scale(1.05);
        }

        button[name="action"][value="delete"] {
            background-color: #F6B2E1;
            color: #58126A;
            box-shadow: 0 0 12px #F6B2E1;
        }

        button[name="action"][value="delete"]:hover,
        button[name="action"][value="delete"]:focus {
            background-color: #e091d1;
            box-shadow: 0 0 20px #e091d1;
            color: #3f0e4f;
            transform: scale(1.05);
        }

        td[colspan="2"] {
            text-align: center;
        }

        /* Dashboard redirect button */
        .btn-dashboard {
            display: inline-block;
            background-color: #F6B2E1;
            color: #58126A;
            padding: 14px 38px;
            font-weight: 700;
            font-size: 1.1rem;
            border-radius: 15px;
            border: none;
            box-shadow: 0 0 15px #F6B2E1;
            text-align: center;
            text-decoration: none;
            transition: background-color 0.3s ease, box-shadow 0.3s ease, color 0.3s ease, transform 0.2s ease;
            width: max-content;
            cursor: pointer;

            animation: fadeSlideUp 1s ease forwards;
            animation-delay: 0.5s;
            opacity: 0;
            transform: translateY(20px);
            animation-fill-mode: forwards;
            user-select: none;
        }

        .btn-dashboard:hover,
        .btn-dashboard:focus {
            background-color: #e091d1;
            color: #3f0e4f;
            box-shadow: 0 0 25px #e091d1;
            transform: scale(1.05);
        }

        /* Error message */
        p.error-msg {
            color: #b33972;
            font-weight: 700;
            text-align: center;
            margin-top: 22px;
            text-shadow: 1px 1px 3px rgba(88, 18, 106, 0.3);
        }

        /* ✅ Success strip */
        .success-strip {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 700;
            box-shadow: 0 6px 15px rgba(0,0,0,0.2);
            animation: fadeSlideUp 0.6s ease;
        }

        @media (max-width: 480px) {
            form {
                padding: 25px 30px;
            }
            td:first-child {
                font-size: 0.95rem;
            }
            button[name="action"] {
                width: 100%;
                margin: 12px 0 0 0;
                padding: 14px 0;
            }
            td[colspan="2"] {
                display: flex;
                flex-direction: column;
                gap: 14px;
                align-items: center;
            }
            .btn-dashboard {
                width: 100%;
                margin-top: 0;
                padding: 16px 0;
            }
        }
    </style>
</head>
<body>

    <% if (request.getAttribute("success") != null) { %>
        <div class="success-strip">
            <%= request.getAttribute("success") %>
        </div>
    <% } %>

    <form method="post" action="ProfileServlet" novalidate>
        <h2>My Profile</h2>
        <table>
            <tr>
                <td>Port ID:</td>
                <td><input type="text" name="port_id" value="<%= request.getAttribute("port_id") %>" readonly></td>
            </tr>
            <tr>
                <td>Name:</td>
                <td><input type="text" name="name" value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>" required></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input type="email" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type="password" name="password" placeholder="Leave blank to keep current"></td>
            </tr>
            <tr>
                <td>Location:</td>
                <td><input type="text" name="location" value="<%= request.getAttribute("location") != null ? request.getAttribute("location") : "" %>"></td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit" name="action" value="update">Update</button>
                    <button type="submit" name="action" value="delete" onclick="return confirm('Are you sure you want to delete your profile?');">Delete</button>
                </td>
            </tr>
        </table>
    </form>

    <a href="Dashboard.jsp" class="btn-dashboard" role="button" tabindex="0">← Back to Dashboard</a>

    <% if ("length".equals(request.getParameter("error"))) { %>
        <p class="error-msg">Password must be at least 8 characters.</p>
    <% } %>
</body>
</html>