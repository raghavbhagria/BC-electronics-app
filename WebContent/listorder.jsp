<%@ page import="java.sql.*,java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8" %>
<!DOCTYPE html>
<html>
<head>
    <title>BC Electronics List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            margin: 0;
            padding: 0;
        }

        h1 {
            background-color: #232f3e;
            color: #ffffff;
            padding: 20px;
            margin: 0;
        }

        .content {
            max-width: 800px;
            margin: 20px auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .order {
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 12px;
        }

        th {
            background-color: #232f3e;
            color: #ffffff;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
    <h1>Order List</h1>
    <div class="content">
        <%
            try {
                // Establish the database connection
                getConnection();

                // Use the "orders" database
                Statement stmt = con.createStatement();
                stmt.execute("USE orders");

                // SQL query to retrieve order information
                String sql = "SELECT orderId, O.CustomerId, totalAmount, firstName+' '+lastName, orderDate FROM OrderSummary O, Customer C WHERE "
                        + "O.customerId = C.customerId";

                // Currency formatter
                NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

                // Execute the query and retrieve results
                ResultSet rst = stmt.executeQuery(sql);

                // Iterate through orders
                while (rst.next()) {
        %>
                    <div class="order">
                        <h3>Order ID: <%= rst.getInt(1) %> - OrderDate:<%=rst.getDate(5) %> - Customer ID: <%=rst.getInt(2) %> - Customer Name: <%= rst.getString(4) %> - Total Amount: <%=currFormat.format(rst.getDouble(3)) %> </h3>
                        <table>
                            <tr>
                                <th>Product Id</th>
                                <th>Quantity</th>
                                <th>Price</th>
                            </tr>

                            <%
                                // Retrieve all the items for an order
                                int orderId = rst.getInt(1);
                                sql = "SELECT productId, quantity, price FROM OrderProduct WHERE orderId=?";
                                PreparedStatement pstmt = con.prepareStatement(sql);
                                pstmt.setInt(1, orderId);
                                ResultSet rst2 = pstmt.executeQuery();

                                // Iterate through order items
                                while (rst2.next()) {
                            %>
                                    <tr>
                                        <td><%= rst2.getInt(1) %></td>
                                        <td><%= rst2.getInt(2) %></td>
                                        <td><%= currFormat.format(rst2.getDouble(3)) %></td>
                                    </tr>
                            <%
                                }
                                rst2.close(); // Close the result set for order items
                            %>
                        </table>
                    </div>
        <%
                }
            } catch (SQLException ex) {
                out.println("An error occurred: " + ex.getMessage());
            
                // Print stack trace to JSP output
                StackTraceElement[] stackTrace = ex.getStackTrace();
                for (StackTraceElement element : stackTrace) {
                    out.println(element.toString());
                }
            } finally {
                // Close the database connection
                closeConnection();
            }
        %>
    </div>
</body>
</html>
