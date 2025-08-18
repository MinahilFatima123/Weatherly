import 'hourly_model.dart';
import 'seven_day_model.dart';

class Weather {
  final String cityName;
  final String condition;
  final String icon;
  final double temperature;
  final double minTemp;
  final double maxTemp;
  final String localtime;
  final double precipitation;
  final int humidity;
  final double windSpeed;
  final List<HourlyWeather> todayHours;
  final List<DailyWeather> forecast;

  Weather({
    required this.cityName,
    required this.condition,
    required this.icon,
    required this.temperature,
    required this.minTemp,
    required this.maxTemp,
    required this.localtime,
    required this.precipitation,
    required this.humidity,
    required this.windSpeed,
    required this.todayHours,
    required this.forecast,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {

    final forecastDay = (json['forecast']?['forecastday'] ?? [])[0];
    final List<dynamic> hourList = forecastDay?['hour'] ?? [];
    final hours = hourList.map((h) => HourlyWeather.fromJson(h)).toList();


    final lat = (json['location']?['lat'] as num?)?.toDouble() ?? 0.0;
    final lon = (json['location']?['lon'] as num?)?.toDouble() ?? 0.0;


    final forecastList = (json['forecast']?['forecastday'] as List<dynamic>?)
        ?.map((dayJson) => DailyWeather.fromJson(dayJson, lat, lon))
        .toList() ??
        [];


    final day = forecastDay?['day'] ?? {};

    return Weather(
      cityName: json['location']?['name'] ?? '',
      condition: json['current']?['condition']?['text'] ?? '',
      icon: "https:${json['current']?['condition']?['icon'] ?? ''}",
      temperature: (json['current']?['temp_c'] as num?)?.toDouble() ?? 0.0,
      localtime: json['location']?['localtime'] ?? '',
      minTemp: (day['mintemp_c'] as num?)?.toDouble() ?? 0.0,
      maxTemp: (day['maxtemp_c'] as num?)?.toDouble() ?? 0.0,
      precipitation: (json['current']?['precip_mm'] as num?)?.toDouble() ?? 0.0,
      humidity: json['current']?['humidity'] ?? 0,
      windSpeed: (json['current']?['wind_kph'] as num?)?.toDouble() ?? 0.0,
      todayHours: hours,
      forecast: forecastList,
    );
  }
}
