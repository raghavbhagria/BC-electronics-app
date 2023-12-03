<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Raghav's Grocery Main Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            text-align: center;
            margin: 50px;
        }

        h1 {
            color: #232f3e;
        }

        h2, h3 {
            color: #333;
        }

        a {
            display: block;
            padding: 10px 20px;
            margin: 10px auto;
            background-color: #232f3e;
            color: #ffffff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            width: 200px;
        }

        a:hover {
            background-color: #1a2634;
        }
    </style>
</head>
<body>
    <h1>Welcome to Raghav's Grocery</h1>

    <h2><a href="login.jsp">Login</a></h2>

    <h2><a href="listprod.jsp">Begin Shopping</a></h2>

    <h2><a href="listorder.jsp">List All Orders</a></h2>

    <h2><a href="customer.jsp">Customer Info</a></h2>

    <h2><a href="admin.jsp">Administrators</a></h2>

    <h2><a href="logout.jsp">Log out</a></h2>

    <% String userName = (String) session.getAttribute("authenticatedUser");
       if (userName != null)
           out.println("<h3>Signed in as: " + userName + "</h3>");
    %>

    <h4><a href="ship.jsp?orderId=1">Test Ship orderId=1</a></h4>

    <h4><a href="ship.jsp?orderId=3">Test Ship orderId=3</a></h4>
</body>
</html>
