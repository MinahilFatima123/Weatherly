import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../services/weather_api.dart';
import '../model/weather_model.dart';
import 'package:intl/intl.dart';
import '../widgets/hourly_forecast_widget.dart';
import '../widgets/city_card.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherApiService _api = WeatherApiService();
  String _selectedCity = "Lahore";
  final List<String> cities = ["Lahore", "Karachi", "Islamabad", "Peshawar"];
  Map<String, Weather> cityWeatherMap = {};


  late Future<Weather> _weatherFuture;

  void _selectCity(String city) {
    setState(() {
      _selectedCity = city;
      _weatherFuture = _api.getWeather(_selectedCity);
    });
  }


  @override
  void initState() {
    super.initState();
    _selectedCity = cities.first;
    _weatherFuture = _api.getWeather(_selectedCity);
    _prefetchCitiesWeather();
  }
  void _prefetchCitiesWeather() async {
    for (String city in cities) {
      try {
        final weather = await _api.getWeather(city);
        setState(() {
          cityWeatherMap[city] = weather;
        });
      } catch (e) {

        print("Error fetching weather for $city: $e");
      }
    }
  }
  void _refresh() {
    setState(() {
      _weatherFuture = _api.getWeather(_selectedCity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF463260),
      appBar: CustomAppBar(
        title: _selectedCity,
        leadingImagePath: "assets/png/homescreen_appbar_icon.png",
        trailingImagePath: "assets/png/refresh_homescreen.png",
        onLeadingTap: () {},
        onTrailingTap: _refresh,
      ),
      body: SingleChildScrollView(
      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: FutureBuilder<Weather>(
          future: _weatherFuture,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) {
              return Center(
                child: Text(
                  "Error: ${snap.error}",
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              );
            }

            final w = snap.data!;
            //final todayHours = w.todayHours;
            final date = DateTime.parse(w.localtime);
            final formattedDate = DateFormat("EEEE, dd MMMM yyyy | HH:mm").format(date);
            return Center(

              child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  w.condition,
                  style: Theme.of(context).textTheme.bodySmall,
                ),



                Image.network(
                  w.icon,
                  width: 150,
                  fit: BoxFit.contain,
                ),




                Text(
                  "${w.temperature.round()}°",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 6),


              Text(
                formattedDate,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),

                const SizedBox(height: 19),
                Container(
                  width: 294,
                  height: 95,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0x40FFFFFF), // lighter / more transparent white

                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/png/precipitation.png", width: 24, height: 24),
                          const SizedBox(height: 4),
                          Text(
                            "${w.precipitation}%",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Precipitation",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),


                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/png/humidity.png", width: 24, height: 24),
                          const SizedBox(height: 4),
                          Text(
                            "${w.humidity}%", // example: 65%
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Humidity",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),


                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/png/wind_speed.png", width: 24, height: 24),
                          const SizedBox(height: 4),
                          Text(
                            "${w.windSpeed} km/h",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Wind Speed",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height:15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left: Today
                    Text(
                      "Today",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),

                    // Right: 7 Day Forecasts (as a TextButton)
                    TextButton(
                      onPressed: () {
                        print("7 Day Forecasts tapped");
                        // 👉 later you can navigate to another screen
                      },
                      child: Text(
                        "7-Day Forecasts",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),

                SizedBox(
                  height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: w.todayHours.length,
                      itemBuilder: (context, index) {
                        final hour = w.todayHours[index];
                        return HourlyWeatherCard(
                          time: hour.time,
                          iconUrl: hour.icon,
                          temp: "${hour.temperature}°",
                        );
                      },
                    ),


                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      "Other Cities",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),


                    IconButton(
                      onPressed: () {

                      },
                      icon: Image.asset(
                        "assets/png/plus_home.png",
                        width: 11.67,
                        height: 11.67,
                        fit: BoxFit.contain,
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      final city = cities[index];
                      final weather = cityWeatherMap[city]; // Weather object per city
                      return CityWeatherCard(
                        cityName: city,
                        condition: weather?.condition ?? "",
                        iconUrl: weather?.icon ?? "",
                        temperature: "${weather?.temperature.round() ?? 0}°",
                        isSelected: city == _selectedCity,
                        onTap: () => _selectCity(city),
                      );
                    },
                  ),
                )






              ],
              ),
            );
          },
        ),
      ),
      ),
    );
  }
}
