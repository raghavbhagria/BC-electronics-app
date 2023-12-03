<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>


<!DOCTYPE html>
<html>

<head>
    <title>Sign Up</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            margin: 0;
            padding: 20px;
            text-align: center;
        }

        div {
            margin: 0 auto;
            text-align: center;
            display: inline-block;
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
            text-align: left;
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
    </style>
</head>

<body>

    <div>
        <h3>Sign Up for an Account</h3>

        <%-- Display signup error message if present --%>
        <c:if test="${not empty sessionScope.signupError}">
            <p class="error">${sessionScope.signupError}</p>
        </c:if>

        <form name="SignUpForm" method="post" action="signUpValidation.jsp">
            <table>
                <tr>
                    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
                    <td><input type="text" name="firstName" size="20" maxlength="40" required></td>
                </tr>
                <tr>
                    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
                    <td><input type="text" name="lastName" size="20" maxlength="40" required></td>

                </tr>
                <tr>
                    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
                    <td><input type="text" name="address" size="20" maxlength="40" required></td>
                </tr>
                <tr>
                    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
                    <td><input type="text" name="city" size="20" maxlength="40" required></td>
                </tr>
                <tr>
                    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">State:</font></div></td>
                    <td><input type="text" name="state" size="20" maxlength="40" required></td>
                </tr>
                <tr>
                    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">PostalCode:</font></div></td>
                    <td><input type="text" name="postalCode" size="20" maxlength="40" required></td>
                </tr>
                <tr>
                    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone:</font></div></td>
                    <td><input type="text" name="phonenum" size="20" maxlength="40" required></td>
                </tr>
                
                <tr>
                    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
                    <td><input type="text" name="username" size="20" maxlength="20" required></td>
                </tr>
                <tr>
                    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
                    <td><input type="email" name="email" size="30" maxlength="50" required></td>
                </tr>
                <tr>
                    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
                    <td><input type="password" name="password" size="20" maxlength="20" required></td>
                </tr>
                <!-- Add more fields as needed -->

                <tr>
                    <td colspan="2"><input class="submit" type="submit" name="Submit" value="Sign Up"></td>
                </tr>
            </table>
        </form>
    </div>

</body>

</html>
