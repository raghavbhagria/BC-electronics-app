<%@ page import="java.io.*,java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.io.*,java.sql.*,java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BC Electronics Main Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            margin: 0;
            padding: 20px;
            text-align: center;
        }

        h1, h2 {
            background-color: #232f3e;
            color: #ffffff;
            padding: 20px;
            margin: 0;
        }

        form {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        input[type="text"] {
            padding: 10px;
            font-size: 16px;
            flex: 0 0 60%;
        }

        input[type="submit"],
        input[type="reset"] {
            padding: 10px;
            font-size: 16px;
            cursor: pointer;
            flex: 0 0 10%;
            margin-left: 5px;
        }

        select {
            padding: 10px;
            font-size: 16px;
            flex: 0 0 20%;
            margin-right: 10px;
        }

        .admin-link,
        .hide-when-signed-in,
        .customer-info-link,
        .view-my-orders-button {
            background-color: #232f3e;
            color: #ffffff;
            padding: 10px;
            border-radius: 5px;
            margin: 10px;
            text-decoration: none;
            display: inline-block;
        }

        .admin-link:hover,
        .hide-when-signed-in:hover,
        .customer-info-link:hover,
        .view-my-orders-button:hover {
            background-color: #1a2634;
        }

        .product-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .product {
            flex: 0 0 28%;
            margin: 10px;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        .product img {
            max-width: 100%;
            height: auto;
        }

        .view-cart-button {
            text-decoration: none;
            background-color: #232f3e;
            color: #ffffff;
            padding: 10px;
            border-radius: 5px;
            display: <%= (session.getAttribute("authenticatedUser") != null && !((String)session.getAttribute("authenticatedUser")).isEmpty()) ? "block" : "none" %>;
        }

        .view-cart-container {
            position: absolute;
            top: 20px;
            right: 20px;
        }
    </style>
</head>

<body>

    <h1>Welcome to BC Electronics</h1>

    <!-- Display user information or link to sign in -->
    <div>
        <%
            String currentUser = (String) session.getAttribute("authenticatedUser");

            if (currentUser != null && !currentUser.isEmpty()) {
        %>
            <p>Welcome, <%= currentUser %>! (<a href="logout.jsp">Logout</a>)</p>
            
        <%
            } else {
        %>
            <p class="hide-when-signed-in"><a href="login.jsp">Sign In</a></p>
            <a class="hide-when-signed-in" href="admin.jsp">Admin Login</a>
        <%
            }
        %>
        
        <a class="customer-info-link" href="customer.jsp">Customer Info</a>
    </div>

    <!-- View Cart button -->
    <div class="view-cart-container">
        <%
            boolean isLoggedIn = currentUser != null && !currentUser.isEmpty();
        %>

        <!-- Show "View Cart" button only if the user is logged in -->
        <%
            if (isLoggedIn) {
        %>
            <a href="showcart.jsp" class="view-cart-button">View Cart</a>
        <%
            }
        %>
    </div>

    <form method="get" action="listprod.jsp">
        <input type="text" name="productName" size="30" placeholder="Search products">
        
        <!-- Filter by Category dropdown moved here -->
        <select id="categoryFilter" name="category" onchange="applyCategoryFilter()">
            <option value="all">All Categories</option>
            <%
                try {
                    getConnection();
                    Statement stmt = con.createStatement();
                    ResultSet categoryResultSet = stmt.executeQuery("SELECT categoryId, categoryName FROM category");

                    while (categoryResultSet.next()) {
            %>
                        <option value="<%= categoryResultSet.getString("categoryId") %>">
                            <%= categoryResultSet.getString("categoryName") %>
                        </option>
            <%
                    }
                } catch (SQLException ex) {
                    out.println(ex);
                } finally {
                    closeConnection();
                }
            %>
        </select>
        
        <input type="submit" value="Search">
        <input type="reset" value="Reset">
    </form>

    <%
    String name = request.getParameter("productName");
    boolean hasParameter = false;
    String sql = "";

    if (name == null) name = "";
    if (name.equals("")) {
        out.println("<h2>All Products</h2>");
        sql = "SELECT productId, productName, category.categoryName, productPrice, productImageURL FROM Product, category " +
                "WHERE Product.categoryId = category.categoryId";
    } else {
        out.println("<h2>Products containing '" + name + "'</h2>");
        hasParameter = true;
        sql = "SELECT productId, productName, categoryName, productPrice, productImageURL FROM Product, category " +
                "WHERE Product.categoryId = category.categoryId and productName LIKE ?";
        name = '%' + name + '%';
    }

    NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

    try {
        getConnection();
        Statement stmt = con.createStatement();
        stmt.execute("USE orders");

        // Additional condition for category filter
        String categoryId = request.getParameter("category");
        boolean hasCategoryFilter = categoryId != null && !categoryId.isEmpty() && !categoryId.equals("all");

        if (hasCategoryFilter) {
            if (hasParameter) {
                sql += " AND category.categoryId = ?";
            } else {
                sql += " AND Product.categoryId = ?";
            }
        }

        PreparedStatement pstmt = con.prepareStatement(sql);

        int paramIndex = 1; // Start index for parameters

        if (hasParameter) {
            pstmt.setString(paramIndex++, name);
        }

        if (hasCategoryFilter) {
            pstmt.setString(paramIndex++, categoryId);
        }

        ResultSet rst = pstmt.executeQuery();

        out.println("<div class=\"product-container\">");  // Add a container for products

        while (rst.next()) {
    %>
                <div class="product">
                    <a href="product.jsp?id=<%= rst.getInt("productId") %>">
                        <img src="<%= rst.getString("productImageURL") %>" alt="<%= rst.getString("productName") %>">
                    </a>
                    <p><strong><a href="product.jsp?id=<%= rst.getInt("productId") %>"><%= rst.getString("productName") %></a></strong></p>
                    <p>Category: <%= rst.getString("categoryName") %></p>
                    <p>Price: <%= currFormat.format(rst.getDouble("productPrice")) %></p>
                </div>
    <%
            }
    %>
            </div> <!-- Close the product container -->

        <% } catch (SQLException ex) {
            out.println(ex);
        } finally {
            closeConnection();
        }
    %>

    <script>
        // JavaScript function to apply category filter
        function applyCategoryFilter() {
            var selectedCategory = document.getElementById("categoryFilter").value;

            // Redirect to the same page with the selected category as a parameter
            window.location.href = "listprod.jsp?category=" + selectedCategory;
        }
    </script>

</body>

</html>
