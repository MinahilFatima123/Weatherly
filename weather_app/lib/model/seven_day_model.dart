class DailyWeather {
  final String dayName;
  final String condition;
  final String icon;
  final double lat;
  final double lon;

  DailyWeather({
    required this.dayName,
    required this.condition,
    required this.icon,
    required this.lat,
    required this.lon,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json, double lat, double lon) {
    final dateStr = json['date'] ?? '';
    final DateTime date = DateTime.tryParse(dateStr) ?? DateTime.now();
    final dayName = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'][date.weekday-1];

    return DailyWeather(
      dayName: dayName,
      condition: json['day']?['condition']?['text'] ?? '',
      icon: "https:${json['day']?['condition']?['icon'] ?? ''}",
      lat: lat,
      lon: lon,
    );
  }
}
