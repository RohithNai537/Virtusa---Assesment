# 💰 Smart Expense Tracker with Insights

A clean, beginner-friendly Python CLI application that helps you track daily expenses, understand spending habits, and visualize your finances — all from the terminal.

---

## 📋 Features

- **Add Expense** — log any expense with date, category, amount, and description
- **View All Expenses** — formatted table view with running total
- **Monthly Summary** — see total spending per month + drill into any month
- **Category Analysis** — breakdown with % share, visual bar, and money-saving tips
- **Pie Chart** — matplotlib-powered category distribution chart (saved as PNG)
- **Input Validation** — rejects invalid dates, negative amounts, and blank categories
- **Auto CSV creation** — `expenses.csv` is created automatically on first run

---

## 🗂️ Project Structure

```
expense-tracker/
│
├── main.py          # Main application — all logic lives here
├── expenses.csv     # Auto-created data file (sample data included)
└── README.md        # This file
```

---

## 🛠️ Technologies Used

| Tool / Library  | Purpose                        |
|-----------------|-------------------------------|
| Python 3.x      | Core language                  |
| `csv` (built-in)| Reading and writing expense data|
| `os` (built-in) | File existence checks           |
| `datetime`      | Date validation and formatting  |
| `collections`   | `defaultdict` for aggregations  |
| `matplotlib`    | Pie chart generation            |

---

## ⚙️ Setup & How to Run

### 1. Clone or download the project

```bash
git clone https://github.com/yourusername/expense-tracker.git
cd expense-tracker
```

### 2. Install the only external dependency

```bash
pip install matplotlib
```

> If you skip this, everything still works — except the pie chart option.

### 3. Run the app

```bash
python main.py
```

---

## 🖥️ Sample Console Output

### Main Menu
```
  Welcome to Smart Expense Tracker 💸
  [+] Created new file: expenses.csv

=============================================
   💰  SMART EXPENSE TRACKER
=============================================
   1.  Add Expense
   2.  View All Expenses
   3.  Monthly Summary
   4.  Category Analysis + Tips
   5.  Generate Pie Chart
   6.  Exit
=============================================
   Enter your choice (1-6):
```

### Add Expense
```
─────────────────────────────────────────────
  ADD NEW EXPENSE
─────────────────────────────────────────────
  Date (YYYY-MM-DD) [leave blank for today]:
  Categories:
    1. Food
    2. Travel
    3. Bills
    4. Entertainment
    5. Others
  Choose category (1-5): 1
  Amount (e.g. 250.50): 180
  Description: Lunch with team

  ✓ Expense added: ₹180.00 for Food on 2025-04-14
```

### View All Expenses
```
───────────────────────────────────────────────────────────────────────────
  ALL EXPENSES
───────────────────────────────────────────────────────────────────────────
  #    Date          Category         Amount  Description
  ──────────────────────────────────────────────────────────────────────
  1    2025-03-01    Food              ₹120.00  Breakfast at cafe
  2    2025-03-03    Travel            ₹450.00  Metro card recharge
  3    2025-03-05    Bills             ₹999.00  Monthly internet bill
  ...
  ──────────────────────────────────────────────────────────────────────
                  TOTAL              ₹9,532.50
───────────────────────────────────────────────────────────────────────────
```

### Monthly Summary
```
─────────────────────────────────────────
  MONTHLY SUMMARY
─────────────────────────────────────────
  Month           Total Spent
  ──────────────────────────────
  2025-03              ₹5,378.50
  2025-04              ₹6,174.00
─────────────────────────────────────────
```

### Category Analysis
```
───────────────────────────────────────────────────────
  CATEGORY-WISE SPENDING ANALYSIS
───────────────────────────────────────────────────────
  Category            Amount       Share  Bar
  ──────────────────────────────────────────────────
  Food              ₹2,355.50    24.7%  ████
  Bills             ₹4,549.00    47.7%  █████████
  Travel            ₹1,450.00    15.2%  ███
  Entertainment     ₹1,148.00    12.0%  ██
  Others            ₹2,050.00    21.5%  ████
───────────────────────────────────────────────────────

  Grand Total: ₹9,532.50

  🔴 Highest spending category: Bills

  💡 Tips to reduce 'Bills' spending:
     • Audit subscriptions monthly — cancel anything unused.
     • Switch to energy-efficient appliances to cut electricity bills.
     • Bundle internet + TV packages for better deals.
```

### Pie Chart
The chart is saved as **`expense_chart.png`** in the project folder and also displayed in a window if a GUI is available.

![Pie Chart Preview — shows colored segments for Food, Bills, Travel, Entertainment, Others with percentage labels]

---

## 📌 Notes

- Dates must be in `YYYY-MM-DD` format; leave blank to default to today
- Amounts must be positive numbers (decimals supported)
- All data persists in `expenses.csv` between sessions
- The pie chart is saved as `expense_chart.png` every time you generate it

---

## 🧑‍💻 Author

Built with Python — no frameworks, no magic. Just clean code.

Feel free to fork, extend, or customize for your own finance tracking needs!
