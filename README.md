# README

# cafeteria_manager
## SaaS WD201 Capstone Project (option 1) under development

This README explain the steps necessary to get the Cafeteria application up and running.

This application offers different functionalities for "owner", "clerk" and "customer"

## Customer

1. New Customer can Sign-up

    If a customer doesn’t already have an account, s/he will be able to sign-up first.
    If s/he is an existing user, s/he will be able to sign-in with their email and password.
    s/he will also be able to sign-out if wants to.

2. Customer can see the menu and add items to cart

    A signed-in customer can see the different Menus available in home page. Items available on a particular Menu can be seen by clicking on the Menu.
    Only items of active Menus is visible for order. Inactive Menus and items are dimmed. On placing the mouse on a food item you want to buy, "Add to cart" 
    button will be displayed. On clicking this button, the highlighted food item will be placed in your Cart (The Cart will be displayed and the number of 
    items in the cart will also be shown. Repeated clicking the "Add to cart" button for the same food item, will increment the quantity of the item in Cart.
    Once an item is added to a cart, you can click + or - to add or remove its quantity from cart. Cart will be visible only iff any item is placed in it.

3. Customer can see the cart and confirm the items in cart to order 

   By clicking the "Confirm order" button, the items in the cart will be placed as a Order and the Cart will be cleared. Before placing the Order, 
   the customer can deleted an item from the cart, increment or decrement quantity of an item in the cart. The cart will show the list of items added,
   their quantities, their total cost and the total expected bill amount.

   When the order is confirmed and placed, the items will be available as pending order. The orders and their status can be seen by clicking the Order/Pending 
   #Number shown in top of their home page. Order status will show all his/her orders with each order's ID, date of order, amount, delivery status. On clicking
   an Order, the details of the order can be seen.

# Cafeteria Billing Clerk

Billing clerks can only sign-in and sign-out. They cannot sign-up by themselves. Their accounts can be created only by the owner from owner's "Manage Users" option. Owner can create either another "Owner" or "Clerk" users. "Customer" users can not be created by "owner", "customer" can only "sign-up" themselves by clicking the "Sign-up" link available in the home page. 

1. Clerk can see the list of all pending orders from the queue of orders (by clicking the Order #No / Pending #No displayed at the top of their home page. They can also mark orders as “delivered” or vice-versa. 

2. Clerk can create orders for offline customers, just like regular customer. However, all orders created by billing clerks will be assigned to a default “Walk-in customer”.

# Cafeteria Owner

Nobody can sign-up as an owner. Instead, the live application should come with an owner already created.

An owner can create other owners (By clicking the "Manage Users" in their home page and "Add" user either "owner" or "clerk".

1. Owner can manage the menu

The Cafeteria has a single menu. The menu is organized as a collection of MenuCategories. A MenuCategory can be headings like Breakfast, Lunch, Indian Breads, North Indian, South Indian, Main Course, Desserts, and so on.These MenuCategories are shown to the users in their home page on logging-in.

Each MenuCategory has multiple MenuItems. Each MenuItem has a name, description and price per quantity. The MenuItems under a MenuCategory can be seen by clicking on the MenuCategory.

In MenuCategories, the owner can :

    See all existing categories
    Create a new one
    Update the name of a category
    Mark one as active/inactive. (Click the checkbox to make the On/Off button visible. Otherwise, "Update" and "Add-item" button is visible on placing the 
    cursor on the MenuCategory. Inactive MenuCategory and MenuItems are dimmed and will not be available for placing Order.

For each MenuCategory, the owner will be able to:

    See the list of items in the category (MenuItem)
    Add a new item to the menu
    Delete or update an existing item

2. Owner can see reports

    Order Reports for any given date range (by going to the order page by clicking the "Order #No / Pending #No" displayed in the top of their home page screen.
    It will list all invoices in that range (Date From - Date To), name of the customer or both (by giving all three), and total invoice details. It is possible 
    to click on any invoice and see details of that invoice.
    Owner can see details of a single invoice
    Owner can see all the orders made by any given customer in a date range.

3. Owner can manage users (By clicking the "Manage Users" link in their home page)

    Owner can see the list of all users - customers, billing-clerks, and other owners.

    They can create and update billing clerks and owners. They cannot create customers, because customers have to sign-up by themselves.

# To be updated .....


* ...
