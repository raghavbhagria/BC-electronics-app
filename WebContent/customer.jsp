<!DOCTYPE html>
<html>
<head>
    <title>Customer Page</title>
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

        table {
            border-collapse: collapse;
            width: 50%;
            margin: 20px auto;
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

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
    String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
    // TODO: Print Customer information
    String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password FROM customer WHERE userid = ?";
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;database=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    try (Connection con = DriverManager.getConnection(url, uid, pw);
         PreparedStatement pstmt = con.prepareStatement(sql)) {

        pstmt.setString(1, userName);
        ResultSet rst = pstmt.executeQuery();
        

        if (rst.next()) {
            out.println("<h1>Customer Information</h1>");
            out.println("<table>");
            out.println("<tr><th>Id</th><td>" + rst.getString(1) + "</td></tr>");
            out.println("<tr><th>First Name</th><td>" + rst.getString(2) + "</td></tr>");
            out.println("<tr><th>Last Name</th><td>" + rst.getString(3) + "</td></tr>");
            out.println("<tr><th>Email</th><td>" + rst.getString(4) + "</td></tr>");
            out.println("<tr><th>Phone</th><td>" + rst.getString(5) + "</td></tr>");
            out.println("<tr><th>Address</th><td>" + rst.getString(6) + "</td></tr>");
            out.println("<tr><th>City</th><td>" + rst.getString(7) + "</td></tr>");
            out.println("<tr><th>State</th><td>" + rst.getString(8) + "</td></tr>");
            out.println("<tr><th>Postal Code</th><td>" + rst.getString(9) + "</td></tr>");
            out.println("<tr><th>Country</th><td>" + rst.getString(10) + "</td></tr>");
            out.println("<tr><th>User id</th><td>" + rst.getString(11) + "</td></tr>");
            out.println("</table>");
        }
    } catch (SQLException ex) {
        out.println(ex);
    }
%>

</body>
</html>
