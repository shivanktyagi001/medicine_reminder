# 💊 Medicine Reminder App

A simple and clean **Flutter Medicine Reminder application** that allows users to add daily medicines and receive timely notifications, even when the app is in the background.

This project was built as an assignment to demonstrate **clean architecture, state management, local storage, and notification handling** in Flutter.

---

## 📱 Features

### 🏠 Home Screen
- Displays a list of added medicines
- Shows:
  - Medicine Name
  - Dose
  - Reminder Time
- Medicines are **sorted by time**
- Shows a placeholder message when no medicines are added
- Swipe to delete a medicine reminder

### ➕ Add Medicine Screen
- Input fields:
  - Medicine Name
  - Dose
  - Time Picker for reminder
- Validation to prevent empty submissions
- Displays selected reminder time
- Shows error messages for invalid input

### ⏰ Reminder & Notification
- Schedules local notifications at the selected time
- Works even when the app is in the background
- Automatically schedules the reminder for the **next day** if the selected time has already passed
- Handles Android notification permissions properly

### 💾 Local Storage
- Uses **Hive** for persistent local storage
- No backend required

---

## 🛠️ Tech Stack

- **Flutter**
- **BLoC** – State Management
- **Hive** – Local Database
- **flutter_local_notifications** – Notification scheduling
- **Intl** – Date & time formatting

---

## 🎨 UI & Design
- **Primary Color:** Teal  
- **Accent / Buttons:** Orange  
- Follows Material Design principles
- Clean and minimal UI

---


