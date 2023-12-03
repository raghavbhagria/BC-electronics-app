<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.sql.*" %>

<%
    // Process form submission for deleting a product
    if (request.getMethod().equals("POST")) {
        // Retrieve selected product ID
        int productIdToDelete = Integer.parseInt(request.getParameter("productIdToDelete"));

        try {
            getConnection();
            String deleteQuery = "DELETE FROM Product WHERE productId = ?";
            try (PreparedStatement pstmt = con.prepareStatement(deleteQuery)) {
                pstmt.setInt(1, productIdToDelete);
                int rowsDeleted = pstmt.executeUpdate();

                // Check if the deletion was successful
                if (rowsDeleted > 0) {
                    out.println("Product deleted successfully!");

                    // Redirect to adminPanel.jsp after successful deletion
                    response.sendRedirect("adminPanel.jsp");
                    return; // Stop further processing to prevent displaying the form again
                } else {
                    out.println("Failed to delete product.");
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Delete Product</title>
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

        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 16px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #e74c3c;
            color: #ffffff;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #c0392b;
        }
    </style>
</head>

<body>
    <h1>Delete Product</h1>

    <form method="post" action="deleteProduct.jsp">
        <label for="productIdToDelete">Select Product to Delete:</label>
        <select name="productIdToDelete" required>
            <%-- Retrieve product data for dropdown list --%>
            <%
                try {
                    getConnection();
                    String selectQuery = "SELECT productId, productName FROM Product";
                    try (PreparedStatement pstmt = con.prepareStatement(selectQuery);
                         ResultSet rs = pstmt.executeQuery()) {
                        while (rs.next()) {
                            int productId = rs.getInt("productId");
                            String productName = rs.getString("productName");
            %>
            <option value="<%= productId %>"><%= productName %></option>
            <%
                        }
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                } finally {
                    closeConnection();
                }
            %>
        </select>
        <br>
        <input type="submit" value="Delete Product">
    </form>
    
    <!-- Add additional content or navigation links as needed -->
</body>

</html>
