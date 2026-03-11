<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product_pojo" %>
<%
    List<Product_pojo> products = (List<Product_pojo>) request.getAttribute("products");
    Product_pojo editProduct = (Product_pojo) request.getAttribute("editProduct");
    String message = (String) session.getAttribute("message");
    if (message != null) {
        session.removeAttribute("message"); // clear after showing
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f9f9fb;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 40px 20px;
            min-height: 100vh;
        }

        /* Headings */
        h2, h3 {
            color: #58126A;
            text-align: center;
            margin-bottom: 40px;
            font-weight: 800;
            letter-spacing: 1px;
        }

        /* Form container */
        #productForm {
            background: #fff;
            max-width: 650px;
            margin: 0 auto 50px auto;
            padding: 35px 40px;
            border-radius: 20px;
            box-shadow: 0 6px 18px rgba(88, 18, 106, 0.15);
            transition: all 0.3s ease;
        }

        #productForm:hover {
            box-shadow: 0 10px 28px rgba(88, 18, 106, 0.25);
        }

        label.form-label {
            font-weight: 600;
            margin-bottom: 6px;
            color: #58126A;
        }

        #productForm input[type="text"],
        #productForm input[type="number"] {
            width: 100%;
            padding: 12px 14px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 12px;
            background-color: #ffffff;
            font-size: 1rem;
            color: #333;
            transition: border-color 0.3s ease, box-shadow 0.2s ease;
        }

        #productForm input[type="text"]:focus,
        #productForm input[type="number"]:focus {
            border-color: #F6B2E1;
            box-shadow: 0 0 6px rgba(246, 178, 225, 0.6);
            outline: none;
        }

        #productForm button {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 12px;
            background: linear-gradient(135deg, #58126A, #F6B2E1);
            color: #ffffff;
            font-weight: bold;
            font-size: 1.1rem;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        #productForm button:hover {
            background: linear-gradient(135deg, #F6B2E1, #58126A);
            transform: translateY(-2px) scale(1.01);
            box-shadow: 0 6px 15px rgba(246, 178, 225, 0.45);
        }

        .table-card {
            max-width: 1000px;
            margin: 40px auto;
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(88, 18, 106, 0.15);
            overflow: hidden;
            padding: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: linear-gradient(135deg, #58126A, #F6B2E1);
            color: white;
            padding: 14px;
            text-align: left;
            font-weight: 700;
            font-size: 1rem;
        }

        tbody tr {
            background: #fafafa;
            transition: background 0.3s ease;
        }

        tbody tr:nth-child(even) {
            background: #fdf3fa;
        }

        tbody tr:hover {
            background: #f6e6f5;
        }

        td {
            padding: 14px;
            color: #444;
            border-bottom: 1px solid #eee;
            font-size: 0.95rem;
        }

        table td a {
            margin-right: 12px;
            color: #58126A;
            font-weight: 600;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        table td a:hover {
            color: #F6B2E1;
            text-decoration: underline;
        }

        table td form button {
            background: #ff4d4d;
            border: none;
            padding: 8px 14px;
            color: white;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        table td form button:hover {
            background: #e04141;
            transform: scale(1.05);
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
    </style>
</head>
<body>

    <h2>My Products</h2>

    <% if (message != null) { %>
        <div class="alert alert-success text-center" role="alert" 
             style="max-width: 600px; margin: 20px auto; border-radius: 10px; font-weight: 600;">
            <%= message %>
        </div>
    <% } %>

    <a href="Dashboard.jsp" class="back-link">&#8592; Back to Dashboard</a>

    <!-- Product Form -->
    <form id="productForm" action="ProductServlet" method="post">
        <input type="hidden" name="product_id" value="<%= (editProduct != null) ? editProduct.getProductId() : "" %>"/>
        <input type="hidden" name="action" value="<%= (editProduct != null) ? "update" : "add" %>"/>

        <label for="productname" class="form-label">Product Name</label>
        <input id="productname" type="text" name="productname" value="<%= (editProduct != null) ? editProduct.getProductName() : "" %>" required/>

        <label for="description" class="form-label">Description</label>
        <input id="description" type="text" name="description" value="<%= (editProduct != null) ? editProduct.getDescription() : "" %>"/>

        <label for="quantity" class="form-label">Quantity</label>
        <input id="quantity" type="number" name="quantity" value="<%= (editProduct != null) ? editProduct.getQuantity() : "" %>"/>

        <label for="price" class="form-label">Price</label>
        <input id="price" type="number" name="price" value="<%= (editProduct != null) ? editProduct.getPrice() : "" %>"/>

        <button type="submit"><%= (editProduct != null) ? "Update Product" : "Add Product" %></button>
    </form>

    <!-- Product List Table -->
    <h3>Product List</h3>
    <div class="table-card">
        <table>
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Description</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th style="width: 160px;">Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                if (products != null) {
                    for (Product_pojo p : products) {
            %>
                <tr>
                    <td><%= p.getProductName() %></td>
                    <td><%= p.getDescription() %></td>
                    <td><%= p.getQuantity() %></td>
                    <td>&#8377;<%= p.getPrice() %></td>
                    <td>
                        <a href="ProductServlet?editId=<%= p.getProductId() %>">Edit</a>
                        <form action="ProductServlet" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="product_id" value="<%= p.getProductId() %>"/>
                            <button type="submit">Delete</button>
                        </form>
                    </td>
                </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>

</body>
</html>