<%@ page import="java.util.List" %>
<%@ page import="model.OrderPojo" %>
<%
    List<OrderPojo> orders = (List<OrderPojo>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #58126A, #F6B2E1);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
            padding: 40px 20px;
            color: #2c3e50;
        }

        h1 {
            color: white;
            text-align: center;
            margin-bottom: 30px;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
        }

        .back-link {
            display: block;
            margin: 0 auto 40px auto;
            background: linear-gradient(135deg, #58126A, #F6B2E1);
            color: white;
            border: none;
            padding: 12px 26px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            width: 240px;
        }

        .back-link:hover {
            background: linear-gradient(135deg, #3d0d4a, #d98cbf);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.3);
        }

        .success-message {
            max-width: 600px;
            margin: 0 auto 25px auto;
            padding: 12px;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
            text-align: center;
            border-radius: 8px;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .error-message {
            max-width: 600px;
            margin: 0 auto 25px auto;
            padding: 12px;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
            text-align: center;
            border-radius: 8px;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        table {
            width: 90%;
            margin: 0 auto 60px auto;
            border-collapse: separate;
            border-spacing: 0;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
            animation: fadeIn 0.8s ease-in-out;
        }

        th, td {
            padding: 14px 18px;
            text-align: center;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }

        th {
            background-color: #58126A;
            color: white;
            font-weight: 600;
            user-select: none;
        }

        tr:hover {
            background-color: #F6B2E1;
        }

        select {
            padding: 6px 10px;
            border-radius: 8px;
            border: 1.5px solid #ccc;
            transition: border-color 0.3s ease;
        }

        select:focus {
            border-color: #58126A;
            outline: none;
            box-shadow: 0 0 8px rgba(88, 18, 106, 0.4);
        }

        input[type="submit"] {
            background: #58126A;
            color: white;
            border: none;
            padding: 8px 16px;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        input[type="submit"]:hover {
            background: #3d0d4a;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }
            thead tr {
                display: none;
            }
            tr {
                margin-bottom: 15px;
                background: white;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                border-radius: 12px;
                padding: 20px;
            }
            td {
                text-align: right;
                padding-left: 50%;
                position: relative;
                border-bottom: none;
            }
            td::before {
                content: attr(data-label);
                position: absolute;
                left: 20px;
                width: 45%;
                padding-left: 10px;
                font-weight: 600;
                text-align: left;
                color: #58126A;
            }
            td:last-child {
                text-align: center;
                padding-left: 0;
            }
        }

        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(15px);}
            to {opacity: 1; transform: translateY(0);}
        }
    </style>
</head>
<body>
    <h1>Your Orders</h1>

    <a href="Dashboard.jsp" class="back-link">&#8592; Back to Dashboard</a>

    <!-- ✅ Success/Error Strip -->
    <%
        String updateSuccess = request.getParameter("updateSuccess");
        if ("true".equals(updateSuccess)) {
    %>
        <div class="success-message">✅ Order updated successfully!</div>
    <%
        } else if ("false".equals(updateSuccess)) {
    %>
        <div class="error-message">❌ Failed to update order. Try again.</div>
    <%
        }
    %>

    <table>
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Buyer ID</th>
                <th>Order Date</th>
                <th>Total Amount</th>
                <th>Delivery Address</th>
                <th>Status</th>
                <th>Update</th>
            </tr>
        </thead>
        <tbody>
        <%
            if (orders != null && !orders.isEmpty()) {
                for (OrderPojo o : orders) {
        %>
            <tr>
                <td data-label="Order ID"><%= o.getOrder_id() %></td>
                <td data-label="Buyer ID"><%= o.getBuyer_id() %></td>
                <td data-label="Order Date"><%= o.getOrder_date() %></td>
                <td data-label="Total Amount">&#8377;<%= o.getTotal_amount() %></td>
                <td data-label="Delivery Address"><%= o.getDelivery_address() %></td>
                <td data-label="Status"><%= o.getStatus() %></td>
                <td data-label="Update">
                    <form action="OrderServlet" method="post" style="margin: 0;">
                        <input type="hidden" name="order_id" value="<%= o.getOrder_id() %>">
                        <select name="status">
                            <option value="Pending" <%= "Pending".equals(o.getStatus())?"selected":"" %>>Pending</option>
                            <option value="Shipped" <%= "Shipped".equals(o.getStatus())?"selected":"" %>>Shipped</option>
                            <option value="Delivered" <%= "Delivered".equals(o.getStatus())?"selected":"" %>>Delivered</option>
                            <option value="Cancelled" <%= "Cancelled".equals(o.getStatus())?"selected":"" %>>Cancelled</option>
                        </select>
                        <input type="submit" value="Update">
                    </form>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="7" style="padding: 20px;">No orders found.</td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</body>
</html>