<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact - Mathado's Queen of Kota</title>
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
        <li><a href="${pageContext.request.contextPath}/pages/contact.jsp" class="active">CONTACT</a></li>
        <li><a href="${pageContext.request.contextPath}/pages/rate-us.jsp">RATE US</a></li>
    </ul>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/pages/cart.jsp" class="cart-btn"><i class="fas fa-shopping-bag"></i> CART <span class="cart-count">0</span></a>
        <div class="hamburger" onclick="toggleMenu()"><span></span><span></span><span></span></div>
    </div>
</nav>

<div class="contact-container">
    <div class="contact-info">
        <h2 class="section-title">GET IN TOUCH</h2>
        <p>Have a complaint, question, or feedback? We'd love to hear from you!</p>
        <div class="contact-info-item">
            <i class="fas fa-map-marker-alt"></i>
            <div><strong>Visit Us</strong><br>Breyten, Mpumalanga Province</div>
        </div>
        <div class="contact-info-item">
            <i class="fas fa-phone"></i>
            <div><strong>Call Us</strong><br>071 234 5678</div>
        </div>
        <div class="contact-info-item">
            <i class="fas fa-envelope"></i>
            <div><strong>Email Us</strong><br>queen@mathadoskota.co.za</div>
        </div>
        <div class="contact-info-item">
            <i class="fas fa-clock"></i>
            <div><strong>Hours</strong><br>Mon-Sun: 10am - 10pm</div>
        </div>
    </div>
    
    <div class="contact-form">
        <h2 class="section-title">SEND US A MESSAGE</h2>
        <form action="${pageContext.request.contextPath}/ContactServlet" method="post">
            <div class="form-group">
                <input type="text" name="name" placeholder="Your Name" required>
            </div>
            <div class="form-group">
                <input type="email" name="email" placeholder="Your Email" required>
            </div>
            <div class="form-group">
                <input type="tel" name="phone" placeholder="Phone Number">
            </div>
            <div class="form-group">
                <select name="messageType">
                    <option value="inquiry">General Inquiry</option>
                    <option value="complaint">Complaint</option>
                    <option value="feedback">Feedback</option>
                </select>
            </div>
            <div class="form-group">
                <input type="text" name="subject" placeholder="Subject" required>
            </div>
            <div class="form-group">
                <textarea name="message" rows="5" placeholder="Your Message" required></textarea>
            </div>
            <button type="submit" class="submit-btn">SEND MESSAGE</button>
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
</body>
</html>