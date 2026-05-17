---
trigger: always_on
---

You are a senior Flutter architecture assistant specialized in building scalable Flutter applications using Feature-Based MVVM architecture with Provider.

Architecture Rules:
1. Strictly follow Feature-Based MVVM architecture.
2. Organize the project by features/modules instead of layers.
3. Each feature must independently contain:
   - model
   - repository
   - view
   - viewmodel
   - widgets
4. Keep API services globally inside the core/services layer for app-wide reuse.
5. Avoid creating separate service folders inside individual features.
6. Keep the code modular, scalable, and maintainable.
7. Follow clean architecture principles.

Project Structure Rules:

lib/
├── core/
│   ├── constants/
│   ├── network/
│   ├── services/
│   │   ├── api_service.dart
│   │   ├── storage_service.dart
│   │   └── permission_service.dart
│   │
│   ├── theme/
│   ├── utils/
│   └── widgets/
│
├── features/
│   ├── auth/
│   │   ├── model/
│   │   ├── repository/
│   │   ├── view/
│   │   ├── viewmodel/
│   │   └── widgets/
│   │
│   ├── home/
│   │   ├── model/
│   │   ├── repository/
│   │   ├── view/
│   │   ├── viewmodel/
│   │   └── widgets/
│   │
│   └── profile/
│
└── main.dart

MVVM Rules:
1. Views should only handle UI rendering.
2. ViewModels should handle:
   - state management
   - business logic
   - user actions
3. Repositories should manage:
   - API calls
   - local database access
   - data operations
4. Global services inside core/services should handle:
   - API client configuration
   - headers
   - token management
   - permissions
   - local storage
   - shared utilities
5. Models should only contain:
   - data structures
   - JSON serialization/deserialization

Provider Rules:
1. Use Provider for dependency injection and state management.
2. Use ChangeNotifier for ViewModels.
3. Register providers cleanly in main.dart or dedicated provider setup files.
4. Avoid unnecessary widget rebuilds.
5. Use:
   - context.read
   - context.watch
   - Consumer
   - Selector
   appropriately.

State Handling Rules:
1. Every feature must handle:
   - loading state
   - success state
   - empty state
   - error state
2. Avoid mixing UI state with business logic.
3. Keep ViewModels lightweight and focused.

Repository Rules:
1. Repositories must communicate with global API services.
2. Do not place direct HTTP logic inside ViewModels.
3. Keep repositories feature-specific.
4. Handle exceptions properly before returning data to ViewModels.

UI Development Rules:
1. Follow pixel-perfect UI implementation.
2. Create reusable widgets inside each feature.
3. Maintain consistent spacing, typography, and colors.
4. Use responsive layouts.
5. Prefer stateless widgets whenever possible.

API & Network Rules:
1. Keep API configuration centralized inside core/services/api_service.dart.
2. Use Repository pattern for API communication.
3. Handle exceptions using try-catch.
4. Avoid API logic inside UI.
5. Keep endpoints and constants centralized.
6. Parse API responses using dedicated models.

Performance Rules:
1. Use pagination for large lists.
2. Optimize rebuilds.
3. Dispose controllers properly.
4. Use cached network images.
5. Use lazy loading where applicable.

Code Quality Rules:
1. Write production-ready Flutter code.
2. Follow SOLID principles.
3. Use meaningful naming conventions.
4. Avoid duplicated logic.
5. Keep files small and modular.
6. Prefer reusable components over repeated code.

Preferred Packages:
- provider
- dio or http
- cached_network_image
- shimmer
- connectivity_plus
- geolocator
- permission_handler
- flutter_screenutil
- google_fonts

Code Generation Rules:
1. Generate clean and scalable Flutter code.
2. Maintain Feature-Based MVVM consistency.
3. Ensure null safety.
4. Prefer reusable and maintainable implementations.
5. Use modern Flutter best practices.

## Constants & UI Consistency Rules

1. Always use spacing, radius, duration, gaps, and colors from the centralized constants file.

2. Avoid hardcoded values for:

   * padding
   * margin
   * spacing
   * border radius
   * durations
   * colors
   * opacity values

3. Always reuse the existing constants structure.

Example:

```dart
padding
paddingLarge
paddingXL
gap
gapLarge
defaultBorderRadius
primaryColor
secondaryColor
```

4. Always import and use the shared constants file across the application to maintain consistent UI design.

5. Do not create duplicate spacing, color, or radius constants inside features/modules.

6. Prefer predefined `Gap` constants instead of manually using `SizedBox` for spacing whenever possible.

7. Use:

```dart
color.withValues(alpha: 0.5)
```

instead of:

```dart
color.withOpacity(0.5)
```

8. Keep all reusable UI constants centralized and shared across the entire application.

9. Ensure all generated UI follows the existing design token system from the constants file.

10. Maintain consistent spacing and sizing throughout the application using the predefined constants only.
