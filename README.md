# 💸 Expense Manager – Internship Assessment Project

This Flutter application is a component of a larger expense management system. It was built as part of an internship assignment to demonstrate skills in frontend development, clean architecture, and local data persistence using Hive.

---

## 📱 What the App Does

The app allows users to:

- Add a new **expense entry** with:
  - Category name
  - Optional vendor name
  - Date (customizable via calendar picker)
  - Paid amount
  - Auto-calculated pending balance

- Add **multiple items** under each expense:
  - Item name
  - Quantity & unit
  - Price

- View a detailed breakdown of each expense by tapping on it:
  - See all added items in a table format
  - View total billing amount, paid amount, and pending balance

- Save expenses **locally** using Hive database
- View all saved expenses directly on the main screen

---

## 🧠 Architecture

The app is built using **Flutter** and follows the principles of **Clean Architecture**:


---

## 🧪 Local Data Persistence with Hive

All expenses are stored **locally on the device** using [Hive](https://pub.dev/packages/hive), a lightweight and blazing fast key-value database written in pure Dart.

Each expense is stored along with its item list, billing, and payment information. Data can be reopened after app restart, and is immediately available without any login or API fetch.

---

## ⚙️ Tech Stack

- **Flutter** 3.x
- **Hive** for local storage
- **intl** for date formatting
- Clean architecture principles
- No backend integration for this module (local-only)

---

## 🧩 Challenges Faced

- Implementing **Hive** with nested object models (ExpenseItem inside ExpenseModel)
- Managing state between **multiple modal bottom sheets** (Add Item, View List, Expense Details)
- Handling the **UI responsiveness** for forms with dynamic input fields
- Ensuring all data syncs properly across sheets and is stored correctly in Hive

---

## ⚠️ Limitations

- **Payment Details (Proof and Type)** were planned, but not implemented due to backend/API integration issues.
- The current app is **only a fragment** of the full expense management flow, focusing solely on entry and visualization.

---

## 🚀 How to Run

1. Clone the repo:
   ```bash
   git clone <your-repo-url>
   cd expense_manager
