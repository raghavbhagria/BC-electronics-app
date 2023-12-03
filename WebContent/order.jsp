<%@ page import="java.sql.*,java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Map,java.math.BigDecimal" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Processing</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .content {
            max-width: 800px;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 15px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #8795d3;
            color: #fff;
        }

        h1, h2 {
            color: #333;
        }

        a {
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }

        a:hover {
            color: #555;
        }
    </style>
</head>

<body>
    <div class="content">
        <% 
            // Get customer id
            String custId = request.getParameter("customerId");
            @SuppressWarnings({"unchecked"})
            HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

            if (productList == null) {
                out.println("<h1>Your shopping cart is empty!</h1>");
            } else {
                int orderId = 0;

                String sql = "INSERT INTO OrderSummary (customerId, totalAmount, orderDate) VALUES(?, 0, ?);";

                NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);	

                try {
                    getConnection();
                    Statement stmt = con.createStatement(); 			
                    stmt.execute("USE orders");

                    // Retrieve auto-generated key for orderId
                    PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                    pstmt.setInt(1, Integer.parseInt(custId));
                    pstmt.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
                    pstmt.executeUpdate();
                    ResultSet keys = pstmt.getGeneratedKeys();
                    keys.next();
                    orderId = keys.getInt(1);

                    out.println("<h1>Your Order Summary</h1>");
                    out.println("<table><tr><th></th><th>Product Id</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");

                    double total = 0;
                    Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
                    while (iterator.hasNext()) { 
                        Map.Entry<String, ArrayList<Object>> entry = iterator.next();
                        ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
                        String productId = (String) product.get(0);

                        out.print("<tr><td>" + productId + "</td>");
                        out.print("<td>" + product.get(1) + "</td>");
                        out.print("<td align=\"center\">" + product.get(3) + "</td>");
                        String price = (String) product.get(2);
                        double pr = Double.parseDouble(price);
                        int qty = ((Integer) product.get(3)).intValue();

                        out.print("<td align=\"right\">" + currFormat.format(pr) + "</td>");
                        out.print("<td align=\"right\">" + currFormat.format(pr * qty) + "</td></tr>");
                        out.println("</tr>");

                        sql = "INSERT INTO OrderProduct (orderId, productId, quantity, price) VALUES(?, ?, ?, ?)";
                        pstmt = con.prepareStatement(sql);
                        pstmt.setInt(1, orderId);
                        pstmt.setString(2, productId);
                        pstmt.setInt(3, qty);
                        pstmt.setString(4, price);
                        pstmt.executeUpdate();				
                        
                        total = total + pr * qty;
                    }

                    out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
                                + "<td align=\"right\">" + currFormat.format(total) + "</td></tr>");
                    out.println("</table>");

                    // Update order total
                    sql = "UPDATE OrderSummary SET totalAmount=? WHERE orderId=?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setDouble(1, total);
                    pstmt.setInt(2, orderId);			
                    pstmt.executeUpdate();						

                    out.println("<h2>Order completed. Will be shipped soon...</h2>");
                    out.println("<h2>Your order reference number is: " + orderId + "</h2>");
                    out.println("<h2>Shipping to customer: " + custId + "</h2>");

                    out.println("<h2><a href=\"listprod.jsp\">Return to shopping</a></h2>");

                    
                    // Clear session variables (cart)
                    session.setAttribute("productList", null);
                } catch (SQLException ex) { 	
                    out.println(ex);
                } finally {
                    closeConnection();
                }
            }
        %>
    </div>
    <script>
        function logoutUser() {
            // Redirect to logout.jsp to perform the logout
            window.location.href = "logout.jsp";
        }
    </script>
</body>

</html>
