<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="za.ac.tut.kotashop.dao.ProductDAO" %>
<%@ page import="za.ac.tut.kotashop.model.Category" %>
<%@ page import="za.ac.tut.kotashop.model.Product" %>
<%@ page import="java.util.List" %>
<%
    ProductDAO productDAO = new ProductDAO();
    List<Category> categories = productDAO.getAllCategories();
    List<Product> allProducts = productDAO.getAllProducts();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu - Mathado's Queen of Kota</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Barlow+Condensed:wght@400;600;700&family=Barlow:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .menu-container { max-width: 1200px; margin: 100px auto 60px; padding: 0 20px; }
        .menu-hero { text-align: center; margin-bottom: 40px; }
        .menu-hero h1 { font-family: var(--font-display); font-size: 60px; color: var(--orange); letter-spacing: 2px; }
        .category-tabs { display: flex; gap: 10px; flex-wrap: wrap; justify-content: center; margin-bottom: 40px; }
        .tab-btn { font-family: var(--font-head); font-size: 14px; font-weight: 700; padding: 8px 20px; border-radius: 4px; cursor: pointer; border: 1px solid var(--border); background: transparent; color: var(--muted); transition: all .2s; }
        .tab-btn.active, .tab-btn:hover { background: var(--orange); border-color: var(--orange); color: #fff; }
        .menu-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 30px; }
        .menu-card { background: var(--surface); border: 1px solid var(--border); border-radius: 12px; overflow: hidden; transition: all .3s; }
        .menu-card:hover { transform: translateY(-5px); border-color: var(--orange); box-shadow: 0 10px 30px rgba(0,0,0,0.3); }
        .card-img-wrap { position: relative; height: 200px; overflow: hidden; background: #1a1a1a; display: flex; align-items: center; justify-content: center; }
        .card-img-wrap img { width: 100%; height: 100%; object-fit: cover; transition: transform .4s; }
        .menu-card:hover .card-img-wrap img { transform: scale(1.05); }
        .card-badge { position: absolute; top: 12px; left: 12px; background: var(--orange); color: #fff; font-family: var(--font-head); font-size: 11px; font-weight: 700; padding: 4px 12px; border-radius: 20px; text-transform: uppercase; }
        .card-body { padding: 18px; }
        .card-name { font-family: var(--font-head); font-size: 18px; font-weight: 700; margin-bottom: 8px; }
        .card-desc { font-size: 12px; color: var(--muted); line-height: 1.5; margin-bottom: 15px; }
        .card-footer { display: flex; align-items: center; justify-content: space-between; }
        .card-price { font-family: var(--font-display); font-size: 24px; color: var(--orange); }
        .qty-selector { display: flex; align-items: center; gap: 8px; background: var(--surface2); border-radius: 8px; padding: 5px; }
        .qty-btn { background: var(--orange); border: none; color: white; width: 28px; height: 28px; border-radius: 6px; cursor: pointer; font-size: 16px; font-weight: bold; transition: all .2s; }
        .qty-btn:hover { background: var(--orange-light); }
        .qty-value { font-size: 14px; font-weight: bold; min-width: 25px; text-align: center; }
        .add-btn { background: var(--orange-dim); border: 1px solid var(--orange); color: var(--orange); padding: 6px 16px; border-radius: 6px; font-family: var(--font-head); font-size: 12px; font-weight: 700; cursor: pointer; transition: all .2s; }
        .add-btn:hover { background: var(--orange); color: #fff; }
        .toast { position: fixed; bottom: 28px; right: 28px; z-index: 9999; background: var(--surface); border: 1px solid var(--orange); border-radius: 8px; padding: 14px 20px; font-family: var(--font-head); font-size: 15px; font-weight: 700; color: var(--white); display: flex; align-items: center; gap: 10px; transform: translateY(80px); opacity: 0; transition: transform .35s, opacity .3s; pointer-events: none; }
        .toast.show { transform: translateY(0); opacity: 1; }
        .toast i { color: var(--orange); }
        footer { margin-top: 60px; }
        @media (max-width: 768px) { .menu-grid { grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); } }
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
        <a href="${pageContext.request.contextPath}/pages/cart.jsp" class="cart-btn">
            <i class="fas fa-shopping-bag"></i> CART
            <span class="cart-count">0</span>
        </a>
        <div class="hamburger" onclick="toggleMenu()">
            <span></span><span></span><span></span>
        </div>
    </div>
</nav>

<div class="menu-container">
    <div class="menu-hero">
        <h1>THE QUEEN'S MENU</h1>
        <p>Explore Mathado's authentic South African street food selection</p>
    </div>

    <div class="category-tabs">
        <button class="tab-btn active" onclick="filterMenu('all', this)">ALL ITEMS</button>
        <% for (Category category : categories) { %>
        <button class="tab-btn" onclick="filterMenu('<%= category.getCategoryId() %>', this)"><%= category.getCategoryName().toUpperCase() %></button>
        <% } %>
    </div>

    <div class="menu-grid" id="menuGrid">
        <% for (Product product : allProducts) { 
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
                else if (name.indexOf("coca-cola") >= 0 || name.indexOf("coke") >= 0) imageName = "coke.jpg";
                else if (name.indexOf("sprite") >= 0) imageName = "sprite.jpg";
                else if (name.indexOf("fanta") >= 0) imageName = "fanta.jpg";
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
                        <button class="qty-btn" onclick="changeQty(this, -1)">-</button>
                        <span class="qty-value">1</span>
                        <button class="qty-btn" onclick="changeQty(this, 1)">+</button>
                        <button class="add-btn" onclick="addToCart(<%= product.getProductId() %>, '<%= product.getProductName() %>', <%= product.getPrice() %>)">ADD</button>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
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
                <li><a href="${pageContext.request.contextPath}/pages/contact.jsp">Contact</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h4>CONTACT</h4>
            <ul>
                <li><i class="fas fa-phone"></i> 071 234 5678</li>
                <li><i class="fas fa-envelope"></i> queen@mathadoskota.co.za</li>
                <li><i class="fas fa-map-marker-alt"></i> Breyten, Mpumalanga</li>
            </ul>
        </div>
    </div>
    <div class="footer-divider"></div>
    <div class="footer-bottom">
        <div class="copyright">&copy; 2025 Mathado's Queen of Kota. All rights reserved. Serving Breyten, Mpumalanga.</div>
    </div>
</footer>

<div id="toast" class="toast">
    <i class="fas fa-check-circle"></i>
    <span id="toastMsg"></span>
</div>

<script>
// Update cart count from localStorage
function updateCartCount() {
    let cart = JSON.parse(localStorage.getItem('mathadosCart') || '[]');
    let total = 0;
    for (let i = 0; i < cart.length; i++) {
        total += cart[i].quantity;
    }
    let cartCountElements = document.querySelectorAll('.cart-count');
    for (let i = 0; i < cartCountElements.length; i++) {
        cartCountElements[i].textContent = total;
    }
}

// Show toast notification
function showToast(message) {
    let toast = document.getElementById('toast');
    let toastMsg = document.getElementById('toastMsg');
    if (toastMsg) toastMsg.textContent = message;
    toast.classList.add('show');
    setTimeout(function() {
        toast.classList.remove('show');
    }, 2500);
}

// Add to cart function
function addToCart(productId, productName, price) {
    // Get quantity from the parent card
    let btn = event.target;
    let card = btn.closest('.menu-card');
    let qtyElement = card.querySelector('.qty-value');
    let quantity = parseInt(qtyElement.textContent);
    
    // Get current cart
    let cart = JSON.parse(localStorage.getItem('mathadosCart') || '[]');
    
    // Check if item exists
    let existing = null;
    for (let i = 0; i < cart.length; i++) {
        if (cart[i].id == productId) {
            existing = cart[i];
            break;
        }
    }
    
    if (existing) {
        existing.quantity += quantity;
    } else {
        cart.push({
            id: productId,
            name: productName,
            price: price,
            quantity: quantity
        });
    }
    
    // Save to localStorage
    localStorage.setItem('mathadosCart', JSON.stringify(cart));
    
    // Reset quantity to 1
    qtyElement.textContent = '1';
    
    // Update cart count
    updateCartCount();
    
    // Show notification
    showToast(quantity + ' x ' + productName + ' added to cart!');
}

// Change quantity in product card
function changeQty(btn, delta) {
    let card = btn.closest('.menu-card');
    let qtyElement = card.querySelector('.qty-value');
    let currentQty = parseInt(qtyElement.textContent);
    let newQty = currentQty + delta;
    if (newQty < 1) newQty = 1;
    qtyElement.textContent = newQty;
}

// Filter menu by category
function filterMenu(category, element) {
    let buttons = document.querySelectorAll('.tab-btn');
    for (let i = 0; i < buttons.length; i++) {
        buttons[i].classList.remove('active');
    }
    element.classList.add('active');
    
    let cards = document.querySelectorAll('.menu-card');
    for (let i = 0; i < cards.length; i++) {
        let card = cards[i];
        if (category === 'all' || card.getAttribute('data-category') == category) {
            card.style.display = '';
        } else {
            card.style.display = 'none';
        }
    }
}

// Toggle mobile menu
function toggleMenu() {
    let links = document.querySelector('.nav-links');
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

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    updateCartCount();
    
    // Scroll effect for navbar
    window.addEventListener('scroll', function() {
        let nav = document.getElementById('navbar');
        if (nav) {
            nav.style.background = window.scrollY > 40 ? 'rgba(13,13,13,0.97)' : 'rgba(13,13,13,0.85)';
        }
    });
});

// Make functions global
window.addToCart = addToCart;
window.changeQty = changeQty;
window.filterMenu = filterMenu;
window.toggleMenu = toggleMenu;
window.updateCartCount = updateCartCount;
</script>
</body>
</html>