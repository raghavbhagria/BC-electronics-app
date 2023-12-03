<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

<%
    // Retrieve form parameters
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String phonenum = request.getParameter("phonenum");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String postalCode = request.getParameter("postalCode");

    try {
        getConnection();

        // Check if the username is already in use
        PreparedStatement checkUsernameStmt = con.prepareStatement("SELECT * FROM Customer WHERE userid=?");
        checkUsernameStmt.setString(1, username);
        ResultSet usernameResult = checkUsernameStmt.executeQuery();

        if (usernameResult.next()) {
            // Username already exists, handle accordingly (e.g., redirect back to signup with an error message)
            session.setAttribute("signupError", "Username already exists. Please choose a different username.");
            response.sendRedirect("signup.jsp");
        } else {
            // Username is unique, proceed with registration
            PreparedStatement insertUserStmt = con.prepareStatement("INSERT INTO Customer (firstName, lastName, email, phonenum, address, city, state, postalCode, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            insertUserStmt.setString(1, firstName);
            insertUserStmt.setString(2, lastName);
            insertUserStmt.setString(3, email);
            insertUserStmt.setString(4, phonenum);
            insertUserStmt.setString(5, address);
            insertUserStmt.setString(6, city);
            insertUserStmt.setString(7, state);
            insertUserStmt.setString(8, postalCode);
            insertUserStmt.setString(9, username);
            insertUserStmt.setString(10, password);

            insertUserStmt.executeUpdate();

            // Redirect to a success page or login page
            response.sendRedirect("login.jsp");
        }
    } catch (SQLException ex) {
        out.println(ex);
    } finally {
        closeConnection();
    }
%>
