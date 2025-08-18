import 'package:dio/dio.dart';
import '../model/weather_model.dart';
import '../model/hourly_model.dart';

class WeatherApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.weatherapi.com/v1",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  final String apiKey = "d7fbf1239dcd4dd98f554343251308";

  Future<Weather> getWeather(String city) async {
    final response = await _dio.get(
      "/forecast.json",
      queryParameters: {"key": apiKey, "q": city, "days": 7},
    );

    return Weather.fromJson(response.data);
  }
  Future<List<HourlyWeather>> todayHours(String city) async {
    final response = await _dio.get(
      "/forecast.json",
      queryParameters: {"key": apiKey, "q": city, "days": 7},
    );

    final forecastday = response.data['forecast']['forecastday'][0];
    final hours = (forecastday['hour'] as List)
        .map((h) => HourlyWeather.fromJson(h))
        .toList();

    return hours;
  }

}
