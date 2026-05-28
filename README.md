# Mathado's Queen of Kota

## Project Overview
Mathado's Queen of Kota is a full-stack web application for ordering authentic South African street food online. The system allows customers to browse menus, add items to cart, checkout, and receive printable order receipts. The application serves customers in Breyten, Mpumalanga.

## Features
- Home Page with hero section and featured products
- Menu Page with category filtering (Kotas, Bunny Chow, Combos, Sides, Drinks)
- Shopping Cart with quantity management and real-time total calculation
- Checkout System with customer information collection
- Order Receipt with unique order numbers, date/time, and printable format
- Responsive Design works on desktop, tablet, and mobile devices
- Payment Options - Cash or Card on delivery

## Technologies Used
- Java JSP/Servlets - Backend logic
- HTML5/CSS3 - Frontend styling  
- JavaScript - Client-side interactivity
- Apache Derby - Database
- GlassFish 4.1.1 - Application Server
- NetBeans IDE - Development

## Project Structure
KotaShop/
├── src/za/ac/tut/kotashop/
│ ├── dao/ # Database access objects
│ ├── model/ # Entity classes (Product, CartItem, Order, etc.)
│ └── servlets/ # Controllers (HomeServlet, CartServlet, etc.)
├── web/
│ ├── css/ # Stylesheets
│ ├── images/ # Product and UI images
│ ├── js/ # JavaScript files
│ ├── pages/ # JSP pages (cart, checkout, about, contact, rate-us)
│ ├── WEB-INF/ # Configuration files
│ └── index.jsp # Home page
└── database.sql # Database creation script
Author
Sfiso Mnisi
Location: Breyten, Mpumalanga, South Africa
