<%@ page import="java.text.NumberFormat, java.util.ArrayList, java.util.Arrays" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.SQLException, java.sql.Statement, java.sql.ResultSet" %>
<%@ include file="../auth.jsp" %>
<%@ include file="jdbc.jsp" %>

<%
    String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
    // Print out total order amount by year
    String sql = "SELECT YEAR(orderDate) AS orderYear, SUM(totalAmount) AS totalAmount " +
                 "FROM orderSummary " +
                 "GROUP BY YEAR(orderDate)";
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    
    ArrayList<String> labelsArray = new ArrayList<>();
    ArrayList<Double> dataArray = new ArrayList<>();
    
    try (Connection con = DriverManager.getConnection(url, uid, pw);
         Statement stmt = con.createStatement();) {	
        out.println("<h1 style=\"background-color: #232f3e; color: #ffffff; padding: 20px; margin: 0;\">Administrator Sales Report by Year</h1>");
        
        getConnection();
        ResultSet rst = stmt.executeQuery(sql);		
        out.println("<table style=\"width: 50%; border-collapse: collapse; margin-top: 20px;\">");
        out.println("<tr style=\"background-color: #232f3e; color: #ffffff;\"><th>Year</th><th>Total Order Amount</th></tr>");	
        while (rst.next()) {
            out.println("<tr><td>"+rst.getString("orderYear")+"</td><td>"+currFormat.format(rst.getDouble("totalAmount"))+"</td></tr>");
            
            // Add data to arrays
            labelsArray.add(rst.getString("orderYear"));
            dataArray.add(rst.getDouble("totalAmount"));
        }
        out.println("</table>");		
    } catch (SQLException ex) { 	
        out.println(ex); 
    } finally {	
        closeConnection();	
    }
%>
<canvas id="salesChart" width="300" height="150"></canvas>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // JavaScript code for creating a pie chart
    var ctx = document.getElementById('salesChart').getContext('2d');

    var chartData = {
        labels: <%= Arrays.toString(labelsArray.toArray()) %>,
        datasets: [{
            label: 'Total Order Amount',
            backgroundColor: [
                'rgba(255, 99, 132, 0.5)',
                'rgba(255, 159, 64, 0.5)',
                'rgba(255, 205, 86, 0.5)',
                'rgba(75, 192, 192, 0.5)',
                'rgba(54, 162, 235, 0.5)',
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(255, 159, 64, 1)',
                'rgba(255, 205, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(54, 162, 235, 1)',
            ],
            borderWidth: 1,
            data: <%= Arrays.toString(dataArray.toArray()) %>
        }]
    };

    var myChart = new Chart(ctx, {
        type: 'pie',
        data: chartData,
    });
</script>
