<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="za.ac.tut.kotashop.model.CartItem" %>
<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    
    double subtotal = 0;
    if (cart != null) {
        for (CartItem item : cart) {
            subtotal += item.getSubtotal();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Mathado's Queen of Kota</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Barlow+Condensed:wght@400;600;700&family=Barlow:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .checkout-container { max-width: 1200px; margin: 100px auto 60px; padding: 0 20px; display: grid; grid-template-columns: 1fr 1fr; gap: 40px; }
        .checkout-form, .order-summary-side { background: var(--surface); padding: 30px; border-radius: 12px; border: 1px solid var(--border); }
        .order-summary-side { position: sticky; top: 100px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; }
        .form-group input, .form-group textarea, .form-group select { width: 100%; padding: 12px; background: var(--surface2); border: 1px solid var(--border); color: white; border-radius: 8px; }
        .order-item { display: flex; justify-content: space-between; padding: 8px 0; border-bottom: 1px dashed var(--border); }
        .submit-btn { background: var(--orange); color: white; padding: 14px; border: none; border-radius: 8px; cursor: pointer; width: 100%; font-size: 16px; font-weight: bold; }
        .submit-btn:hover { background: var(--orange-light); }
        .required { color: var(--red); }
        @media (max-width: 768px) { .checkout-container { grid-template-columns: 1fr; } }
    </style>
</head>
<body>

<nav id="navbar">
    <a href="${pageContext.request.contextPath}/HomeServlet" class="nav-logo">Mathado's <span>Queen of Kota</span></a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/HomeServlet">HOME</a></li>
        <li><a href="${pageContext.request.contextPath}/MenuServlet">MENU</a></li>
        <li><a href="${pageContext.request.contextPath}/pages/about.jsp">ABOUT US</a></li>
        <li><a href="${pageContext.request.contextPath}/pages/contact.jsp">CONTACT</a></li>
        <li><a href="${pageContext.request.contextPath}/pages/rate-us.jsp">RATE US</a></li>
    </ul>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/pages/cart.jsp" class="cart-btn"><i class="fas fa-shopping-bag"></i> CART <span class="cart-count">0</span></a>
        <div class="hamburger" onclick="toggleMenu()"><span></span><span></span><span></span></div>
    </div>
</nav>

<div class="checkout-container">
    <div class="checkout-form">
        <h1 class="section-title">CHECKOUT</h1>
        
        <form action="${pageContext.request.contextPath}/ProcessOrderServlet" method="post">
            <div class="form-group">
                <label>Full Name <span class="required">*</span></label>
                <input type="text" name="fullName" required placeholder="Enter your full name">
            </div>
            <div class="form-group">
                <label>Email <span class="required">*</span></label>
                <input type="email" name="email" required placeholder="your@email.com">
            </div>
            <div class="form-group">
                <label>Phone <span class="required">*</span></label>
                <input type="tel" name="phone" required placeholder="071 234 5678">
            </div>
            <div class="form-group">
                <label>Delivery Address <span class="required">*</span></label>
                <textarea name="address" rows="3" required placeholder="Street, City, Code"></textarea>
            </div>
            <div class="form-group">
                <label>Special Instructions</label>
                <textarea name="instructions" rows="2" placeholder="Any special requests?"></textarea>
            </div>
            <div class="form-group">
                <label>Payment Method</label>
                <select name="paymentMethod">
                    <option value="Cash">Cash</option>
                    <option value="Card">Card</option>
                </select>
            </div>
            
            <button type="submit" class="submit-btn">PLACE ORDER</button>
        </form>
    </div>
    
    <div class="order-summary-side">
        <h3>YOUR ORDER</h3>
        <div id="orderItemsList">
            <% if (cart != null) {
                for (CartItem item : cart) { %>
            <div class="order-item">
                <span><%= item.getQuantity() %>x <%= item.getProduct().getProductName() %></span>
                <span>R<%= String.format("%.2f", item.getSubtotal()) %></span>
            </div>
            <%      }
               } %>
        </div>
        <hr>
        <div id="orderTotals">
            <div class="order-item">
                <span>Subtotal:</span>
                <span>R<%= String.format("%.2f", subtotal) %></span>
            </div>
            <div class="order-item" style="font-weight:bold; font-size:18px;">
                <span>TOTAL TO PAY:</span>
                <span>R<%= String.format("%.2f", subtotal) %></span>
            </div>
        </div>
    </div>
</div>

<footer>
    <div class="footer-top">
        <div class="footer-brand"><div class="logo">Mathado's <span>Queen of Kota</span></div><p>Breyten's favourite online Kota & Bunny Chow platform.</p></div>
        <div class="footer-col"><h4>Quick Links</h4><ul><li><a href="${pageContext.request.contextPath}/HomeServlet">Home</a></li><li><a href="${pageContext.request.contextPath}/MenuServlet">Menu</a></li></ul></div>
        <div class="footer-col"><h4>Contact</h4><ul><li><i class="fas fa-map-marker-alt"></i> Breyten, Mpumalanga</li><li><i class="fas fa-phone"></i> 071 234 5678</li></ul></div>
    </div>
    <div class="footer-divider"></div>
    <div class="footer-bottom"><div class="copyright">&copy; 2025 Mathado's Queen of Kota. Serving Breyten, Mpumalanga.</div></div>
</footer>

<script>
function toggleMenu() {
    var links = document.querySelector('.nav-links');
    if (links.style.display === 'flex') {
        links.style.display = 'none';
    } else {
        links.style.display = 'flex';
        links.style.flexDirection = 'column';
        links.style.position = 'absolute';
        links.style.top = '68px';
        links.style.left = '0';
        links.style.right = '0';
        links.style.background = '#0d0d0d';
        links.style.padding = '20px 5vw';
        links.style.borderBottom = '1px solid rgba(255,255,255,0.07)';
    }
}

document.addEventListener('DOMContentLoaded', function() {
    window.addEventListener('scroll', function() {
        var nav = document.getElementById('navbar');
        if (nav) {
            nav.style.background = window.scrollY > 40 ? 'rgba(13,13,13,0.97)' : 'rgba(13,13,13,0.85)';
        }
    });
});

window.toggleMenu = toggleMenu;
</script>
</body>
</html>