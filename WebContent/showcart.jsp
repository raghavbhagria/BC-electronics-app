<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Your Shopping Cart</title>
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

        a {
            display: inline-block;
            padding: 10px 20px;
            text-decoration: none;
            background-color: #232f3e;
            color: #ffffff;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        a:hover {
            background-color: #1a2433;
        }
    </style>
</head>
<body>

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	
    out.println("<h1>Your shopping cart is empty!</h1>");
    productList = new HashMap<String, ArrayList<Object>>();
}
else
{
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();

    out.println("<h1>Your Shopping Cart</h1>");
    out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
    out.println("<th>Price</th><th>Subtotal</th><th>Actions</th></tr>");

    double total = 0;
    Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
    while (iterator.hasNext()) 
    {   
        Map.Entry<String, ArrayList<Object>> entry = iterator.next();
        ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
        if (product.size() < 4)
        {
            out.println("Expected product with four entries. Got: "+product);
            continue;
        }
        
        out.print("<tr><td>"+product.get(0)+"</td>");
        out.print("<td>"+product.get(1)+"</td>");

        out.print("<td align=\"center\">"+product.get(3)+"</td>");
        Object price = product.get(2);
        Object itemqty = product.get(3);
        double pr = 0;
        int qty = 0;
        
        try
        {
            pr = Double.parseDouble(price.toString());
        }
        catch (Exception e)
        {
            out.println("Invalid price for product: "+product.get(0)+" price: "+price);
        }
        try
        {
            qty = Integer.parseInt(itemqty.toString());
        }
        catch (Exception e)
        {
            out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
        }       

        out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
        out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td>");

        // Add buttons for actions
        out.println("<td>");
        out.println("<form action=\"updateCart.jsp\" method=\"post\">");
        out.println("<input type=\"hidden\" name=\"productId\" value=\"" + product.get(0) + "\">");
        out.println("<input type=\"submit\" value=\"Remove\" name=\"action\">");
        out.println("</form>");

        out.println("<form action=\"updateCart.jsp\" method=\"post\">");
        out.println("<input type=\"hidden\" name=\"productId\" value=\"" + product.get(0) + "\">");
        out.println("<input type=\"text\" name=\"quantity\" value=\"" + product.get(3) + "\">");
        out.println("<input type=\"submit\" value=\"Update Quantity\" name=\"action\">");
        out.println("</form>");
        out.println("</td>");

        out.println("</tr>");
        total = total + pr * qty;
    }
    out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
            +"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
    out.println("</table>");

    out.println("<a href=\"checkout.jsp\">Check Out</a>");
	
}
%>
<br>
<br>
<a href="listprod.jsp">Continue Shopping</a>
</body>
</html>
