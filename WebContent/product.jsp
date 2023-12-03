<%@ page import="java.sql.*, java.text.NumberFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
    <title>BC Electronics - Product Information</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f3f3f3;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
    
        .header {
            background-color: #232f3e;
            color: #ffffff;
            padding: 20px;
            width: 100%;
            text-align: center;
        }
    
        .product-info {
            max-width: 90%;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            margin: 20px;
        }
    
        .product-info h2 {
            color: #333;
            font-size: 1.5em;
        }
    
        .product-info img {
            max-width: 100%;
            height: auto;
            margin-top: 20px;
        }
    
        .product-info table {
            width: 100%;
            margin-top: 20px;
        }
    
        .product-info table th, .product-info table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
    
        .action-buttons {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
    
        .action-buttons a {
            display: inline-block;
            padding: 10px 20px;
            margin-bottom: 10px;
            background-color: #232f3e;
            color: #ffffff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
    
        .action-buttons a:last-child {
            margin-bottom: 0;
        }
    
        .action-buttons a:hover {
            background-color: #1a2533;
        }
    
        /* Add additional styles for reviews if needed */
        .reviews {
            margin-top: 20px;
            text-align: left;
        }
    
        .reviews h3 {
            color: #232f3e;
            font-size: 1.2em;
        }
    
        .reviews ul {
            list-style: none;
            padding: 0;
        }
    
        .reviews li {
            margin-bottom: 10px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }
    </style>
    
    
</head>
<body>

<div class="header">
    <h1>BC Electronics - Product Information</h1>
</div>

<%
    // Get product name to search for
    String productId = request.getParameter("id");
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";

    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    try (Connection con = DriverManager.getConnection(url, uid, pw);
        Statement stmt = con.createStatement();) {
        
        String sql = "SELECT productId, productName, productPrice, productImageURL, productDesc FROM product WHERE productId = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(productId));
        
        ResultSet rst = pstmt.executeQuery();
        
        rst.next();
        
        // Redirect to product detail page when clicking on the product name
%>
        <div class="product-info">
            <h2><a href="product.jsp?id=<%= productId %>"><%= rst.getString("productName") %></a></h2>
            
            <table>
                <tr><th>Product ID</th><td><%= productId %></td></tr>
                <tr><th>Price</th><td><%= currFormat.format(rst.getDouble("productPrice")) %></td></tr>
                <tr><th>Description</th><td><%= rst.getString("productDesc") %></td></tr>
            </table>
            
            <!-- Display an image from the binary field productImageURL -->
            <img src="<%= rst.getString("productImageURL") %>" alt="<%= rst.getString("productName") %>">
            
            <!-- Display an image from the binary field productImage -->
            <img src="displayImage.jsp?id=<%= productId %>">
            
            <div class="action-buttons">
                <a href="addcart.jsp?id=<%= productId %>&name=<%= rst.getString("productName") %>&price=<%= rst.getDouble("productPrice") %>">Add to Cart</a>
                <a href="writeReview.jsp?id=<%= productId %>">Write a Review</a>
                <a href="listprod.jsp">Back to Products</a>
            </div>

            <!-- Reviews Section -->
            <!-- Reviews Section -->
<div class="reviews">
    <h3>Product Reviews</h3>
    <ul>
        <%
            // Fetch and display product reviews
            String reviewQuery = "SELECT * FROM review WHERE productId = ?";
            try (PreparedStatement reviewStmt = con.prepareStatement(reviewQuery)) {
                reviewStmt.setInt(1, Integer.parseInt(productId));
                ResultSet reviewSet = reviewStmt.executeQuery();

                while (reviewSet.next()) {
        %>
                    <li>
                        <strong>Rating:</strong> <%= reviewSet.getInt("reviewRating") %><br>
                        <strong>Comment:</strong> <%= reviewSet.getString("reviewComment") %><br>
                        <strong>Date:</strong> <%= reviewSet.getDate("reviewDate") %>
                    </li>
        <%
                }
            }
        %>
    </ul>
</div>
        </div>
<%
    } catch (SQLException ex) {
        out.println(ex);
    }
%>

</body>
</html>
