# 🏢 SQL Business Analysis – Film Rental Store

This project showcases a series of real-world SQL queries developed to analyze business data for a fictional film rental company. The goal is to support a potential acquisition by providing insights into the company’s operations, inventory, customers, and stakeholders.

---

## 📋 Overview of Requests

The dataset simulates a film rental business and contains information on stores, inventory, customers, payments, films, actors, and awards.

The following business questions were answered using SQL:

### 1. 🏪 Store & Manager Info
- Provide names of store managers along with full addresses (street, district, city, country).

### 2. 🎬 Inventory Details
- List inventory items including store ID, inventory ID, film name, rating, rental rate, and replacement cost.

### 3. 📊 Inventory Summary by Rating
- Count of inventory items by film rating at each store.

### 4. 💰 Inventory by Category & Replacement Cost
- Summary showing number of films, average replacement cost, and total replacement cost by store and film category.

### 5. 👥 Customer Overview
- Full list of customer names, store they belong to, active status, and full address.

### 6. 💸 Customer Lifetime Value
- Customers sorted by total payments collected and number of rentals, from highest to lowest value.

### 7. 📘 Advisors & Investors
- List of company advisors and investors with their roles and associated companies (for investors).

### 8. 🏆 Award-Winning Actors in Inventory
- For actors with:
  - 3 awards → What % have films in inventory?
  - 2 awards → What % have films in inventory?
  - 1 award → What % have films in inventory?

---

## 🛠️ Tech Stack

- SQL (MySQL)
- Relational Database Concepts
- Window Functions, Aggregations, Joins
- Business Intelligence Logic & Reporting

---

## 📁 Structure

```bash
├── queries/
│   ├── 01_store_managers.sql
│   ├── 02_inventory_details.sql
│   ├── 03_inventory_summary_by_rating.sql
│   ├── 04_inventory_by_category.sql
│   ├── 05_customers_info.sql
│   ├── 06_customer_lifetime_value.sql
│   ├── 07_advisors_investors.sql
│   └── 08_award_winning_actors.sql
└── README.md
