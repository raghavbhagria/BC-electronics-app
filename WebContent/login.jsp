<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
// Check if the user is already logged in
if (session.getAttribute("authenticatedUser") != null) {
    // Redirect to a different page or display a message
    response.sendRedirect("alreadyLoggedIn.jsp");
    return;
}

// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
    out.println("<p>" + session.getAttribute("loginMessage").toString() + "</p>");
%>

<!DOCTYPE html>
<html>

<head>
    <title>Login Screen</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 40vh;
        }

        div {
            text-align: center;
        }

        h3 {
            background-color: #232f3e;
            color: #ffffff;
            padding: 10px;
            margin: 0;
        }

        table {
            margin: 20px auto;
            display: inline-block;
        }

        td {
            padding: 5px;
        }

        input {
            padding: 5px;
        }

        .submit {
            background-color: #232f3e;
            color: #ffffff;
            padding: 10px;
            border: none;
            cursor: pointer;
        }

        .signup-link {
            display: block;
            margin-top: 10px;
            text-decoration: none;
            color: #232f3e;
        }
    </style>
</head>

<body>

    <div>
        <h3>Please Login to System</h3>

        <%-- Print prior error login message if present --%>
        <c:if test="${not empty sessionScope.loginMessage}">
            <p class="error">${sessionScope.loginMessage}</p>
        </c:if>

        <br>
        <form name="MyForm" method="post" action="validateLogin.jsp">
            <table>
                <tr>
                    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
                    <td><input type="text" name="username" size="10" maxlength="10"></td>
                </tr>
                <tr>
                    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
                    <td><input type="password" name="password" size="10" maxlength="10"></td>
                </tr>
            </table>
            <br />
            <input class="submit" type="submit" name="Submit2" value="Log In">
        </form>

        <a class="signup-link" href="signup.jsp">Sign up for an account?</a>
    </div>

</body>

</html>
