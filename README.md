# 🎓 HarvardCS50X macOS App

A minimalist macOS application built with Swift and SwiftUI to help you stay focused, organized, and motivated while taking the [Harvard CS50x](https://cs50.harvard.edu/x/) course.

---

## ✨ Features

- 🧠 **Personalized Greeting**  
  Display your name, age (calculated from birth date), course name, and profile image on startup.

- 📅 **Course Countdown Timer**  
  Automatically calculates your progress based on a 12-week schedule and custom start date.

- 🌐 **CS50 Link Manager**  
  - Add, delete (with confirmation), and edit CS50-related links  
  - Click to open links in your default browser  
  - Drag-and-drop to reorder  
  - Search to filter links  
  - "Open All" to launch every saved link at once

- 💾 **Persistent Local Storage**  
  All data (name, course, dates, links) is saved in a local JSON file on your Mac.

- 🎨 **Blurry Glass UI**  
  A transparent, macOS-style menu bar interface with subtle effects and a clean look.

---

## 📦 Installation (For Developers)

### 1. Clone the Repository
```bash
git clone https://github.com/alaa-emam-geophysicist/HarvardCS50XApp.git
cd HarvardCS50XApp
```

### 2. Open in Xcode  
A. Double-click `HarvardCS50X.xcodeproj` (or `HarvardCS50X.xcworkspace` if using Swift packages)  
B. Xcode will open the project

### 3. Set Target to Mac  
A. In the top toolbar, check that the selected build scheme is **My Mac**  
B. This ensures the app runs on your Mac (not iOS simulator)

### 4. Run the App  
A. Press `Cmd + R` or  
B. Click the ▶️ Run button  
C. The app will build and launch on your Mac

---

## 📁 File Structure Overview

```
HarvardCS50XApp
├── AppIcon/                     # App icons in various sizes
├── HarvardCS50X/                # Main source files
│   ├── GreetingView.swift
│   ├── CountdownView.swift
│   ├── URLInputView.swift
│   ├── URLListView.swift
│   ├── SettingsView.swift
│   └── ...
├── HarvardCS50X.xcodeproj/      # Xcode project
├── HarvardCS50XTests/           # Unit tests
├── HarvardCS50XUITests/         # UI tests
├── LICENSE.md
└── README.md
```

---

## 🙋‍♂️ Why I Built This

I’m currently studying **Harvard CS50X** and wanted a personal companion tool to:

- Stay focused throughout the course  
- Keep useful resources in one place  
- Track weekly progress and motivation  

The app is made for **personal use**, but feel free to fork and enhance it!

---

## 🔐 Privacy

✅ This app is 100% local —  
No data is collected or transmitted. Your information stays on your Mac.

---

## 📸 Screenshots (Coming Soon)

> I’ll add UI screenshots here in a future update!

---

## 🛠 Built With

- 💻 [Swift](https://swift.org/)  
- 🎨 [SwiftUI](https://developer.apple.com/xcode/swiftui/)  
- 🧰 [Xcode](https://developer.apple.com/xcode/)  
- 🍎 macOS Frameworks (SwiftUI + AppKit)

---

## 📬 Contact

Feel free to reach out with feedback, ideas, or improvements!

**GitHub**: [@alaa-emam-geophysicist](https://github.com/alaa-emam-geophysicist)
