<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String orderNum = request.getParameter("order");
    String totalStr = request.getParameter("total");
    double totalAmount = 0;
    if (totalStr != null && !totalStr.isEmpty()) {
        try {
            totalAmount = Double.parseDouble(totalStr);
        } catch(NumberFormatException e) {
            totalAmount = 0;
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Success - Mathado's Queen of Kota</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Barlow+Condensed:wght@400;600;700&family=Barlow:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .success-container {
            max-width: 600px;
            margin: 120px auto 60px;
            text-align: center;
            padding: 50px;
            background: var(--surface);
            border-radius: 16px;
            border: 1px solid var(--border);
        }
        .success-icon {
            font-size: 80px;
            color: var(--green);
            margin-bottom: 20px;
        }
        .order-number {
            background: var(--surface2);
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            font-family: monospace;
            font-size: 18px;
            border: 1px solid var(--border);
        }
        .btn-continue {
            background: var(--orange);
            color: white;
            padding: 14px 35px;
            border: none;
            border-radius: 8px;
            display: inline-block;
            margin-top: 25px;
            font-family: var(--font-head);
            font-size: 16px;
            font-weight: 700;
            text-transform: uppercase;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-continue:hover {
            background: var(--orange-light);
            transform: translateY(-2px);
        }
        .delivery-info {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border);
            color: var(--muted);
            font-size: 14px;
        }
        .reset-cart-btn {
            background: rgba(231, 76, 60, 0.2);
            color: var(--red);
            padding: 10px 20px;
            border: 1px solid var(--red);
            border-radius: 6px;
            margin-top: 20px;
            cursor: pointer;
            font-size: 14px;
        }
        .reset-cart-btn:hover {
            background: var(--red);
            color: white;
        }
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
        <a href="${pageContext.request.contextPath}/pages/cart.jsp" class="cart-btn">
            <i class="fas fa-shopping-bag"></i> CART 
            <span class="cart-count">0</span>
        </a>
    </div>
</nav>

<div class="success-container">
    <div class="success-icon">
        <i class="fas fa-check-circle"></i>
    </div>
    <h1 class="section-title" style="font-size: 42px;">ORDER PLACED!</h1>
    <p style="font-size: 16px; margin-bottom: 20px;">Thank you for ordering from Mathado's Queen of Kota!</p>
    
    <div class="order-number">
        <strong>Order Number:</strong> <%= orderNum != null ? orderNum : "ORD-" + System.currentTimeMillis() %>
    </div>
    
    <p><strong>Total Amount:</strong> R<%= String.format("%.2f", totalAmount) %></p>
    <p><strong>Estimated delivery time:</strong> 20-30 minutes</p>
    <p><strong>Delivery location:</strong> Breyten, Mpumalanga</p>
    
    <div class="delivery-info">
        <i class="fas fa-motorcycle"></i> Our rider will contact you shortly
    </div>
    
    <a href="${pageContext.request.contextPath}/MenuServlet" class="btn-continue">
        <i class="fas fa-shopping-bag"></i> CONTINUE SHOPPING
    </a>
    
    <div>
        <button class="reset-cart-btn" onclick="manualResetCart()">
            <i class="fas fa-trash"></i> Reset Cart (If items remain)
        </button>
    </div>
</div>

<footer>
    <div class="footer-top">
        <div class="footer-brand">
            <div class="logo">Mathado's <span>Queen of Kota</span></div>
            <p>Breyten's favourite online Kota & Bunny Chow ordering platform.</p>
        </div>
    </div>
    <div class="footer-divider"></div>
    <div class="footer-bottom">
        <div class="copyright">&copy; 2025 Mathado's Queen of Kota. Serving Breyten, Mpumalanga.</div>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/js/script.js"></script>
<script>
// Force clear all cart data when success page loads
function manualResetCart() {
    localStorage.removeItem('mathadosCart');
    localStorage.removeItem('kotaCart');
    localStorage.removeItem('cart');
    sessionStorage.removeItem('checkoutCart');
    sessionStorage.removeItem('cart');
    
    // Update cart count to 0
    let cartCountElements = document.querySelectorAll('.cart-count');
    for (let i = 0; i < cartCountElements.length; i++) {
        cartCountElements[i].textContent = '0';
    }
    
    alert('Cart has been reset to 0!');
    location.reload();
}

document.addEventListener('DOMContentLoaded', function() {
    // Clear ALL possible cart storage keys on page load
    localStorage.removeItem('mathadosCart');
    localStorage.removeItem('kotaCart');
    localStorage.removeItem('cart');
    sessionStorage.removeItem('checkoutCart');
    sessionStorage.removeItem('cart');
    
    // Update cart count display to 0
    let cartCountElements = document.querySelectorAll('.cart-count');
    for (let i = 0; i < cartCountElements.length; i++) {
        cartCountElements[i].textContent = '0';
    }
    
    // Clear the cart variable in script.js if accessible
    if (typeof window.clearCart === 'function') {
        window.clearCart();
    }
    
    console.log('Cart has been cleared after order! Cart should now show 0 items.');
});
</script>
</body>
</html>