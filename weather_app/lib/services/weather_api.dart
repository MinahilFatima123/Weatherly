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

  Future<Weather> getWeather(String city) async {
    try {
      final response = await _dio.get(
        "/forecast.json",
        queryParameters: {
          "key": ApiConstants.apiKey,
          "q": city,
          "days": 7,
        },
      );

      return Weather.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.data ?? e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    } finally {
      print("Weather API request completed for city: $city");
    }
  }
}
