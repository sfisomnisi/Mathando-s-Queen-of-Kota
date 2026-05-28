<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="za.ac.tut.kotashop.model.CartItem" %>
<%
    String orderNumber = (String) request.getAttribute("orderNumber");
    String dateTime = (String) request.getAttribute("dateTime");
    String customerName = (String) request.getAttribute("customerName");
    String customerEmail = (String) request.getAttribute("customerEmail");
    String customerPhone = (String) request.getAttribute("customerPhone");
    String deliveryAddress = (String) request.getAttribute("deliveryAddress");
    String specialInstructions = (String) request.getAttribute("specialInstructions");
    String paymentMethod = (String) request.getAttribute("paymentMethod");
    List<CartItem> cart = (List<CartItem>) request.getAttribute("cart");
    Double subtotal = (Double) request.getAttribute("subtotal");
    
    if (subtotal == null) subtotal = 0.0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Receipt - Mathado's Queen of Kota</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Barlow+Condensed:wght@400;600;700&family=Barlow:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .receipt-container { max-width: 600px; margin: 100px auto 60px; padding: 0 20px; }
        .receipt-card { background: white; color: black; border-radius: 16px; padding: 30px; font-family: monospace; box-shadow: 0 10px 40px rgba(0,0,0,0.2); }
        .receipt-header { text-align: center; border-bottom: 2px solid #FF5A00; padding-bottom: 15px; margin-bottom: 20px; }
        .receipt-header h1 { font-size: 24px; color: #FF5A00; margin: 0; }
        .info-box { background: #f5f5f5; padding: 15px; border-radius: 8px; margin: 15px 0; font-size: 13px; }
        .info-box div { margin: 5px 0; }
        .items-table { width: 100%; margin: 15px 0; border-collapse: collapse; }
        .items-table th, .items-table td { padding: 8px; text-align: left; border-bottom: 1px solid #ddd; }
        .items-table th { background: #f0f0f0; }
        .grand-total { font-size: 18px; font-weight: bold; color: #FF5A00; margin-top: 10px; padding-top: 10px; border-top: 1px dashed #ccc; display: flex; justify-content: space-between; }
        .btn-group { display: flex; gap: 10px; margin-top: 20px; }
        .btn-print, .btn-continue { flex: 1; padding: 12px; border: none; border-radius: 8px; cursor: pointer; font-size: 16px; font-weight: bold; text-align: center; text-decoration: none; }
        .btn-print { background: #2c3e50; color: white; }
        .btn-continue { background: #FF5A00; color: white; }
        @media print { .btn-group { display: none; } }
    </style>
</head>
<body>

<nav id="navbar">
    <a href="${pageContext.request.contextPath}/HomeServlet" class="nav-logo">Mathado's <span>Queen of Kota</span></a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/HomeServlet">HOME</a></li>
        <li><a href="${pageContext.request.contextPath}/MenuServlet">MENU</a></li>
    </ul>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/pages/cart.jsp" class="cart-btn"><i class="fas fa-shopping-bag"></i> CART <span class="cart-count">0</span></a>
    </div>
</nav>

<div class="receipt-container">
    <div class="receipt-card">
        <div class="receipt-header">
            <h1>MATHADO'S QUEEN OF KOTA</h1>
            <p>Breyten, Mpumalanga | Tel: 071 234 5678</p>
        </div>
        
        <div class="info-box">
            <div><strong>📋 ORDER NUMBER:</strong> <%= orderNumber != null ? orderNumber : "N/A" %></div>
            <div><strong>📅 DATE & TIME:</strong> <%= dateTime != null ? dateTime : "N/A" %></div>
            <div><strong>👤 CUSTOMER NAME:</strong> <%= customerName != null ? customerName : "N/A" %></div>
            <div><strong>📧 EMAIL:</strong> <%= customerEmail != null ? customerEmail : "N/A" %></div>
            <div><strong>📞 PHONE:</strong> <%= customerPhone != null ? customerPhone : "N/A" %></div>
            <div><strong>📍 DELIVERY ADDRESS:</strong> <%= deliveryAddress != null ? deliveryAddress : "N/A" %></div>
            <div><strong>💳 PAYMENT METHOD:</strong> <%= paymentMethod != null ? paymentMethod : "N/A" %></div>
            <% if (specialInstructions != null && !specialInstructions.isEmpty()) { %>
            <div><strong>📝 SPECIAL INSTRUCTIONS:</strong> <%= specialInstructions %></div>
            <% } %>
        </div>
        
        <table class="items-table">
            <thead><tr><th>Qty</th><th>Item</th><th>Price</th><th>Subtotal</th></tr></thead>
            <tbody>
                <% if (cart != null && !cart.isEmpty()) { 
                    for (CartItem item : cart) { %>
                <tr>
                    <td><%= item.getQuantity() %>x</td>
                    <td><%= item.getProduct().getProductName() %></td>
                    <td>R<%= String.format("%.2f", item.getProduct().getPrice()) %></td>
                    <td>R<%= String.format("%.2f", item.getSubtotal()) %></td>
                </tr>
                <%      }
                   } else { %>
                <tr><td colspan="4" style="text-align:center;">No items found</td></tr>
                <% } %>
            </tbody>
        </table>
        
        <div class="grand-total">
            <span><strong>TOTAL TO PAYED:</strong></span>
            <span><strong>R<%= String.format("%.2f", subtotal) %></strong></span>
        </div>
        
        <div class="info-box" style="text-align:center; background:#e8f5e9; margin-top:20px;">
            <p>✅ Thank you for ordering from Mathado's Queen of Kota!</p>
            <p>📍 Delivering to: <%= deliveryAddress != null ? deliveryAddress : "your address" %></p>
            <p>⏱️ Estimated delivery: 20-30 minutes</p>
        </div>
        
        <div class="btn-group">
            <button class="btn-print" onclick="window.print()">🖨️ PRINT RECEIPT</button>
            <a href="${pageContext.request.contextPath}/MenuServlet" class="btn-continue" onclick="clearCart()">✓ CONTINUE SHOPPING</a>
        </div>
    </div>
</div>

<script>
function clearCart() {
    localStorage.removeItem('mathadosCart');
    sessionStorage.removeItem('checkoutCart');
}
</script>

<footer>
    <div class="footer-bottom">
        <div class="copyright">&copy; 2025 Mathado's Queen of Kota. Serving Breyten, Mpumalanga.</div>
    </div>
</footer>
</body>
</html>