# 🗂️ Data Catalog — Gold Layer

## Overview
The **Gold Layer** is the **business-level data representation**, designed to support analytical and reporting use cases.  
It consists of **dimension tables** and **fact tables** that store enriched, cleansed, and aggregated business data.

---

## 1. gold.dim_customers

**Purpose:**  
Stores customer details enriched with demographic and geographic data.

**Columns:**

| Column Name     | Data Type     | Description                                                                 |
|-----------------|---------------|------------------------------------------------------------------------------|
| customer_key    | INT           | Surrogate key uniquely identifying each customer record in the dimension table. |
| customer_id     | INT           | Unique numerical identifier assigned to each customer.                      |
| customer_number | NVARCHAR(50)  | Alphanumeric identifier representing the customer, used for tracking and referencing. |
| first_name      | NVARCHAR(50)  | The customer's first name, as recorded in the system.                       |
| last_name       | NVARCHAR(50)  | The customer's last name or family name.                                    |
| country         | NVARCHAR(50)  | The country of residence for the customer (e.g., 'Australia').              |
| marital_status  | NVARCHAR(50)  | The marital status of the customer (e.g., 'Married', 'Single').             |
| gender          | NVARCHAR(50)  | The gender of the customer (e.g., 'Male', 'Female', 'n/a').                 |
| birthdate       | DATE          | The date of birth of the customer (format: YYYY-MM-DD).                     |
| create_date     | DATE          | The date when the customer record was created in the system.                |

---

## 2. gold.dim_products

**Purpose:**  
Provides information about products and their attributes.

**Columns:**

| Column Name          | Data Type     | Description                                                                 |
|----------------------|---------------|------------------------------------------------------------------------------|
| product_key          | INT           | Surrogate key uniquely identifying each product record in the dimension table. |
| product_id           | INT           | Unique identifier assigned to the product for internal tracking and referencing. |
| product_number       | NVARCHAR(50)  | Structured alphanumeric code representing the product (used for categorization or inventory). |
| product_name         | NVARCHAR(50)  | Descriptive name of the product, including key details such as type, color, and size. |
| category_id          | NVARCHAR(50)  | Unique identifier for the product’s category.                               |
| category             | NVARCHAR(50)  | Broader classification of the product (e.g., 'Bikes', 'Components').        |
| subcategory          | NVARCHAR(50)  | Detailed classification of the product within the category (e.g., product type). |
| maintenance_required | NVARCHAR(50)  | Indicates whether the product requires maintenance (e.g., 'Yes', 'No').     |
| cost                 | INT           | The base cost or price of the product, measured in monetary units.          |
| product_line         | NVARCHAR(50)  | The specific product line or series to which the product belongs (e.g., 'Road', 'Mountain'). |
| start_date           | DATE          | The date when the product became available for sale or use.                 |

---

## 3. gold.fact_sales

**Purpose:**  
Stores transactional sales data for analytical purposes.

**Columns:**

| Column Name   | Data Type     | Description                                                                 |
|----------------|---------------|------------------------------------------------------------------------------|
| order_number  | NVARCHAR(50)  | Unique alphanumeric identifier for each sales order (e.g., 'SO54496').      |
| product_key   | INT           | Surrogate key linking the order to the product dimension table.             |
| customer_key  | INT           | Surrogate key linking the order to the customer dimension table.            |
| order_date    | DATE          | The date when the order was placed.                                         |
| shipping_date | DATE          | The date when the order was shipped to the customer.                        |
| due_date      | DATE          | The date when the order payment was due.                                    |
| sales_amount  | INT           | Total monetary value of the sale for the line item, in whole currency units.|
| quantity      | INT           | The number of units of the product ordered for the line item.               |
| price         | INT           | The price per unit of the product for the line item, in whole currency units. |

---

## Notes

- **Schema:** `gold`
- **Data Refresh Frequency:** Daily ETL Load  
- **Data Source Systems:** CRM, ERP, Product Catalog, Sales Platform  
- **Data Owner:** Data Engineering Team  
- **Last Updated:** October 2025  

---

© 2025 — Data Engineering | [Your GitHub Repository](https://github.com/yourusername/yourrepo)
