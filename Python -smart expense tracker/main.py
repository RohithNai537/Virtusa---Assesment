"""
Smart Expense Tracker with Insights
-------------------------------------
A CLI-based personal finance tracker that helps you log expenses,
analyze spending habits, and visualize where your money goes.

Author: Your Name
Version: 1.0.0
"""

import csv
import os
import sys
from datetime import datetime
from collections import defaultdict

# matplotlib is optional — only needed for pie chart
try:
    import matplotlib.pyplot as plt
    MATPLOTLIB_AVAILABLE = True
except ImportError:
    MATPLOTLIB_AVAILABLE = False


# ──────────────────────────────────────────────
# CONSTANTS
# ──────────────────────────────────────────────

CSV_FILE = "expenses.csv"
CATEGORIES = ["Food", "Travel", "Bills", "Entertainment", "Others"]

CSV_HEADERS = ["date", "category", "amount", "description"]

# Spending tips per category shown when that category dominates
SPENDING_TIPS = {
    "Food": [
        "Try meal-prepping on weekends — it cuts dining-out costs significantly.",
        "Use grocery apps or coupons before shopping.",
        "Limit takeout to 1-2 times per week instead of daily.",
    ],
    "Travel": [
        "Book transport tickets in advance for better rates.",
        "Use public transport or carpool where possible.",
        "Compare fuel vs. train/bus costs for regular routes.",
    ],
    "Bills": [
        "Audit subscriptions monthly — cancel anything unused.",
        "Switch to energy-efficient appliances to cut electricity bills.",
        "Bundle internet + TV packages for better deals.",
    ],
    "Entertainment": [
        "Share streaming service plans with family or friends.",
        "Look for free local events, parks, or community activities.",
        "Set a fixed monthly entertainment budget and stick to it.",
    ],
    "Others": [
        "Track 'miscellaneous' items closely — they add up fast.",
        "Delay impulse purchases by 48 hours before buying.",
        "Ask yourself: need vs. want before every unplanned spend.",
    ],
}


# ──────────────────────────────────────────────
# FILE HANDLING
# ──────────────────────────────────────────────

