<%@ page import="java.sql.*, java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
    <title> Write a Review</title>
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
            height: 100vh;
        }

        .header {
            background-color: #232f3e;
            color: #ffffff;
            padding: 20px;
            width: 100%;
            text-align: center;
        }

        .write-review-form {
            max-width: 600px;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            margin-top: 20px;
        }

        .write-review-form h2 {
            color: #333;
        }

        .write-review-form textarea {
            width: 100%;
            height: 100px;
            margin-top: 10px;
        }

        .write-review-form input[type="submit"] {
            background-color: #232f3e;
            color: #ffffff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .write-review-form input[type="submit"]:hover {
            background-color: #1a2533;
        }
    </style>
</head>
<body>

<div class="header">
    <h1> Write a Review</h1>
</div>

<%
    // Get product ID from the request parameter
    String productId = request.getParameter("id");

    // Check if the product ID is not null and is a valid integer
    if (productId != null && productId.matches("\\d+")) {
%>
    <div class="write-review-form">
        <h2>Write a Review</h2>
        <form action="submitReview.jsp" method="post">
            <input type="hidden" name="productId" value="<%= productId %>">
            
            <label for="rating">Rating:</label>
            <select name="rating" required>
                <option value="5">5 - Excellent</option>
                <option value="4">4 - Very Good</option>
                <option value="3">3 - Good</option>
                <option value="2">2 - Fair</option>
                <option value="1">1 - Poor</option>
            </select>

            <br>

            <label for="comment">Review Comment:</label>
            <textarea name="comment" required></textarea>

            <br>

            <input type="submit" value="Submit Review">
        </form>
    </div>
<%
    } else {
        // Handle invalid product ID
        out.println("<p>Invalid product ID</p>");
    }
%>

</body>
</html>
