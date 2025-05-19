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

# 🛠️ Tech Stack

- SQL (MySQL)
- Relational Database Concepts
- Window Functions, Aggregations, Joins
- Business Intelligence Logic & Reporting

---

## 📋  Data Analysis & Findings

This document outlines the SQL queries used to gather insights about store management, inventory, customer base, and stakeholders. Each section corresponds to specific information requested for due diligence.


### 1. Store Manager Information

> **Request:** Provide manager names and full property addresses for each store (street, district, city, country).

```sql
SELECT
	staff.first_name AS manager_first_name,
    staff.last_name AS manager_last_name,
    address.address,
    address.district,
    city.city,
    country.country
FROM store
	LEFT JOIN staff ON store.manager_staff_id = staff.staff_id
    LEFT JOIN address ON store.address_id = address.address_id
    LEFT JOIN city ON address.city_id = city.city_id
    LEFT JOIN country ON city.country_id = country.country_id;
```

---

### 2. Inventory Details

> **Request:** Provide a list of all inventory items, including store ID, inventory ID, film title, rating, rental rate, and replacement cost.

```sql
SELECT
	inventory.store_id,
    inventory.inventory_id,
    film.title,
    film.rating,
    film.rental_rate,
    film.replacement_cost
FROM inventory
	LEFT JOIN film ON inventory.film_id = film.film_id;
```

---

### 3. Inventory Summary by Rating & Store

> **Request:** Provide a summary count of inventory items by film rating and store.

```sql
SELECT
	inventory.store_id,
    film.rating,
    COUNT(inventory_id) AS inventory_items
FROM inventory
	LEFT JOIN film ON inventory.film_id = film.film_id
GROUP BY
	inventory.store_id,
    film.rating;
```

---

### 4. Inventory Replacement Cost Overview

> **Request:** Provide total, average, and count of replacement costs by film category and store to assess inventory risk.

```sql
SELECT
	store_id,
    category.name AS category,
	COUNT(inventory.inventory_id) AS films,
    AVG(film.replacement_cost) AS avg_replacement_cost,
    SUM(film.replacement_cost) AS total_replacement_cost
FROM inventory
	LEFT JOIN film ON inventory.film_id = film.film_id
	LEFT JOIN film_category ON film.film_id = film_category.film_id
	LEFT JOIN category ON category.category_id = film_category.category_id
GROUP BY
	store_id,
    category.name
ORDER BY
	SUM(film.replacement_cost) DESC;
```

---

### 5. Customer Profiles

> **Request:** List of customer names, store associations, active status, and full addresses.

```sql
SELECT
	customer.first_name,
    customer.last_name,
    customer.store_id,
    customer.active,
    address.address,
    city.city,
    country.country
FROM customer
	LEFT JOIN address ON customer.address_id = address.address_id
    LEFT JOIN city ON address.city_id = city.city_id
    LEFT JOIN country ON city.country_id = country.country_id;
```

---

### 6. Customer Lifetime Value

> **Request:** Total rentals and payment sums for each customer, ordered by lifetime value.

```sql
SELECT
	customer.first_name,
    customer.last_name,
    COUNT(rental.rental_id) AS total_rentals,
    SUM(payment.amount) AS total_payment_amount
FROM customer
	LEFT JOIN rental ON customer.customer_id = rental.customer_id
    LEFT JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY
	customer.first_name,
    customer.last_name
ORDER BY
	SUM(payment.amount) DESC;
```

---

### 7. Board of Advisors & Investors

> **Request:** Combined list of investors and advisors, with type noted and company name for investors.

```sql
SELECT
	'investor' AS type,
    first_name,
    last_name,
    company_name
FROM investor
UNION
SELECT
	'advisor' AS type,
    first_name,
    last_name,
    NULL
FROM advisor;
```

---

### 8. Award-Winning Actor Coverage

> **Request:** Percentage of award-winning actors represented in film inventory, by number of awards held.

```sql
SELECT
	CASE
		WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
        WHEN actor_award.awards IN ('Emmy, Oscar','Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
		ELSE '1 award'
	END AS number_of_awards,
    AVG(CASE WHEN actor_award.actor_id IS NULL THEN 0 ELSE 1 END) AS pct_w_one_film
FROM actor_award
GROUP BY
	CASE
		WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
        WHEN actor_award.awards IN ('Emmy, Oscar','Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
		ELSE '1 award'
	END;
```

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

---
