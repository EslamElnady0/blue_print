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
│
├── core/
│   │
│   ├── helpers/              # Utility functions and common helpers
│   │
│   ├── network/              # Networking layer (API calls, result handling, error parsing)
│   │
│   ├── themes/               # Centralized themes and styling
│   │
│   ├── widgets/              # Reusable shared widgets
│   │
│   ├── di/                   # Dependency injection setup
│   │
│   └── routes/               # App routing configuration
│
└── features/                 # Modular feature-based structure

```

The core/ layer provides a robust foundation of reusable modules that support scalability and maintainability across the app.

🧩 After running blue_print add-feature --name login:

```bash
lib/
│
├── core/                            # Contains core modules (helpers, networking, DI, etc.)
│
└── features/
    │
    └── login/
        │
        ├── data/                      # Responsible for dealing with API requests
        │   │
        │   ├── models/               # Data models used in the login feature
        │   │
        │   ├── data sources/         # Contains Remote and Local Data Sources
        │   │
        │   └── repos/                # Contains the API repository
        │
        ├── logic/                    # Contains Cubits and Logic Holders
        │   │
        │   └── login_cubit/          # Contains LoginCubit and LoginState
        │
        └── ui/
            │
            ├── views/                # Contains the view file(s)
            │
            └── widgets/              # Contains the UI components/widgets

```

### 📦 Packages Included

The `blue_print` project template comes preconfigured with several useful packages to help you get started with your Flutter projects efficiently. Below are the packages included in the template:

| Package Name         | Purpose                                                                         |
| -------------------- | ------------------------------------------------------------------------------- | --- | ---------- | --- |
| `flutter_screenutil` | For responsive design and screen size adaptability                              |
| `shared_preferences` | To store simple key-value pairs locally on the device                           |
| `get_it`             | Service locator for dependency injection                                        |
| `dio`                | Powerful HTTP client for network requests                                       |
| `pretty_dio_logger`  | Logs Dio requests and responses for better debugging                            |
| `freezed_annotation` | Code generation for immutable classes and sealed unions (using                  |     | `freezed`) |     |
| `json_annotation`    | Provides annotations for JSON serialization and deserialization                 |
| `flutter_bloc`       | State management using Bloc or Cubit pattern                                    |
| `retrofit`           | API client generator that uses annotations for network calls                    |
| `retrofit_generator` | Code generation for `retrofit` API client                                       |
| `build_runner`       | Required for code generation (e.g., `retrofit`, `freezed`, `json_serializable`) |
| `freezed`            | Code generation for immutable classes, union types, and copyWith methods        |
| `json_serializable`  | Code generation for converting objects to and from JSON                         |

These packages are ready for use, but feel free to modify, add, or remove any packages based on your project requirements.
