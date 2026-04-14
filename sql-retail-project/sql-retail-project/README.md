# 🛒 RetailIQ — Online Retail Sales Analysis (SQL Project)

A fully functional SQL analytics project with an interactive web dashboard.  
Live SQLite database runs **entirely in the browser** — no backend required.

---

## 📂 Project Structure

```
sql-retail-project/
├── index.html          ← Interactive web dashboard (open this!)
├── README.md           ← You are here
└── sql/
    ├── schema.sql      ← Table definitions + constraints
    ├── seed_data.sql   ← 20 customers, 25 products, 50 orders
    └── queries.sql     ← 7 business-intelligence SQL queries
```

---

## 🗄️ Database Schema

| Table | Columns | Description |
|---|---|---|
| **Customers** | customer_id PK, name, city | 20 customers across India |
| **Products** | product_id PK, name, category, price | 25 products in 8 categories |
| **Orders** | order_id PK, customer_id FK, date | 50 orders (2023–2024) |
| **Order_Items** | order_id FK, product_id FK, quantity | Line items per order |

### Relationships
```
Customers ──< Orders ──< Order_Items >── Products
```

---

## 🔍 SQL Queries

| # | Query | Purpose |
|---|---|---|
| Q1 | Top-Selling Products | Ranked by units sold (Top 10) |
| Q2 | Most Valuable Customers | Ranked by total lifetime spend |
| Q3 | Monthly Revenue | Revenue per month (2023–2024) |
| Q4 | Category-Wise Sales | Revenue & share per category |
| Q5 | Inactive Customers | No orders in last 180 days |
| Q6 | Avg Order Value by City | City-level spend analysis |
| Q7 | Products Never Ordered | Inventory with zero sales |

---

## 🚀 How to Run

### Option 1 — Open Directly (Recommended)
Just open `index.html` in any modern browser — Chrome, Firefox, Edge, Safari.  
No installation, no server, no dependencies to install.

### Option 2 — Local Server (if CORS issues)
```bash
# Python
python -m http.server 8080

# Node.js
npx serve .
```
Then visit `http://localhost:8080`

### Option 3 — Run SQL Files
Use any SQLite client:
```bash
sqlite3 retail.db < sql/schema.sql
sqlite3 retail.db < sql/seed_data.sql
sqlite3 retail.db < sql/queries.sql
```
Or use [DB Browser for SQLite](https://sqlitebrowser.org/) (GUI).

---

## 📊 Dashboard Features

- **Live KPI Stats** — customers, products, orders, revenue
- **Monthly Revenue Chart** — bar chart (2023–2024)
- **Category Doughnut Chart** — revenue share breakdown
- **City Bar Chart** — average order value by city
- **Top Products Table** — with visual progress bars
- **Most Valuable Customers** — ranked by spend
- **Inactive Customer Detection** — 180-day threshold
- **Interactive SQL Explorer** — run any query live in the browser

---

## 🛠️ Tech Stack

| Component | Technology |
|---|---|
| Database | SQLite (via [sql.js](https://sql-js.github.io/sql.js/)) |
| Charts | [Chart.js 4](https://www.chartjs.org/) |
| Frontend | Vanilla HTML / CSS / JavaScript |
| Fonts | Syne + JetBrains Mono (Google Fonts) |
| Hosting | GitHub Pages (static) |

---

## 🌐 Deploy to GitHub Pages

1. Push this repo to GitHub
2. Go to **Settings → Pages**
3. Source: `main` branch, `/ (root)`
4. Visit `https://<your-username>.github.io/<repo-name>/`

---

## 📈 Sample Insights

- **Top Product**: iPhone 15 Pro — highest revenue generator
- **Most Valuable Customer**: Aarav Sharma (3 orders)
- **Best Month**: December 2024 — peak holiday season
- **Dominant Category**: Electronics — 60%+ revenue share
- **Inactive Customers**: Customers last active before June 2024

---

## 📝 License

MIT — free to use, modify, and distribute.
