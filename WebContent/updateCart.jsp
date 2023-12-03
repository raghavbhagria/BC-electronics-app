<%@ page import="java.util.Map, java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Retrieve the current shopping cart from the session
    @SuppressWarnings("unchecked")
    Map<String, ArrayList<Object>> productList = (Map<String, ArrayList<Object>>) session.getAttribute("productList");

    // Check if the shopping cart exists
    if (productList == null) {
        // Handle the case where the shopping cart is empty or not created
        response.sendRedirect("listprod.jsp");
    } else {
        // Handle the actions to update or remove items from the shopping cart

        // Get the product ID and quantity from the request parameters
        String productIdParam = request.getParameter("productId");
        String quantityParam = request.getParameter("quantity");

        // Check if both parameters are present
        if (productIdParam != null && quantityParam != null) {
            // Parse the parameters
            int productId = Integer.parseInt(productIdParam);
            int quantity = Integer.parseInt(quantityParam);

            // Check if the product is in the cart
            if (productList.containsKey(Integer.toString(productId))) {
                // Update the quantity
                ArrayList<Object> product = productList.get(Integer.toString(productId));
                product.set(3, quantity); // Assuming the quantity is stored at index 3

                // Save the updated shopping cart back to the session
                session.setAttribute("productList", productList);
            }
        } else if (productIdParam != null) {
            // Remove the product from the cart
            productList.remove(productIdParam);

            // Save the updated shopping cart back to the session
            session.setAttribute("productList", productList);
        }

        // Redirect the user back to the shopping cart page
        response.sendRedirect("showCart.jsp");
    }
%>
