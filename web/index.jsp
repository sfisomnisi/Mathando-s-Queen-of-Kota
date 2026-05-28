<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="za.ac.tut.kotashop.dao.ProductDAO" %>
<%@ page import="za.ac.tut.kotashop.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    ProductDAO productDAO = new ProductDAO();
    List<Product> allProducts = productDAO.getAllProducts();
    List<Product> featuredProducts = new ArrayList<Product>();
    for (Product p : allProducts) {
        if (p.isFeatured() && featuredProducts.size() < 8) {
            featuredProducts.add(p);
        }
    }
    if (featuredProducts.size() < 8) {
        for (Product p : allProducts) {
            if (!featuredProducts.contains(p) && featuredProducts.size() < 8) {
                featuredProducts.add(p);
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mathado's Queen of Kota - Authentic SA Street Food</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Barlow+Condensed:wght@400;600;700&family=Barlow:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<nav id="navbar">
    <a href="${pageContext.request.contextPath}/HomeServlet" class="nav-logo">Mathado's <span>Queen of Kota</span></a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/HomeServlet" class="active">HOME</a></li>
        <li><a href="${pageContext.request.contextPath}/MenuServlet">MENU</a></li>
        <li><a href="${pageContext.request.contextPath}/pages/about.jsp">ABOUT US</a></li>
        <li><a href="${pageContext.request.contextPath}/pages/contact.jsp">CONTACT</a></li>
        <li><a href="${pageContext.request.contextPath}/pages/rate-us.jsp">RATE US</a></li>
    </ul>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/pages/cart.jsp" class="cart-btn">
            <i class="fas fa-shopping-bag"></i> CART
            <span class="cart-count">0</span>
        </a>
        <div class="hamburger" onclick="toggleMenu()">
            <span></span><span></span><span></span>
        </div>
    </div>
</nav>

<!-- Location Banner -->
<div class="location-banner">
    <i class="fas fa-map-marker-alt"></i> Serving: <span>Breyten, Mpumalanga Province</span> | Free delivery on orders over R150!
</div>

<section class="hero">
    <div class="hero-bg"></div>
    <img class="hero-img" src="${pageContext.request.contextPath}/images/hero-kota.jpg" alt="Delicious Kota and Bunny Chow">
    <div class="hero-content">
        <div class="hero-tag"><i class="fas fa-fire"></i> Authentic SA Street Food</div>
        <h1 class="hero-title">
            <span class="line1">THE</span><br/>
            <span class="line2">REAL</span><br/>
            <span class="line3">KOTA</span>
        </h1>
        <p class="hero-desc">
            Authentic South African street food — loaded Kotas, Bunny Chow & more, 
            delivered hot to your door in Breyten, Mpumalanga. Straight from the corner to your crib.
        </p>
        <div class="hero-actions">
            <a href="${pageContext.request.contextPath}/MenuServlet" class="btn-primary"><i class="fas fa-utensils"></i> Order Now</a>
            <a href="${pageContext.request.contextPath}/pages/about.jsp" class="btn-outline"><i class="fas fa-play"></i> Our Story</a>
        </div>
        <div class="hero-stats">
            <div>
                <div class="stat-num">500+</div>
                <div class="stat-label">Happy Customers</div>
            </div>
            <div>
                <div class="stat-num">4.9</div>
                <div class="stat-label">Customer Rating</div>
            </div>
            <div>
                <div class="stat-num">30min</div>
                <div class="stat-label">Avg Delivery</div>
            </div>
        </div>
    </div>
</section>

<div class="ticker">
    <div class="ticker-inner">
        <span class="ticker-item">🔥 Full House Kota</span><span class="ticker-sep">✦</span>
        <span class="ticker-item">🍛 Bunny Chow</span><span class="ticker-sep">✦</span>
        <span class="ticker-item">🌭 Russian & Chips</span><span class="ticker-sep">✦</span>
        <span class="ticker-item">🧀 Cheese Kota</span><span class="ticker-sep">✦</span>
        <span class="ticker-item">🍗 Mutton Bunny</span><span class="ticker-sep">✦</span>
        <span class="ticker-item">🍔 Combo Deals</span><span class="ticker-sep">✦</span>
        <span class="ticker-item">🚚 Free Delivery Over R150</span><span class="ticker-sep">✦</span>
    </div>
</div>

<section id="featured">
    <div class="section-header">
        <div class="section-label">Featured Items</div>
        <h2 class="section-title">CUSTOMER FAVOURITES</h2>
        <p class="section-sub">Our most loved dishes, made fresh daily in Breyten</p>
    </div>
    <div class="menu-grid">
        <% for (Product product : featuredProducts) { 
            String imageName = product.getImageName();
            if (imageName == null || imageName.isEmpty()) {
                String name = product.getProductName().toLowerCase();
                if (name.indexOf("small kota") >= 0) imageName = "small-kota.jpg";
                else if (name.indexOf("russian kota") >= 0) imageName = "russian-kota.jpg";
                else if (name.indexOf("full house") >= 0) imageName = "full-house-kota.jpg";
                else if (name.indexOf("cheese kota") >= 0) imageName = "cheese-kota.jpg";
                else if (name.indexOf("chicken bunny") >= 0) imageName = "chicken-bunny.jpg";
                else if (name.indexOf("mutton bunny") >= 0) imageName = "mutton-bunny.jpg";
                else if (name.indexOf("beef bunny") >= 0) imageName = "beef-bunny.jpg";
                else imageName = "hero-kota.jpg";
            }
        %>
        <div class="menu-card" data-category="<%= product.getCategoryId() %>">
            <div class="card-img-wrap">
                <img src="${pageContext.request.contextPath}/images/<%= imageName %>" 
                     alt="<%= product.getProductName() %>"
                     onerror="this.src='https://placehold.co/300x200/FF5A00/white?text=<%= java.net.URLEncoder.encode(product.getProductName(), "UTF-8") %>'">
                <span class="card-badge"><%= product.getCategoryName() %></span>
            </div>
            <div class="card-body">
                <div class="card-name"><%= product.getProductName() %></div>
                <div class="card-desc"><%= product.getDescription() %></div>
                <div class="card-footer">
                    <span class="card-price">R<%= String.format("%.2f", product.getPrice()) %></span>
                    <div class="qty-selector">
                        <button class="qty-btn" onclick="changeQuantity(this, -1)">-</button>
                        <span class="qty-value">1</span>
                        <button class="qty-btn" onclick="changeQuantity(this, 1)">+</button>
                        <button class="add-with-qty" onclick="addWithQuantity(this, <%= product.getProductId() %>, '<%= product.getProductName() %>', <%= product.getPrice() %>)">
                            ADD
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</section>

<section id="about">
    <div class="section-header">
        <div class="section-label">Why Choose Us</div>
        <h2 class="section-title">REAL FOOD.<br/>REAL FAST.</h2>
    </div>
    <div class="features-grid">
        <div class="feature-card">
            <div class="feature-icon"><i class="fas fa-fire-flame-curved"></i></div>
            <div class="feature-title">Made Fresh Daily</div>
            <div class="feature-desc">Every kota and bunny chow is made to order in Breyten — no reheated nonsense.</div>
        </div>
        <div class="feature-card">
            <div class="feature-icon"><i class="fas fa-motorcycle"></i></div>
            <div class="feature-title">Fast Delivery</div>
            <div class="feature-desc">Average 30-minute delivery within Breyten and surrounding areas.</div>
        </div>
        <div class="feature-card">
            <div class="feature-icon"><i class="fas fa-wallet"></i></div>
            <div class="feature-title">Pay Your Way</div>
            <div class="feature-desc">Cash, card, EFT — whatever works for you. Easy checkout, no stress.</div>
        </div>
        <div class="feature-card">
            <div class="feature-icon"><i class="fas fa-heart"></i></div>
            <div class="feature-title">Authentic Recipe</div>
            <div class="feature-desc">Original recipes passed down through generations. Real SA flavours only.</div>
        </div>
    </div>
</section>

<footer>
    <div class="footer-top">
        <div class="footer-brand">
            <div class="logo">Mathado's <span>Queen of Kota</span></div>
            <p>Breyten's favourite online Kota & Bunny Chow ordering platform. Hot food, fast delivery.</p>
            <div class="social-row">
                <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                <a href="#" class="social-icon"><i class="fab fa-whatsapp"></i></a>
            </div>
        </div>
        <div class="footer-col">
            <h4>Quick Links</h4>
            <ul>
                <li><a href="${pageContext.request.contextPath}/HomeServlet">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/MenuServlet">Menu</a></li>
                <li><a href="${pageContext.request.contextPath}/pages/about.jsp">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/pages/contact.jsp">Contact</a></li>
                <li><a href="${pageContext.request.contextPath}/pages/rate-us.jsp">Rate Us</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h4>Contact Info</h4>
            <ul>
                <li><i class="fas fa-map-marker-alt"></i> Breyten, Mpumalanga</li>
                <li><i class="fas fa-phone"></i> 071 234 5678</li>
                <li><i class="fas fa-envelope"></i> queen@mathadoskota.co.za</li>
            </ul>
        </div>
        <div class="footer-col">
            <h4>Opening Hours</h4>
            <ul>
                <li>Monday - Sunday</li>
                <li>10:00 AM - 10:00 PM</li>
                <li>Delivery: 11:00 AM - 9:30 PM</li>
            </ul>
        </div>
    </div>
    <div class="footer-divider"></div>
    <div class="footer-bottom">
        <div class="copyright">&copy; 2025 Mathado's Queen of Kota. All rights reserved. Serving Breyten, Mpumalanga.</div>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>