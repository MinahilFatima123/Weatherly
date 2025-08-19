import 'package:dio/dio.dart';
import '../model/weather_model.dart';
import '../constants/keys.dart';

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
    try {
      final response = await _dio.get(
        "/forecast.json",
        queryParameters: {   "key": ApiConstants.apiKey, "q": city, "days": 7},
      );


      return Weather.fromJson(response.data);

    } catch (e) {
      throw Exception("Failed to fetch weather: $e");
    }
  }
}
