# Stack Overflow Users App

This is a Flutter application that displays a list of Stack Overflow users, allowing for bookmarking and viewing user details. The app is built with a focus on clean architecture, scalability, and a responsive user interface.

## Features

- **User List**: Fetches and displays a list of Stack Overflow users in a continuously scrollable list.
- **Pagination**: Automatically loads more users as the user scrolls to the bottom of the list.
- **Sorting & Ordering**: Users can sort the list by reputation, creation date, name, or last modified date, in ascending or descending order.
- **User Details**: Tapping on a user card navigates to a dedicated details screen showing more information about the user.
- **Bookmarking**: Users can bookmark their favorite users. Bookmarks are persisted locally on the device.
- **Local Storage**: Bookmarked users are stored in a local SQLite database using the `sqflite` package, ensuring data is saved across app sessions.
- **Responsive UI**: The user interface is built to be responsive and adapt to various screen sizes and densities using the `flutter_screenutil` package.
- **Theming**: The app uses a centralized theme for consistent styling and easy customization of colors and text styles.

## Project Architecture

The project follows a clean architecture pattern, separating the code into three main layers: **Data**, **Presentation**, and **Network**.

### 1. Data Layer

Located in `lib/data/`.

- **`models/`**: Contains the data models (`User`, `UsersResponseModel`) that represent the API response structure, as well as enums (`OrderOption`, `SortOption`) for type-safe filtering.
- **`repos/`**: Implements the Repository Pattern (`UsersRepo`). This layer is responsible for abstracting the data source. It fetches data from the `NetworkService` and provides it to the presentation layer's cubits.
- **`local/`**: Contains the `DatabaseHelper` class, which encapsulates all database operations (create, insert, query, delete) for the bookmarking feature using `sqflite`.

### 2. Presentation Layer

Located in `lib/presentation/`.

- **State Management**: Uses `flutter_bloc` (specifically `Cubit`) for state management. Each feature (`users`, `bookmarks`) has its own cubit to manage its state.
    - `UsersCubit`: Manages the state for fetching users, including pagination, loading states, and sorting/ordering filters.
    - `BookmarksCubit`: Manages the state for the list of bookmarked users, interacting with the `DatabaseHelper`.
- **`screens/`**: Contains the main screens for each feature (`UsersScreen`, `BookmarksScreen`, `UserDetailsScreen`, `SplashScreen`).
- **`widgets/`**: Contains reusable widgets that are specific to a feature, such as `UserCard` and `FilterWidget`.

### 3. Network Layer

Located in `lib/network_service/`.

- Built on top of the `dio` package for making HTTP requests.
- `NetworkService`: A centralized class for sending API requests. It handles endpoint construction, request options, and response parsing.
- `interceptors/`: Contains `dio` interceptors, such as a `LoggerInterceptor` for logging network requests and responses during development.
- `models/`: Contains network-related models like `Endpoint`, `Result` (for handling success/error states), and `NetworkError`.

### 4. Utilities

Located in `lib/utils/`.

- **`config/`**: `app_config.dart` holds base URL and API version.
- **`theme/`**: Manages the application's visual styling.
    - `app_theme.dart`: Defines the main `ThemeData`.
    - `app_colors.dart`: Centralizes all the colors used in the app.
    - `app_text_theme.dart`: Defines the app's `TextTheme` for consistent typography.

## How to Run the Project

1.  **Clone the Repository**

    ```bash
    git clone <repository-url>
    ```

2.  **Get Dependencies**

    Navigate to the project directory and run:

    ```bash
    flutter pub get
    ```

3.  **Run the App**

    ```bash
    flutter run
    ```