def initialize_csv():
    """
    Creates expenses.csv with headers if it doesn't already exist.
    Called once at program startup.
    """
    if not os.path.exists(CSV_FILE):
        with open(CSV_FILE, mode="w", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(f, fieldnames=CSV_HEADERS)
            writer.writeheader()
        print(f"  [+] Created new file: {CSV_FILE}")


def load_expenses():
    """
    Reads all rows from expenses.csv and returns them as a list of dicts.
    Returns an empty list if the file is empty or missing.
    """
    expenses = []
    try:
        with open(CSV_FILE, mode="r", encoding="utf-8") as f:
            reader = csv.DictReader(f)
            for row in reader:
                expenses.append(row)
    except FileNotFoundError:
        pass
    return expenses


# ──────────────────────────────────────────────
# INPUT VALIDATION HELPERS
# ──────────────────────────────────────────────

def get_valid_date():
    """
    Prompts user for a date in YYYY-MM-DD format.
    Keeps asking until a valid date is entered.
    Returns a date string.
    """
    while True:
        date_str = input("  Date (YYYY-MM-DD) [leave blank for today]: ").strip()
        if date_str == "":
            return datetime.today().strftime("%Y-%m-%d")
        try:
            datetime.strptime(date_str, "%Y-%m-%d")
            return date_str
        except ValueError:
            print("  [!] Invalid date format. Please use YYYY-MM-DD.")


def get_valid_category():
    """
    Displays category menu and returns the user-selected category string.
    Validates that input is one of the allowed choices.
    """
    print("\n  Categories:")
    for i, cat in enumerate(CATEGORIES, start=1):
        print(f"    {i}. {cat}")
    while True:
        choice = input("  Choose category (1-5): ").strip()
        if choice.isdigit() and 1 <= int(choice) <= len(CATEGORIES):
            return CATEGORIES[int(choice) - 1]
        print("  [!] Please enter a number between 1 and 5.")


def get_valid_amount():
    """
    Prompts user for an expense amount.
    Rejects negative values or non-numeric input.
    Returns a float.
    """
    while True:
        amount_str = input("  Amount (e.g. 250.50): ").strip()
        try:
            amount = float(amount_str)
            if amount <= 0:
                print("  [!] Amount must be greater than zero.")
            else:
                return round(amount, 2)
        except ValueError:
            print("  [!] Please enter a valid number.")


# ──────────────────────────────────────────────
# CORE FEATURES
# ──────────────────────────────────────────────

def add_expense():
    """
    Collects expense details from the user and appends a new row to expenses.csv.
    Validates all fields before saving.
    """
    print("\n" + "─" * 45)
    print("  ADD NEW EXPENSE")
    print("─" * 45)

    date = get_valid_date()
    category = get_valid_category()
    amount = get_valid_amount()
    description = input("  Description: ").strip()
    if not description:
        description = "N/A"

    row = {
        "date": date,
        "category": category,
        "amount": amount,
        "description": description,
    }

    with open(CSV_FILE, mode="a", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=CSV_HEADERS)
        writer.writerow(row)

    print(f"\n  ✓ Expense added: ₹{amount:.2f} for {category} on {date}")


def view_expenses():
    """
    Loads all expenses and displays them in a formatted table.
    Shows total at the bottom.
    """
    expenses = load_expenses()

    print("\n" + "─" * 75)
    print("  ALL EXPENSES")
    print("─" * 75)

    if not expenses:
        print("  No expenses recorded yet.")
        return

    # Table header
    print(f"  {'#':<4} {'Date':<13} {'Category':<15} {'Amount':>10}  {'Description'}")
    print("  " + "-" * 70)

    total = 0.0
    for i, exp in enumerate(expenses, start=1):
        amount = float(exp["amount"])
        total += amount
        desc = exp["description"][:30]  # truncate long descriptions
        print(f"  {i:<4} {exp['date']:<13} {exp['category']:<15} ₹{amount:>9.2f}  {desc}")

    print("  " + "-" * 70)
    print(f"  {'TOTAL':>33} ₹{total:>9.2f}")
    print("─" * 75)


def monthly_summary():
    """
    Groups all expenses by YYYY-MM and shows total spending per month.
    Prompts the user to drill down into a specific month.
    """
    expenses = load_expenses()

    if not expenses:
        print("\n  No data available.")
        return

    monthly_totals = defaultdict(float)
    for exp in expenses:
        month_key = exp["date"][:7]  # YYYY-MM
        monthly_totals[month_key] += float(exp["amount"])

    print("\n" + "─" * 45)
    print("  MONTHLY SUMMARY")
    print("─" * 45)
    print(f"  {'Month':<15} {'Total Spent':>12}")
    print("  " + "-" * 30)

    sorted_months = sorted(monthly_totals.keys())
    for month in sorted_months:
        print(f"  {month:<15} ₹{monthly_totals[month]:>11.2f}")

    print("─" * 45)

    # Drill-down option
    choice = input("\n  Enter a month (YYYY-MM) to see details, or press Enter to skip: ").strip()
    if choice in monthly_totals:
        print(f"\n  Expenses for {choice}:")
        print(f"  {'Date':<13} {'Category':<15} {'Amount':>10}  Description")
        print("  " + "-" * 60)
        for exp in expenses:
            if exp["date"].startswith(choice):
                print(f"  {exp['date']:<13} {exp['category']:<15} ₹{float(exp['amount']):>9.2f}  {exp['description']}")
    elif choice:
        print(f"  [!] No data found for '{choice}'.")


def category_analysis():
    """
    Aggregates spending by category and displays totals with percentage share.
    Also highlights the highest spending category with tailored saving tips.
    """
    expenses = load_expenses()

    if not expenses:
        print("\n  No data available.")
        return

    cat_totals = defaultdict(float)
    grand_total = 0.0

    for exp in expenses:
        cat_totals[exp["category"]] += float(exp["amount"])
        grand_total += float(exp["amount"])

    print("\n" + "─" * 55)
    print("  CATEGORY-WISE SPENDING ANALYSIS")
    print("─" * 55)
    print(f"  {'Category':<18} {'Amount':>12}  {'Share':>8}  {'Bar'}")
    print("  " + "-" * 50)

    sorted_cats = sorted(cat_totals.items(), key=lambda x: x[1], reverse=True)
    highest_cat = sorted_cats[0][0]

    for cat, total in sorted_cats:
        pct = (total / grand_total) * 100
        bar = "█" * int(pct / 5)  # each block = ~5%
        print(f"  {cat:<18} ₹{total:>11.2f}  {pct:>7.1f}%  {bar}")

    print("─" * 55)
    print(f"\n  Grand Total: ₹{grand_total:.2f}")
    print(f"\n  🔴 Highest spending category: {highest_cat}")

    # Show money-saving tips
    tips = SPENDING_TIPS.get(highest_cat, [])
    if tips:
        print(f"\n  💡 Tips to reduce '{highest_cat}' spending:")
        for tip in tips:
            print(f"     • {tip}")

    return cat_totals, grand_total


def generate_pie_chart():
    """
    Uses matplotlib to generate a pie chart of category-wise spending.
    Saves the chart as 'expense_chart.png' and also tries to display it.
    Requires matplotlib to be installed.
    """
    if not MATPLOTLIB_AVAILABLE:
        print("\n  [!] matplotlib is not installed.")
        print("      Run:  pip install matplotlib")
        return

    expenses = load_expenses()
    if not expenses:
        print("\n  No data to plot.")
        return

    cat_totals = defaultdict(float)
    for exp in expenses:
        cat_totals[exp["category"]] += float(exp["amount"])

    if not cat_totals:
        print("\n  No category data found.")
        return

    labels = list(cat_totals.keys())
    sizes = [cat_totals[l] for l in labels]

    # Color palette — one per category
    colors = ["#FF6B6B", "#4ECDC4", "#45B7D1", "#96CEB4", "#FFEAA7"]
    explode = [0.05] * len(labels)  # slight separation for all slices

    fig, ax = plt.subplots(figsize=(8, 6))

    wedges, texts, autotexts = ax.pie(
        sizes,
        labels=labels,
        autopct="%1.1f%%",
        colors=colors[: len(labels)],
        explode=explode,
        startangle=140,
        shadow=True,
    )

    # Style the text
    for text in texts:
        text.set_fontsize(12)
    for autotext in autotexts:
        autotext.set_fontsize(10)
        autotext.set_color("white")
        autotext.set_fontweight("bold")

    ax.set_title("Expense Distribution by Category", fontsize=15, fontweight="bold", pad=20)

    # Legend with amounts
    legend_labels = [f"{l}  (₹{cat_totals[l]:,.2f})" for l in labels]
    ax.legend(wedges, legend_labels, title="Categories", loc="lower left", bbox_to_anchor=(1, 0.1))

    plt.tight_layout()

    chart_path = "expense_chart.png"
    plt.savefig(chart_path, dpi=150, bbox_inches="tight")
    print(f"\n  ✓ Chart saved as '{chart_path}'")

    try:
        plt.show()
    except Exception:
        print("  (Could not open display window — chart saved to file only.)")

    plt.close()


# ──────────────────────────────────────────────
# MENU & MAIN LOOP
# ──────────────────────────────────────────────

def print_menu():
    """Prints the main navigation menu."""
    print("\n" + "=" * 45)
    print("   💰  SMART EXPENSE TRACKER")
    print("=" * 45)
    print("   1.  Add Expense")
    print("   2.  View All Expenses")
    print("   3.  Monthly Summary")
    print("   4.  Category Analysis + Tips")
    print("   5.  Generate Pie Chart")
    print("   6.  Exit")
    print("=" * 45)


def main():
    """
    Entry point. Initializes storage and runs the menu-driven CLI loop.
    """
    print("\n  Welcome to Smart Expense Tracker 💸")
    initialize_csv()

    while True:
        print_menu()
        choice = input("   Enter your choice (1-6): ").strip()

        if choice == "1":
            add_expense()
        elif choice == "2":
            view_expenses()
        elif choice == "3":
            monthly_summary()
        elif choice == "4":
            category_analysis()
        elif choice == "5":
            generate_pie_chart()
        elif choice == "6":
            print("\n  Goodbye! Track smart, spend wise. 👋\n")
            sys.exit(0)
        else:
            print("  [!] Invalid option. Please enter a number from 1 to 6.")


if __name__ == "__main__":
    main()
