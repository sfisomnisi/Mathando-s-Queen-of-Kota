<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart - Mathado's Queen of Kota</title>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Barlow+Condensed:wght@400;600;700&family=Barlow:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .cart-container { max-width: 1000px; margin: 100px auto 60px; padding: 0 20px; min-height: 400px; }
        .cart-table { width: 100%; border-collapse: collapse; background: var(--surface); border-radius: 12px; overflow: hidden; }
        .cart-table th, .cart-table td { padding: 15px; text-align: left; border-bottom: 1px solid var(--border); }
        .cart-table th { color: var(--orange); font-family: var(--font-head); }
        .cart-item-img { width: 60px; height: 60px; object-fit: cover; border-radius: 8px; background: #1a1a1a; }
        .qty-cell { display: flex; align-items: center; gap: 10px; }
        .qty-btn { background: var(--orange); border: none; color: white; width: 28px; height: 28px; border-radius: 6px; cursor: pointer; font-size: 16px; font-weight: bold; }
        .qty-btn:hover { background: var(--orange-light); }
        .remove-btn { background: rgba(231,76,60,0.2); border: 1px solid var(--red); color: var(--red); padding: 6px 12px; border-radius: 6px; cursor: pointer; }
        .remove-btn:hover { background: var(--red); color: white; }
        .cart-summary { background: var(--surface); padding: 25px; border-radius: 12px; margin-top: 30px; display: flex; justify-content: space-between; flex-wrap: wrap; align-items: center; }
        .checkout-btn { background: var(--orange); color: white; padding: 12px 30px; border: none; border-radius: 8px; cursor: pointer; font-weight: bold; font-size: 16px; }
        .checkout-btn:hover { background: var(--orange-light); transform: translateY(-2px); }
        .clear-btn { background: rgba(231,76,60,0.2); border: 1px solid var(--red); color: var(--red); padding: 10px 20px; border-radius: 8px; cursor: pointer; font-weight: bold; }
        .clear-btn:hover { background: var(--red); color: white; }
        .empty-cart { text-align: center; padding: 60px; background: var(--surface); border-radius: 12px; }
        .empty-cart i { font-size: 64px; color: var(--muted); margin-bottom: 20px; }
        .btn-continue { background: var(--orange); color: white; padding: 12px 30px; display: inline-block; margin-top: 20px; text-decoration: none; border-radius: 8px; font-weight: bold; }
        .toast { position: fixed; bottom: 28px; right: 28px; z-index: 9999; background: var(--surface); border: 1px solid var(--orange); border-radius: 8px; padding: 14px 20px; font-family: var(--font-head); font-size: 15px; font-weight: 700; color: var(--white); display: flex; align-items: center; gap: 10px; transform: translateY(80px); opacity: 0; transition: transform .35s, opacity .3s; pointer-events: none; }
        .toast.show { transform: translateY(0); opacity: 1; }
        .toast i { color: var(--orange); }
        @media (max-width: 768px) {
            .cart-table th, .cart-table td { padding: 8px; font-size: 12px; }
            .cart-item-img { width: 40px; height: 40px; }
            .cart-summary { flex-direction: column; gap: 15px; text-align: center; }
        }
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

<div class="cart-container">
    <h1 class="section-title">YOUR CART</h1>
    <div id="cartContent"></div>
</div>

<footer>
    <div class="footer-top">
        <div class="footer-brand">
            <div class="logo">Mathado's <span>Queen of Kota</span></div>
            <p>Breyten's favourite online Kota & Bunny Chow platform.</p>
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

<div id="toast" class="toast">
    <i class="fas fa-check-circle"></i>
    <span id="toastMsg"></span>
</div>

<script>
function getCart() { 
    var s = localStorage.getItem('mathadosCart'); 
    if (s) {
        try { return JSON.parse(s); } catch(e) { return []; }
    }
    return []; 
}

function saveCart(c) { 
    localStorage.setItem('mathadosCart', JSON.stringify(c)); 
    displayCart(); 
}

function updateCartCount(cart) { 
    var total = 0;
    for (var i = 0; i < cart.length; i++) {
        total += cart[i].quantity;
    }
    var cartCountElements = document.querySelectorAll('.cart-count');
    for (var i = 0; i < cartCountElements.length; i++) {
        cartCountElements[i].textContent = total;
    }
}

function showToast(message) {
    var toast = document.getElementById('toast');
    var toastMsg = document.getElementById('toastMsg');
    toastMsg.textContent = message;
    toast.classList.add('show');
    setTimeout(function() {
        toast.classList.remove('show');
    }, 2500);
}

function displayCart() {
    var cart = getCart();
    var container = document.getElementById('cartContent');
    
    if (!cart || cart.length === 0) { 
        container.innerHTML = '<div class="empty-cart">' +
            '<i class="fas fa-shopping-cart"></i>' +
            '<h2>Your cart is empty</h2>' +
            '<a href="${pageContext.request.contextPath}/MenuServlet" class="btn-continue">BROWSE MENU</a>' +
            '</div>'; 
        updateCartCount(cart); 
        return; 
    }
    
    var subtotal = 0;
    var html = '<table class="cart-table"><thead><tr><th>Product</th><th>Name</th><th>Price</th><th>Quantity</th><th>Subtotal</th><th></th><tr></thead><tbody>';
    
    for(var i = 0; i < cart.length; i++) {
        var item = cart[i];
        var itemSubtotal = item.price * item.quantity;
        subtotal += itemSubtotal;
        
        var img = 'hero-kota.jpg';
        var itemName = item.name.toLowerCase();
        if(itemName.indexOf('full house') >= 0) img = 'full-house-kota.jpg';
        else if(itemName.indexOf('russian') >= 0) img = 'russian-kota.jpg';
        else if(itemName.indexOf('small') >= 0) img = 'small-kota.jpg';
        else if(itemName.indexOf('cheese') >= 0) img = 'cheese-kota.jpg';
        else if(itemName.indexOf('chicken') >= 0) img = 'chicken-bunny.jpg';
        else if(itemName.indexOf('mutton') >= 0) img = 'mutton-bunny.jpg';
        else if(itemName.indexOf('beef') >= 0) img = 'beef-bunny.jpg';
        else if(itemName.indexOf('coca') >= 0) img = 'coke.jpg';
        else if(itemName.indexOf('sprite') >= 0) img = 'sprite.jpg';
        else if(itemName.indexOf('fanta') >= 0) img = 'fanta.jpg';
        else if(itemName.indexOf('apple') >= 0) img = 'apple-juice.jpg';
        else if(itemName.indexOf('water') >= 0) img = 'water.jpg';
        
        html += '<tr>' +
            '<td><img src="${pageContext.request.contextPath}/images/' + img + '" class="cart-item-img" onerror="this.style.display=\'none\'"></td>' +
            '<td><strong>' + escapeHtml(item.name) + '</strong></td>' +
            '<td>R' + item.price.toFixed(2) + '</td>' +
            '<td><div class="qty-cell"><button class="qty-btn" onclick="updateQuantity(' + i + ', -1)">-</button><span id="qty-' + i + '">' + item.quantity + '</span><button class="qty-btn" onclick="updateQuantity(' + i + ', 1)">+</button></div></td>' +
            '<td>R' + itemSubtotal.toFixed(2) + '</td>' +
            '<td><button class="remove-btn" onclick="removeItem(' + i + ')"><i class="fas fa-trash"></i> Remove</button></td>' +
            '</tr>';
    }
    
    var total = subtotal;
    
    html += '</tbody></table>' +
        '<div class="cart-summary">' +
        '<div><button class="clear-btn" onclick="clearAllCart()">CLEAR CART</button></div>' +
        '<div><p>Subtotal: <strong>R' + subtotal.toFixed(2) + '</strong></p>' +
        '<h2 style="color: var(--orange);">Total: R' + total.toFixed(2) + '</h2>' +
        '<button class="checkout-btn" onclick="goToCheckout()">PROCEED TO CHECKOUT</button></div>' +
        '</div>';
    
    container.innerHTML = html; 
    updateCartCount(cart);
}

function escapeHtml(text) {
    if (!text) return '';
    return text.replace(/[&<>]/g, function(m) {
        if (m === '&') return '&amp;';
        if (m === '<') return '&lt;';
        if (m === '>') return '&gt;';
        return m;
    });
}

function updateQuantity(index, delta) { 
    var cart = getCart(); 
    var newQty = cart[index].quantity + delta; 
    if(newQty >= 1) { 
        cart[index].quantity = newQty; 
        saveCart(cart); 
        showToast(cart[index].name + " quantity updated to " + newQty);
    } 
}

function removeItem(index) { 
    var cart = getCart(); 
    var itemName = cart[index].name;
    if(confirm('Remove ' + itemName + ' from cart?')) { 
        cart.splice(index, 1); 
        saveCart(cart); 
        showToast(itemName + " removed from cart");
    } 
}

function clearAllCart() { 
    if(confirm('Clear entire cart?')){ 
        localStorage.removeItem('mathadosCart');
        displayCart(); 
        showToast("Cart cleared");
    } 
}

function saveCartToSession(cart, callback) {
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '${pageContext.request.contextPath}/SaveCartToSessionServlet', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            if (callback) callback();
        }
    };
    xhr.send('cartData=' + encodeURIComponent(JSON.stringify(cart)));
}

function goToCheckout() { 
    var cart = getCart(); 
    if(cart.length > 0){ 
        sessionStorage.setItem('checkoutCart', JSON.stringify(cart));
        saveCartToSession(cart, function() {
            window.location.href = '${pageContext.request.contextPath}/pages/checkout.jsp';
        });
    } else {
        showToast("Your cart is empty");
    } 
}

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
    displayCart();
    window.addEventListener('scroll', function() {
        var nav = document.getElementById('navbar');
        if (nav) {
            nav.style.background = window.scrollY > 40 ? 'rgba(13,13,13,0.97)' : 'rgba(13,13,13,0.85)';
        }
    });
});

window.updateQuantity = updateQuantity;
window.removeItem = removeItem;
window.clearAllCart = clearAllCart;
window.goToCheckout = goToCheckout;
window.toggleMenu = toggleMenu;
</script>
</body>
</html>