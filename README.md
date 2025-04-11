# 🎬 CineBox – Flutter Internship Assignment for Infoware

CineBox is a fully-featured Flutter application built as part of an internship assignment for **Infoware**. The app integrates with the TMDB API to browse movies, view detailed info, search your favorite titles, and even play an in-app audio track. It also includes a fully validated user profile form and a clean, modern UI using BLoC for state management and OOP principles throughout.

---

## Video Showcase
https://youtu.be/7qNK2RZnGlk

---

## 📱 Features

### 🧠 1. Browse Movies (TMDB API)
- Fetches trending movies from TMDB API
- Displays movie posters, titles, ratings, and release dates
- Uses clean card-based layout with responsiveness

### 🔍 2. Search Functionality
- Search any movie title using TMDB API's search endpoint
- Shows real-time results as you type
- Clean UI and responsive results

### 🎞 3. Movie Detail Screen
- Navigate to a new screen on clicking any movie
- Displays full details like:
    - Overview
    - Language
    - Popularity
    - Vote count
    - Rating
    - Poster

### 🎧 4. Audio Player Screen
- Plays a local audio file from assets (`Ezio’s Family` OST 🎻)
- Full features:
    - Play / Pause
    - Forward / Rewind (±10 seconds)
    - Loop toggle
    - Volume control
    - Duration slider + current/total time

### 👤 5. Profile Form with Validation
- Form fields:
    - Name
    - Email
    - Phone
    - Gender
    - State
    - City
- All fields are fully validated with error messages:
    - Name must be at least 2 characters
    - Email must be valid
    - Phone must be 10 digits
    - Gender, State, and City must be selected

---

## 📦 Packages Used

```yaml
dependencies:
  flutter:
    sdk: flutter
    cupertino_icons: ^1.0.8
    flutter_bloc:
    http:
    audioplayers:
    flutter_dotenv:
```

---

## 🎯 Goals of This Assignment
- ✅ Follow OOP principles
- ✅ Use BLoC for scalable state management
- ✅ Write clean, reusable, and DRY code
- ✅ Demonstrate UI/UX attention to detail
- ✅ Handle forms and validations properly
- ✅ Work with external APIs (TMDB + local assets)

