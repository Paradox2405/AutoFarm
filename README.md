# AutoFarm

A Flutter companion app for an automated farming IoT device. Sensors on the farm push readings to Firebase Realtime Database, and the app shows them live so you can check on your crops from your phone.

## Features

- Live sensor dashboard: **temperature, humidity, soil moisture and light level**
- Circular gauges for current values and line charts for recent history
- Raw sensor values normalised to easy-to-read percentages
- Sign in with email and password or with Google
- Registration with name and phone number, plus a profile screen

## Tech stack

| Layer | Tech |
|---|---|
| App | Flutter (Dart), Android and iOS |
| Auth | Firebase Authentication (email/password, Google Sign-In) |
| Data | Firebase Realtime Database (sensor readings) |
| UI | `fl_chart`, `percent_indicator`, `google_fonts`, `marquee` |
| Local storage | `get_storage` |

## Project structure

```
lib/
  helpers/      colours, enums, text styles, sensor value → percentage converter
  modals/       sensor data model
  views/        home, login, register, profile, sensor detail screens
  widgets/      app bar, buttons, line chart, gauge
autofarm-fb344-default-rtdb-export.json   sample Realtime Database export
```

## Getting started

1. Install the [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart 3).
2. Create a Firebase project, enable **Email/Password** and **Google** sign-in, and create a Realtime Database.
3. Import `autofarm-fb344-default-rtdb-export.json` into the database to get the expected data shape.
4. Point the app at your project with the FlutterFire CLI:
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
5. Run it:
   ```bash
   flutter pub get
   flutter run
   ```

The IoT device (or any script) only has to write new readings to the same Realtime Database paths. The app updates as soon as they change.
