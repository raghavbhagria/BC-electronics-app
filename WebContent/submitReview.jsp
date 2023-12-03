<%@ page import="java.sql.*, java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="jdbc.jsp" %>

<%
    // Get parameters from the request
    String reviewRating = request.getParameter("rating");
    String productId = request.getParameter("productId");
    String comment = request.getParameter("comment");

    // Check if the parameters are not null and are valid
    if (reviewRating != null && productId != null && reviewRating.matches("\\d+") && productId.matches("\\d+")) {
        try (Connection con = DriverManager.getConnection(url, uid, pw)) {
            String insertQuery = "INSERT INTO review (reviewRating, reviewDate, customerId, productId, reviewComment) " +
                                 "VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = con.prepareStatement(insertQuery)) {
                pstmt.setInt(1, Integer.parseInt(reviewRating));
                pstmt.setDate(2, new java.sql.Date(new Date().getTime())); // current date as review date
                pstmt.setInt(3, 1); // assuming customerId, replace with the actual value
                pstmt.setInt(4, Integer.parseInt(productId));
                pstmt.setString(5, comment);

                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Successful insertion, you can redirect to a success page or back to the product page
                    response.sendRedirect("product.jsp?id=" + productId);
                } else {
                    // Handle unsuccessful insertion
                    out.println("<p>Failed to submit the review. Please try again.</p>");
                }
            }
        } catch (SQLException e) {
            // Handle database-related errors
            out.println("<p>Error processing the review: " + e.getMessage() + "</p>");
        }
    } else {
        // Handle invalid parameters
        out.println("<p>Invalid parameters for review submission.</p>");
    }
%>
