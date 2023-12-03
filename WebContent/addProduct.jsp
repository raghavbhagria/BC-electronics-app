<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.sql.*" %>

<%
    if (request.getMethod().equals("POST")) {
        // Process form submission
        String productName = request.getParameter("productName");
        double price = Double.parseDouble(request.getParameter("price"));

        try {
            getConnection();
            String sql = "INSERT INTO Product (productName, price) VALUES (?, ?)";
            try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                pstmt.setString(1, productName);
                pstmt.setDouble(2, price);
                pstmt.executeUpdate();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection();
        }

        // Redirect to adminPanel.jsp after successful submission
        response.sendRedirect("adminPanel.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Add Product</title>
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

        form {
            max-width: 400px;
            margin: 20px auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 8px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 16px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: #ffffff;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>

<body>
    <h1>Add Product</h1>

    <form method="post" action="addProduct.jsp">
        <label for="productName">Product Name:</label>
        <input type="text" name="productName" required>
        <br>
        <label for="price">Price:</label>
        <input type="text" name="price" required>
        <br>
        <input type="submit" value="Add Product">
    </form>
    
    <!-- Add additional content or navigation links as needed -->
</body>

</html>
