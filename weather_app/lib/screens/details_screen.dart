import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../services/weather_api.dart';
import '../model/weather_model.dart';
import '../widgets/seven_day_widget.dart';

class CityDetailsScreen extends StatefulWidget {
  final String city;

  const CityDetailsScreen({super.key, required this.city});

  @override
  State<CityDetailsScreen> createState() => _CityDetailsScreenState();
}

class _CityDetailsScreenState extends State<CityDetailsScreen> {
  late Future<Weather> _weatherFuture;
  final WeatherApiService _api = WeatherApiService();

  @override
  void initState() {
    super.initState();
    _weatherFuture = _api.getWeather(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF463260),
      appBar: CustomAppBar(
        title: '7 Days',
        leadingImagePath: "assets/png/arrow-left.png",
        onLeadingTap: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 42, 15, 0),
        child: FutureBuilder<Weather>(
          future: _weatherFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Failed to load data",
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text(
                  "No data available",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final w = snapshot.data!;

            return Column(
              children: [
                // Top card with current weather
                Container(
                  width: double.infinity,
                  height: 255,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0x40FFFFFF),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Weather Icon
                          Image.network(
                            w.icon,
                            width: 169,
                            height: 115,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.error,
                              size: 50,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(width: 4),
                          // Temperature Max/Min
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${w.maxTemp.round()}°",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                TextSpan(
                                  text: " / ${w.minTemp.round()}°",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 27),
                      // Row: Precipitation, Humidity, Wind
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/png/precipitation.png",
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${w.precipitation}%",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Precipitation",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/png/humidity.png",
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${w.humidity}%",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Humidity",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/png/wind_speed.png",
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${w.windSpeed} km/h",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Wind Speed",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // 7-day forecast
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: w.forecast.length,
                    itemBuilder: (context, index) {
                      final day = w.forecast[index];
                      return ForecastRow(
                        dayName: day.dayName,
                        iconUrl: day.icon,
                        condition: day.condition,
                        lat: day.lat,
                        lon: day.lon,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
