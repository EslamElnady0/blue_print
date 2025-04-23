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
      - Error handling
      - Helper functions

- **Feature Boilerplate Generator**
  - `blue_print add-feature --name <feature_name>`
  - Adds a complete feature module with:
    - `data/` → data sources, models, repositories
    - `logic/` → view models and logic holders
    - `ui/` → views and widgets
  - Every folder includes ready-to-code templates.

## 📦 Installation

```bash
dart pub global activate blue_print
```

Make sure you add the Dart SDK to your system's path.

## 🛠 Usage

Create a new project

blue_print create-project --name my_awesome_app
Add a new feature

blue_print add-feature --name login

📁 Output Structure
Example structure after running blue_print add-feature --name login:

```bash
lib/
└── features/
    └── login/
        ├── data/
        │   ├── models/
        │   ├── datasources/
        │   └── repositories/
        ├── logic/
        │   └── login_cubit.dart
        └── ui/
            ├── views/
            └── widgets/

```
