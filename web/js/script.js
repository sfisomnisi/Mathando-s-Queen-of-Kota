// ==================== CART MANAGEMENT ====================
let cart = [];

// Validate and fix cart data format (prevents display issues)
function validateAndFixCartData() {
    let saved = localStorage.getItem('mathadosCart');
    if (saved) {
        try {
            let parsedCart = JSON.parse(saved);
            if (Array.isArray(parsedCart)) {
                let needsFix = false;
                for (let i = 0; i < parsedCart.length; i++) {
                    let item = parsedCart[i];
                    if (!item.id || !item.name || typeof item.price === 'undefined' || !item.quantity) {
                        needsFix = true;
                        break;
                    }
                }
                if (needsFix) {
                    let fixedCart = [];
                    for (let i = 0; i < parsedCart.length; i++) {
                        let item = parsedCart[i];
                        fixedCart.push({
                            id: item.id || item.productId || i,
                            name: item.name || item.productName || 'Product',
                            price: typeof item.price === 'number' ? item.price : (parseFloat(item.price) || 0),
                            quantity: item.quantity || 1
                        });
                    }
                    localStorage.setItem('mathadosCart', JSON.stringify(fixedCart));
                    console.log('Fixed cart data format - items:', fixedCart.length);
                } else {
                    console.log('Cart data is valid - items:', parsedCart.length);
                }
                return parsedCart;
            } else {
                console.log('Cart data is not an array, clearing...');
                localStorage.removeItem('mathadosCart');
                return [];
            }
        } catch(e) {
            console.error('Cart data corrupted, clearing...', e);
            localStorage.removeItem('mathadosCart');
            return [];
        }
    } else {
        console.log('No cart data found');
        return [];
    }
}

// Load cart from localStorage on page load
function loadCart() {
    validateAndFixCartData();
    let saved = localStorage.getItem('mathadosCart');
    if (saved) {
        try {
            cart = JSON.parse(saved);
            if (!Array.isArray(cart)) {
                cart = [];
            }
        } catch(e) {
            cart = [];
        }
    } else {
        cart = [];
    }
    console.log('Cart loaded with', cart.length, 'items');
    updateCartCount();
    return cart;
}

// Save cart to localStorage
function saveCart() {
    localStorage.setItem('mathadosCart', JSON.stringify(cart));
    updateCartCount();
    if (typeof window.dispatchEvent === 'function') {
        window.dispatchEvent(new Event('cartUpdated'));
    }
    console.log('Cart saved - items:', cart.length);
}

// Update cart count badge everywhere
function updateCartCount() {
    let total = 0;
    for (let i = 0; i < cart.length; i++) {
        total += cart[i].quantity;
    }
    let cartCountElements = document.querySelectorAll('.cart-count');
    for (let i = 0; i < cartCountElements.length; i++) {
        cartCountElements[i].textContent = total;
    }
    console.log('Cart count updated to:', total);
}

// Add item to cart with quantity
function addToCart(productId, productName, price, quantity) {
    if (!quantity) quantity = 1;
    
    if (!productId || !productName || typeof price !== 'number') {
        console.error('Invalid product data:', {productId, productName, price});
        showToast('Error adding item to cart');
        return false;
    }
    
    let existing = null;
    for (let i = 0; i < cart.length; i++) {
        if (cart[i].id == productId) {
            existing = cart[i];
            break;
        }
    }
    
    if (existing) {
        existing.quantity += quantity;
        console.log('Updated quantity for', productName, 'to', existing.quantity);
    } else {
        cart.push({
            id: productId,
            name: productName,
            price: price,
            quantity: quantity
        });
        console.log('Added new item:', productName, 'quantity:', quantity);
    }
    
    saveCart();
    showToast(quantity + ' x ' + productName + ' added to cart!');
    return true;
}

// Add with quantity selector (for menu pages)
function addWithQuantity(btn, productId, productName, price) {
    let card = btn;
    while (card && !card.classList.contains('menu-card')) {
        card = card.parentElement;
    }
    
    let qtyElement = null;
    if (card) {
        qtyElement = card.querySelector('.qty-value');
    }
    
    let quantity = qtyElement ? parseInt(qtyElement.textContent) : 1;
    
    if (quantity > 0) {
        addToCart(productId, productName, price, quantity);
        if (qtyElement) qtyElement.textContent = '1';
    } else {
        showToast('Please select quantity first');
    }
}

// Change quantity in product card (menu page)
function changeQuantity(btn, delta) {
    let card = btn;
    while (card && !card.classList.contains('menu-card')) {
        card = card.parentElement;
    }
    
    let qtyElement = null;
    if (card) {
        qtyElement = card.querySelector('.qty-value');
    }
    
    if (qtyElement) {
        let currentQty = parseInt(qtyElement.textContent);
        let newQty = currentQty + delta;
        if (newQty < 1) newQty = 1;
        qtyElement.textContent = newQty;
    }
}

