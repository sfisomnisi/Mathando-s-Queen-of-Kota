<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="za.ac.tut.kotashop.dao.ProductDAO" %>
<%@ page import="za.ac.tut.kotashop.model.Product" %>
<%@ page import="java.util.List" %>
<%
    ProductDAO productDAO = new ProductDAO();
    List<Product> products = productDAO.getAllProducts();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rate Us - Mathado's Queen of Kota</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Barlow+Condensed:wght@400;600;700&family=Barlow:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<nav id="navbar">
    <a href="${pageContext.request.contextPath}/HomeServlet" class="nav-logo">Mathado's <span>Queen of Kota</span></a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/HomeServlet">HOME</a></li>
        <li><a href="${pageContext.request.contextPath}/MenuServlet">MENU</a></li>
        <li><a href="${pageContext.request.contextPath}/pages/about.jsp">ABOUT US</a></li>
        <li><a href="${pageContext.request.contextPath}/pages/contact.jsp">CONTACT</a></li>
        <li><a href="${pageContext.request.contextPath}/pages/rate-us.jsp" class="active">RATE US</a></li>
    </ul>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/pages/cart.jsp" class="cart-btn"><i class="fas fa-shopping-bag"></i> CART <span class="cart-count">0</span></a>
        <div class="hamburger" onclick="toggleMenu()"><span></span><span></span><span></span></div>
    </div>
</nav>

<div class="rating-container">
    <div class="rating-form">
        <h1 class="section-title">RATE OUR SERVICE</h1>
        <p class="rating-subtitle">Your feedback helps us improve and serve Breyten better!</p>
        
        <form action="${pageContext.request.contextPath}/RatingServlet" method="post" class="rating-form-element">
            <div class="form-group">
                <label>Select Product / Service</label>
                <select name="productId" class="rating-select">
                    <option value="">★ Rate Overall Service</option>
                    <% for (Product p : products) { %>
                    <option value="<%= p.getProductId() %>">★ <%= p.getProductName() %></option>
                    <% } %>
                </select>
            </div>
            
            <div class="form-group">
                <label>Your Name</label>
                <input type="text" name="customerName" class="rating-input" placeholder="Enter your name" required>
            </div>
            
            <div class="form-group">
                <label>Your Email</label>
                <input type="email" name="customerEmail" class="rating-input" placeholder="Enter your email" required>
            </div>
            
            <div class="star-rating">
                <i class="far fa-star" data-value="1"></i>
                <i class="far fa-star" data-value="2"></i>
                <i class="far fa-star" data-value="3"></i>
                <i class="far fa-star" data-value="4"></i>
                <i class="far fa-star" data-value="5"></i>
            </div>
            <input type="hidden" name="ratingValue" id="ratingValue" required>
            
            <div class="form-group">
                <label>Your Review (Optional)</label>
                <textarea name="reviewText" class="rating-textarea" placeholder="Tell us about your experience..."></textarea>
            </div>
            
            <button type="submit" class="rating-submit-btn">SUBMIT RATING</button>
        </form>
    </div>
</div>

<footer>
    <div class="footer-top">
        <div class="footer-brand">
            <div class="logo">Mathado's <span>Queen of Kota</span></div>
            <p>Breyten's favourite online Kota & Bunny Chow ordering platform.</p>
        </div>
        <div class="footer-col">
            <h4>Quick Links</h4>
            <ul>
                <li><a href="${pageContext.request.contextPath}/HomeServlet">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/MenuServlet">Menu</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h4>Contact</h4>
            <ul>
                <li><i class="fas fa-map-marker-alt"></i> Breyten, Mpumalanga</li>
                <li><i class="fas fa-phone"></i> 071 234 5678</li>
            </ul>
        </div>
    </div>
    <div class="footer-divider"></div>
    <div class="footer-bottom">
        <div class="copyright">&copy; 2025 Mathado's Queen of Kota. Serving Breyten, Mpumalanga.</div>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/js/script.js"></script>
<script>
document.querySelectorAll('.star-rating i').forEach(star => {
    star.addEventListener('click', function() {
        let val = parseInt(this.getAttribute('data-value'));
        document.getElementById('ratingValue').value = val;
        
        document.querySelectorAll('.star-rating i').forEach(s => {
            s.classList.remove('active', 'fas');
            s.classList.add('far');
        });
        
        for (let i = 0; i < val; i++) {
            let stars = document.querySelectorAll('.star-rating i');
            stars[i].classList.add('active', 'fas');
            stars[i].classList.remove('far');
        }
    });
    
    star.addEventListener('mouseenter', function() {
        let val = parseInt(this.getAttribute('data-value'));
        document.querySelectorAll('.star-rating i').forEach((s, index) => {
            if (index < val) {
                s.classList.add('fas');
                s.classList.remove('far');
            } else {
                s.classList.add('far');
                s.classList.remove('fas');
            }
        });
    });
    
    star.addEventListener('mouseleave', function() {
        let currentVal = parseInt(document.getElementById('ratingValue').value) || 0;
        document.querySelectorAll('.star-rating i').forEach((s, index) => {
            if (index < currentVal) {
                s.classList.add('fas', 'active');
                s.classList.remove('far');
            } else {
                s.classList.add('far');
                s.classList.remove('fas', 'active');
            }
        });
    });
});
</script>
</body>
</html>