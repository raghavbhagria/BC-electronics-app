<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Retrieve the current session
    HttpSession session = request.getSession(true);

    // Check if the user is signed in
    String currentUser = (String) session.getAttribute("currentUser");
    boolean isLoggedIn = currentUser != null && !currentUser.isEmpty();
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Session Information</title>
</head>

<body>

    <h1>Session Information</h1>

    <% if (isLoggedIn) { %>
        <p>Welcome, <%= currentUser %>! (<a href="logout.jsp">Logout</a>)</p>
    <% } else { %>
        <p>You are not signed in. (<a href="login.jsp">Sign In</a>)</p>
    <% } %>

    <p>Session ID: <%= session.getId() %></p>

</body>

</html>
