<%@ page import="java.util.ArrayList, java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ include file="jdbc.jsp" %>

<%
    ArrayList<ArrayList<String>> customers = new ArrayList<>();

    try {
        getConnection();
        String sql = "SELECT * FROM Customer";
        try (PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                ArrayList<String> customerData = new ArrayList<>();
                customerData.add(Integer.toString(rs.getInt("customerId")));
                customerData.add(rs.getString("firstName"));
                customerData.add(rs.getString("lastName"));
                // Add other fields as needed

                customers.add(customerData);
            }
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    } finally {
        closeConnection();
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>List Customers</title>
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

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
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
    <h1>List of Customers</h1>

    <table>
        <tr>
            <th>Customer ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <!-- Add other columns as needed -->
        </tr>
        <% for (ArrayList<String> customerData : customers) { %>
            <tr>
                <td><%= customerData.get(0) %></td>
                <td><%= customerData.get(1) %></td>
                <td><%= customerData.get(2) %></td>
                <!-- Add other columns as needed -->
            </tr>
        <% } %>
    </table>
</body>

</html>
