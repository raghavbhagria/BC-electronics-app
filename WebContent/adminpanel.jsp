<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            margin: 0;
            padding: 20px;
        }

        h1 {
            background-color: #232f3e;
            color: #ffffff;
            padding: 20px;
            margin: 0;
            text-align: center;
        }

        ul {
            list-style-type: none;
            padding: 0;
            text-align: center;
        }

        li {
            margin: 10px 0;
        }

        a {
            text-decoration: none;
            background-color: #232f3e;
            color: #ffffff;
            padding: 10px;
            border-radius: 5px;
            transition: background-color 0.3s;
            display: inline-block;
        }

        a:hover {
            background-color: #1a2634;
        }
    </style>
</head>

<body>
    <h1>Welcome, Admin!</h1>

    <ul>
        <li><a href="listorder.jsp">View Orders</a></li>
        <li><a href="admin.jsp">View Sales</a></li>
        <li><a href="listprod.jsp">View Store</a></li>
        <li><a href="addProduct.jsp">Add Product</a></li>
        <li><a href="updateProduct.jsp">Update Product</a></li>
        <li><a href="deleteProduct.jsp">Delete Product</a></li>
        <li><a href="listcustomers.jsp">List Customers</a></li>
        <li><a href="logout.jsp">Logout</a></li>
    </ul>
</body>

</html>
