# 🧱 blue_print

**blue_print** is a CLI tool that helps Flutter developers kickstart and scale their projects quickly with clean folder architecture and prebuilt templates. 🚀

## ✨ Features

- **Project Scaffolding**

  - `blue_print create-project --name <project_name>`
  - Instantly sets up a Flutter project with essential packages and a well-structured architecture:
    - `core/` contains:
      - Routing setup
      - Dependency injection
      - Networking utilities
      - Common Widgets
      - Helper functions
      - Initial theming setup

- **Feature Boilerplate Generator**
  - `blue_print add-feature --name <feature_name>`
  - Adds a complete feature module with:
    - `data/` → data sources, models, repositories
    - `logic/` → cubits and logic holders
    - `ui/` → views and widgets
  - Every folder includes ready-to-code templates.

## 📦 Installation

```bash
dart pub global activate blue_print
```

Make sure you add the Dart SDK to your system's path.

## 🛠 Usage

Create a new project

```bash
blue_print create-project --name <project_name>
```

Add a new feature

```bash
blue_print add-feature --name <feature_name>
```

## 📁 Output Structure

🔧 After running blue_print create-project --name my_awesome_app:

```bash
lib/
├── core/
│   ├── helpers/           # Utility functions and common helpers
│   ├── network/           # Networking layer (API calls, result handling, error parsing)
│   ├── themes/            # Centralized themes and styling
│   ├── widgets/           # Reusable shared widgets
│   ├── di/                # Dependency injection setup
│   └── routes/            # App routing configuration
└── features/
```

The core/ layer provides a robust foundation of reusable modules that support scalability and maintainability across the app.

🧩 After running blue_print add-feature --name login:

```bash
lib/
└── features/
    └── login/
        ├── data/                 # Responsible for dealing with api requests
        │   ├── models/
        │   ├── data sources/     # Contains Remote and Local Data Sources
        │   └── repos/            # Contains The Api Repo
        ├── logic/                # Contains Cubits and Logic Holders
        │   └── login_cubit/      # Contains LoginCubit and LoginState
        └── ui/
            ├── views/            # Contains the view file
            └── widgets/

```