// Clear cart completely (used after order or manually)
function clearCart() {
    cart = [];
    localStorage.removeItem('mathadosCart');
    localStorage.removeItem('kotaCart');
    localStorage.removeItem('cart');
    sessionStorage.removeItem('checkoutCart');
    sessionStorage.removeItem('cart');
    updateCartCount();
    showToast('Cart has been cleared!');
    console.log('Cart cleared completely');
    return true;
}

// Force clear all cart data (emergency reset)
function forceClearAllCartData() {
    localStorage.removeItem('mathadosCart');
    localStorage.removeItem('kotaCart');
    localStorage.removeItem('cart');
    sessionStorage.removeItem('checkoutCart');
    sessionStorage.removeItem('cart');
    cart = [];
    updateCartCount();
    console.log('All cart data has been forcefully cleared!');
    showToast('Cart reset complete!');
    if (confirm('Cart reset! Reload page to see changes?')) {
        location.reload();
    }
}

// Get cart contents (for other pages)
function getCart() {
    return cart;
}

// Get cart total count
function getCartTotalCount() {
    let total = 0;
    for (let i = 0; i < cart.length; i++) {
        total += cart[i].quantity;
    }
    return total;
}

// Get cart subtotal
function getCartSubtotal() {
    let subtotal = 0;
    for (let i = 0; i < cart.length; i++) {
        subtotal += cart[i].price * cart[i].quantity;
    }
    return subtotal;
}

// View all past orders (for admin/debugging)
function viewAllOrders() {
    let orders = JSON.parse(localStorage.getItem('mathadosOrders') || '[]');
    console.log('=== ALL ORDERS ===');
    for (let i = 0; i < orders.length; i++) {
        console.log('Order', i + 1 + ':', orders[i].orderNumber, '- R' + orders[i].totalAmount, '-', orders[i].customerName);
    }
    console.log('Total orders:', orders.length);
    return orders;
}

// Clear all orders (admin only)
function clearAllOrders() {
    if (confirm('Delete ALL order history? This cannot be undone!')) {
        localStorage.removeItem('mathadosOrders');
        console.log('All orders cleared');
        showToast('Order history cleared');
    }
}

// ==================== UI FUNCTIONS ====================

// Show toast notification
function showToast(message) {
    let toast = document.getElementById('toast');
    if (!toast) {
        toast = document.createElement('div');
        toast.id = 'toast';
        toast.className = 'toast';
        toast.innerHTML = '<i class="fas fa-check-circle"></i><span id="toastMsg"></span>';
        document.body.appendChild(toast);
    }
    document.getElementById('toastMsg').textContent = message;
    toast.classList.add('show');
    setTimeout(function() {
        toast.classList.remove('show');
    }, 2500);
}

// Toggle mobile menu
function toggleMenu() {
    let links = document.querySelector('.nav-links');
    if (links) {
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
}

// Scroll effect for navbar
function handleScroll() {
    let nav = document.getElementById('navbar');
    if (nav) {
        if (window.scrollY > 40) {
            nav.style.background = 'rgba(13,13,13,0.97)';
        } else {
            nav.style.background = 'rgba(13,13,13,0.85)';
        }
    }
}

// Filter menu by category (for menu page)
function filterMenu(category, element) {
    let buttons = document.querySelectorAll('.tab-btn');
    for (let i = 0; i < buttons.length; i++) {
        buttons[i].classList.remove('active');
    }
    if (element) element.classList.add('active');
    
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

// Debug function - show current cart in console
function debugCart() {
    console.log('=== CART DEBUG INFO ===');
    console.log('Cart array:', cart);
    console.log('Cart length:', cart.length);
    console.log('localStorage mathadosCart:', localStorage.getItem('mathadosCart'));
    console.log('Cart total items:', getCartTotalCount());
    console.log('Cart subtotal:', getCartSubtotal());
    console.log('=======================');
    return cart;
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    console.log('Page loaded - initializing cart...');
    loadCart();
    window.addEventListener('scroll', handleScroll);
    
    window.addEventListener('resize', function() {
        let links = document.querySelector('.nav-links');
        if (window.innerWidth > 768 && links) {
            links.style.display = '';
            links.style.position = '';
            links.style.flexDirection = '';
        }
    });
    
    setTimeout(function() {
        debugCart();
    }, 500);
});

// Export functions for global use
window.loadCart = loadCart;
window.addToCart = addToCart;
window.addWithQuantity = addWithQuantity;
window.changeQuantity = changeQuantity;
window.showToast = showToast;
window.toggleMenu = toggleMenu;
window.clearCart = clearCart;
window.forceClearAllCartData = forceClearAllCartData;
window.filterMenu = filterMenu;
window.getCart = getCart;
window.getCartTotalCount = getCartTotalCount;
window.getCartSubtotal = getCartSubtotal;
window.debugCart = debugCart;
window.validateAndFixCartData = validateAndFixCartData;
window.viewAllOrders = viewAllOrders;
window.clearAllOrders = clearAllOrders;