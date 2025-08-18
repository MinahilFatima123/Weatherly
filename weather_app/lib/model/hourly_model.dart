class HourlyWeather {
  final String time;
  final String icon;
  final double temperature;

  HourlyWeather({
    required this.time,
    required this.icon,
    required this.temperature,
  });
  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    final rawIcon = json['condition']?['icon'] ?? '';
    final iconUrl = rawIcon.startsWith('//') ? 'https:$rawIcon' : rawIcon;

    return HourlyWeather(
      time: (json['time'] ?? '').toString().split(' ').last,
      icon: iconUrl,
      temperature: (json['temp_c'] as num?)?.toDouble() ?? 0.0,
    );
  }


}
