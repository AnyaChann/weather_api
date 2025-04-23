import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchWeather(String cityName) async {
  final apiKey = '9b118afe5509809ebdf24c3d1d639e13';
  final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    print('API Key: $apiKey');
  try {
    final startTime = DateTime.now();
    final response = await http.get(url);
    final endTime = DateTime.now();

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final description = data['weather'][0]['description'];
      final temperature = data['main']['temp'];
      final humidity = data['main']['humidity'];
      final pressure = data['main']['pressure'];
      final updateTime = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000);

      print('Thời tiết tại $cityName:');
      print('Mô tả: $description');
      print('Nhiệt độ: $temperature°C');
      print('Độ ẩm: $humidity%');
      print('Áp suất: $pressure hPa');
      print('Cập nhật lúc: $updateTime');
      print('Thời gian phản hồi API: ${endTime.difference(startTime).inMilliseconds} ms');
    } else {
      print('Lỗi: Không thể lấy dữ liệu thời tiết. HTTP ${response.statusCode}');
    }
  } catch (e) {
    print('Đã xảy ra lỗi: $e');
  }
}

void main(List<String> arguments) async {
  print('Nhập tên thành phố (ví dụ: Hanoi):');
  final cityName = 'Hanoi'; // Bạn có thể thay bằng input từ người dùng
  await fetchWeather(cityName);
}