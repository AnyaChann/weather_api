
# 🌤 Weather CLI App (Dart + OpenWeatherMap)

A simple command-line tool written in Dart that fetches real-time weather information for any city using the OpenWeatherMap API. This app demonstrates the difference between **asynchronous (non-blocking)** and **simulated synchronous (blocking)** API calls.

---

## 🚀 Features

- ✅ Fetch current weather by city name
- 🌐 Async mode using `async/await`
- ⏳ Simulated sync mode using `HttpClient` + `Future.delayed`
- 📊 Displays:
  - Weather description
  - Temperature (°C)
  - Humidity (%)
  - Pressure (hPa)
  - Wind speed (m/s)
  - Last update time
  - API response time
- 📦 Handles API/network/JSON errors gracefully

---

## 🛠 Requirements

- Dart SDK >= 2.18
- Internet connection
- An API key from [OpenWeatherMap](https://openweathermap.org/api)

---

## 🧪 Installation

1. **Clone this repo**:

   ```bash
   git clone https://github.com/your-username/weather_cli_dart.git
   cd weather_cli_dart
   ```

2. **Install Dart SDK** (if not yet):

   [→ Dart official website](https://dart.dev/get-dart)

3. **Set your OpenWeatherMap API key**:

   Open `weather_api.dart` and replace:

   ```dart
   final apiKey = 'your_api_key_here';
   ```

4. **Run the app**:

   ```bash
   dart run
   ```

---

## 🧑‍💻 Usage

1. **Start the program**:

   ```bash
   dart run
   ```

2. **Input a city name** (e.g., `Hanoi`)

3. **Choose mode**:
   - Enter `1` → Asynchronous (non-blocking)
   - Enter `2` → Simulated synchronous (blocking)

4. **View results**: Weather info, update time, and API response duration will be displayed.

---

## 📁 Project Structure

```
weather_cli_dart/
├── weather_api.dart    # Main source file
├── README.md           # Project documentation
└── pubspec.yaml        # Dart dependencies (if used)
```

---

## 🧠 Technical Highlights

### ✅ Async API Request
- Uses `http` package and `async/await`
- Fast and non-blocking
- Tracks request duration with `DateTime.now()`

### 🔄 Simulated Sync Request
- Uses `HttpClient` to mimic sync behavior
- Adds artificial delay with `Future.delayed`
- Demonstrates difference in flow control

### 🔍 JSON Handling
- Parses JSON using `dart:convert`
- Extracts `weather`, `main`, `wind`, and `dt` fields

### ⚠️ Error Handling
- Handles:
  - `401 Unauthorized` → Invalid API key
  - `404 Not Found` → Invalid city
  - Network issues
  - Invalid or malformed JSON

---

## 📈 Future Improvements

- [ ] Search multiple cities at once
- [ ] Auto-refresh weather every X minutes
- [ ] Save search history to file or DB
- [ ] GUI version with Flutter

---

## 🛑 Common Errors

| Error | Cause | Solution |
|------|-------|----------|
| `HTTP 401` | Invalid API key | Double-check your API key |
| `HTTP 404` | City not found | Verify the city name spelling |
| Network error | No internet | Check your connection |
| JSON error | Malformed response | Check URL and API key |

---

## 📄 License

No License

---

> Made with ❤️ in Dart. Pull requests are welcome!
