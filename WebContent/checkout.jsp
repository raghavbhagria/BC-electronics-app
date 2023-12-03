<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BC Electronics CheckOut Line</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        h1 {
            color: #2c3e50;
            margin-bottom: 30px;
            text-align: center;
        }

        form {
            max-width: 400px;
            background-color: #ecf0f1;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            text-align: left;
            margin-top: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #34495e;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            box-sizing: border-box;
            border: 1px solid #bdc3c7;
            border-radius: 4px;
            transition: border-color 0.3s ease;
        }

        input:focus {
            outline: none;
            border-color: #3498db;
        }

        input[type="submit"],
        input[type="reset"] {
            background-color: #3498db;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover,
        input[type="reset"]:hover {
            background-color: #2980b9;
        }
    </style>






<body>

<h1>Enter your shipping information to complete the transaction:</h1>

<form method="get" action="order.jsp">
    <label for="customerId">Customer ID:</label>
    <input type="text" name="customerId" size="50"><br>

    <label for="firstName">First Name:</label>
    <input type="text" name="firstName"><br>

    <label for="lastName">Last Name:</label>
    <input type="text" name="lastName"><br>

    <label for="address">Address:</label>
    <input type="text" name="address"><br>

    <!-- Add other shipping information fields as needed -->

    <input type="submit" value="Submit">
    <input type="reset" value="Reset">
</form>

</body>
</html>

