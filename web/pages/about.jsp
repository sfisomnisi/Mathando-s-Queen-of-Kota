<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Mathado's Queen of Kota</title>
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
        <li><a href="${pageContext.request.contextPath}/pages/about.jsp" class="active">ABOUT US</a></li>
        <li><a href="${pageContext.request.contextPath}/pages/contact.jsp">CONTACT</a></li>
        <li><a href="${pageContext.request.contextPath}/pages/rate-us.jsp">RATE US</a></li>
    </ul>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/pages/cart.jsp" class="cart-btn"><i class="fas fa-shopping-bag"></i> CART <span class="cart-count">0</span></a>
        <div class="hamburger" onclick="toggleMenu()"><span></span><span></span><span></span></div>
    </div>
</nav>

<div class="about-container">
    <div class="about-hero">
        <h1 class="section-title">OUR STORY</h1>
        <p>Bringing authentic South African street food to Breyten, Mpumalanga</p>
    </div>
    <div class="about-content">
        <div>
            <h2 style="color: var(--orange); margin-bottom: 20px;">From the Townships to Breyten</h2>
            <p style="line-height: 1.8; color: var(--muted);">Mathado's Queen of Kota was born from a passion for authentic South African street food. What started as a small kitchen has grown into a beloved delivery service serving hundreds of happy customers daily in Breyten and surrounding Mpumalanga areas.</p>
            <p style="line-height: 1.8; color: var(--muted); margin-top: 15px;">Our recipes are passed down through generations, and every Kota and Bunny Chow is made with love, using only the freshest ingredients. We take pride in serving our community with the best street food experience.</p>
        </div>
        <div class="about-image">
            <img src="${pageContext.request.contextPath}/images/hero-kota.jpg" alt="Our Kitchen">
        </div>
    </div>
    <div class="mission-section">
        <i class="fas fa-quote-left" style="font-size: 40px; color: var(--orange); opacity: 0.5; margin-bottom: 20px; display: block;"></i>
        <p style="font-size: 18px; line-height: 1.8;">"To serve the most delicious, authentic South African street food while providing fast, reliable delivery and exceptional customer service to Breyten and Mpumalanga."</p>
        <p style="margin-top: 20px; color: var(--orange);">— Mathado's Queen of Kota Team</p>
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