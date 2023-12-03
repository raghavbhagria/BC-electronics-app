<!DOCTYPE html>
<html>

<head>
    <title>Already Logged In</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            margin: 0;
            padding: 20px;
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
        <h3>Already Logged In</h3>
        <p>You are already logged in as <strong>${sessionScope.authenticatedUser}</strong>.</p>
        <p>If you want to log in as a different user or log out, you can do so below:</p>

        <form action="logout.jsp" method="post">
            <input class="submit" type="submit" value="Log Out">
        </form>
    </div>

</body>

</html>
