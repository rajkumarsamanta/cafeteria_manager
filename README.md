# README
# [**Cafeteria Manager App**](https://rks-cafe-manager-saas-201.herokuapp.com/)
## SaaS WD201 Capstone Project (option 1) under development

This is a Cafeteria Management App developed on Rails. This app is made for three types of user's roles like Manager (owner), Staff (clerk) and customer. Manager can create user for other manager of staff, change the role of a registered customer to manager or staff after log-in by giving the existing password of a customer.

The steps necessary to get the Cafeteria application up and running. The roles and different functionalities for "owner", "clerk" and "customer" are explained below:

The Operational credetials for "Owner" and a "clerk" is given for your use and operation. You can create a customer by using the "Sign-up" link the home page.

### owner - email: raj@kumar.com, password: kumar
### clerk - email: reedhi@reedhi.com, password: reedhi

# Customer

## New Customer can Sign-up

  * If a customer doesn’t already have an account, s/he will be able to sign-up first.
    * If s/he is an existing user, s/he will be able to sign-in with their email and password.
    * S/he will also be able to sign-out if wants to.

## Customer can see the menu and add items to cart

    * A signed-in customer can see the different Menus available in home page. 
    * Items available on a particular Menu can be seen by clicking on the Menu. Only items of active Menus is visible for order. 
    * Inactive Menus and items are dimmed. On placing the mouse on a food item you want to buy, "Add to cart" button will be displayed. 
    * On clicking "Add to cart" button, the highlighted food item will be placed in your Cart (The Cart will be displayed and the number of items in the cart will also be shown. 
    * Repeated clicking the "Add to cart" button for the same food item, will increment the quantity of the item in Cart.
    * Once an item is added to a cart, you can click + or - to add or remove its quantity from cart. 
    * Cart will be visible iff any item is placed in it.
    * By clicking the "Confirm order" button, the items in the cart will be placed as a Order and the Cart will be cleared. 
    * The cart will show the list of items added, their quantities, their total cost and the total expected bill amount.
    * When the order is confirmed and placed, the items will be available as pending order. 
    * The orders and their status can be seen by clicking the Order/Pending #Number shown in top of their home page. 
    * Order status will show all his/her orders with each order's ID, date of order, amount, delivery status. 
    * On clicking an Order, the details of the order can be seen.

# Cafeteria Staff (Clerk)

    * Clerks can only sign-in and sign-out. They cannot sign-up by themselves. 
    * Their accounts can be created only by the owner from owner's "Manage Users" option. Owner can create either another "Owner" or "Clerk" users. 
    * "Customer" users can not be created by "owner", "customer" can only "sign-up" themselves by clicking the "Sign-up" link available in the home page.
    * Clerk can see the list of all pending orders from the queue of orders (by clicking the Order #No / Pending #No displayed at the top of their home page. 
    * They can also mark an orders as “delivered” or vice-versa by cliking the checkbox.
    * Clerk can create orders for offline customers, just like regular customer. However, all orders created by billing clerks will be assigned to a default “Walk-in customer”.

# Cafeteria Owner

Nobody can sign-up as an owner. Instead, the live application comes with an owner already created.

An owner can create other owners (By clicking the "Manage Users" in their home page and "Add" user either "owner" or "clerk".

## Owner can manage the menu

* The Cafeteria has a single menu. The menu is organized as a collection of MenuCategories. A MenuCategory can be headings like Breakfast, Lunch, Indian Breads, North Indian, South Indian, Main Course, Desserts, and so on.These MenuCategories are shown to the users in their home page on logging-in.

* Each MenuCategory has multiple MenuItems. Each MenuItem has a name, description and price per quantity. The MenuItems under a MenuCategory can be seen by clicking on the MenuCategory.

### In MenuCategories, the owner can :

    * See all existing categories
    * Create a new one
    * Update the name of a category
    * Mark one as active/inactive. (Click the checkbox to make the On/Off button visible. Otherwise, "Update" and "Add-item" button is visible on placing the 
    cursor on the MenuCategory. Inactive MenuCategory and MenuItems are dimmed and will not be available for placing Order.

### For each MenuCategory, the owner will be able to:

    * See the list of items in the category (MenuItem)
    * Add a new item to the menu
    * Delete or update an existing item

## Owner can see reports

    * Order Reports for any given date range (by going to the order page by clicking the "Order #No / Pending #No" displayed in the top of their home page screen.
    It will list all invoices in that range (Date From - Date To), name of the customer or both (by giving all three), and total invoice details. It is possible 
    to click on any invoice and see details of that invoice.
    * Owner can see details of a single invoice
    * Owner can see all the orders made by any given customer in a date range.

## Owner can manage users (By clicking the "Manage Users" link in their home page)

    * Owner can see the list of all users - customers, billing-clerks, and other owners.

    * They can create and update billing clerks and owners. They cannot create customers, because customers have to sign-up by themselves.

Sample screenshots are given below:

## Home Page
[**![Cafeterial Management App Screenshot](/app/assets/images/Cafe1.png)**](https://rks-todo-manager-saas-201.herokuapp.com/)

## Sign-in Page
![Cafeterial Management App Screenshot](/app/assets/images/Cafe-sign-in.png)

## Sign-up Page
![Cafeterial Management App Screenshot](/app/assets/images/Cafe-sign-up.png)

## Staff Home Page
![Cafeterial Management App Screenshot](/app/assets/images/Cafe-clerk-home.png)

## Staff order Page
![Cafeterial Management App Screenshot](/app/assets/images/Cafe-clerk-order.png)


## #####################
