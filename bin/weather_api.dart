import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// Tách API key ra thành biến toàn cục
const String apiKey = '9b118afe5509809ebdf24c3d1d639e13';

/// Hàm xử lý gọi API bất đồng bộ (khuyến nghị)
Future<void> fetchWeatherAsync(String cityName) async {
  final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
  print('\n🌐 Đang gọi API (bất đồng bộ)...');

  final startTime = DateTime.now();
  final response = await http.get(url);
  final endTime = DateTime.now();

  processResponse(response, cityName, startTime, endTime, 'Bất đồng bộ');
}

/// Hàm xử lý gọi API đồng bộ (mô phỏng bằng cách chặn vòng lặp)
void fetchWeatherSync(String cityName) {
  final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
  print('\n🌐 Đang gọi API (đồng bộ mô phỏng)...');

  final client = HttpClient();
  final startTime = DateTime.now();

  client
      .getUrl(url)
      .then((request) => request.close())
      .then((response) => response.transform(utf8.decoder).join())
      .then((body) {
        final endTime = DateTime.now();
        final mockResponse = http.Response(body, 200);
        processResponse(mockResponse, cityName, startTime, endTime, 'Đồng bộ mô phỏng');
        client.close();
      })
      .catchError((e) {
        print('❌ Lỗi khi gọi API: $e');
        client.close();
      });
}

/// Hàm xử lý dữ liệu trả về từ API
void processResponse(http.Response response, String cityName, DateTime start, DateTime end, String mode) {
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    final description = data['weather']?[0]?['description'] ?? 'Không rõ';
    final temperature = data['main']?['temp'] ?? 'N/A';
    final humidity = data['main']?['humidity'] ?? 'N/A';
    final pressure = data['main']?['pressure'] ?? 'N/A';
    final windSpeed = data['wind']?['speed'] ?? 'N/A';
    final updateTime = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000).toLocal();

    print('\n📍 Thời tiết tại $cityName:');
    print('🌤 Mô tả: $description');
    print('🌡 Nhiệt độ: $temperature°C');
    print('💧 Độ ẩm: $humidity%');
    print('📈 Áp suất: $pressure hPa');
    print('🌬 Tốc độ gió: $windSpeed m/s');
    print('🕒 Cập nhật lúc: $updateTime');
    print('⚡ [$mode] Thời gian phản hồi API: ${end.difference(start).inMilliseconds} ms');
  } else {
    print('❌ Lỗi: HTTP ${response.statusCode}');
    print('📦 Nội dung lỗi: ${response.body}');
  }
}

Future<void> main(List<String> arguments) async {
  while (true) {
    stdout.write('Nhập tên thành phố (ví dụ: Hanoi, hoặc gõ "exit" để thoát): ');
    final cityName = stdin.readLineSync()?.trim();
    if (cityName == null || cityName.isEmpty) {
      print('⚠️ Tên thành phố không hợp lệ.');
      continue;
    }

    if (cityName.toLowerCase() == 'exit') {
      print('👋 Tạm biệt!');
      break;
    }

    stdout.write('Chọn chế độ chạy (1 = Bất đồng bộ, 2 = Đồng bộ mô phỏng): ');
    final mode = stdin.readLineSync()?.trim();

    if (mode == '1') {
      await fetchWeatherAsync(cityName);
    } else if (mode == '2') {
      fetchWeatherSync(cityName);
      // Chờ đợi một chút để client xử lý xong (vì đang chạy trong non-blocking)
      await Future.delayed(Duration(seconds: 3));
    } else {
      print('❌ Chế độ không hợp lệ. Vui lòng chọn 1 hoặc 2.');
    }

    print('\n---------------------------------------------\n');
  }
}
