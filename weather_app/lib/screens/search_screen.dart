import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_search.dart';
import '../widgets/city_card.dart';
import '../services/weather_api.dart';
import '../model/weather_model.dart';
import '../screens/details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> cities = ["Lahore", "Karachi", "Islamabad", "Peshawar"];
  final WeatherApiService _api = WeatherApiService();
  TextEditingController _searchController = TextEditingController();
  String? _selectedCity;
  List<String> _filteredCities = [];

  @override
  void initState() {
    super.initState();
    _filteredCities = cities;
    _searchController.addListener(() {
      _filterCities(_searchController.text);
    });
  }

  void _filterCities(String query) {
    final lowerQuery = query.toLowerCase();
    setState(() {
      _filteredCities =
          cities.where((city) => city.toLowerCase().contains(lowerQuery)).toList();
    });
  }

  void _selectCity(String city) {
    setState(() {
      _selectedCity = city;
    });
  }

  Future<Map<String, Weather>> _fetchAllCitiesWeather() async {
    Map<String, Weather> cityWeatherMap = {};
    for (String city in cities) {
      try {
        final weather = await _api.getWeather(city);
        cityWeatherMap[city] = weather;
      } catch (e) {
        print("Error fetching weather for $city: $e");
      }
    }
    return cityWeatherMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF463260),
      appBar: CustomAppBar(
        title: 'Search for City',
        leadingImagePath: "assets/png/arrow-left.png",
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 42, 15, 0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomSearchBar(
                    controller: _searchController,
                    hintText: "Search for a city",
                  ),
                ),
                const SizedBox(width: 4),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/png/circle_loc.png",
                      width: 38,
                      height: 38,
                      fit: BoxFit.contain,
                    ),
                    Image.asset(
                      "assets/png/location_icon.png",
                      width: 22,
                      height: 22,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<Map<String, Weather>>(
                future: _fetchAllCitiesWeather(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.white));
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  final cityWeatherMap = snapshot.data ?? {};

                  // Show filtered cities only
                  return ListView.builder(
                    itemCount: _filteredCities.length,
                    itemBuilder: (context, index) {
                      final city = _filteredCities[index];
                      final weather = cityWeatherMap[city];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: CityWeatherCard(
                          cityName: city,
                          condition: weather?.condition ?? "",
                          iconUrl: weather?.icon ?? "",
                          temperature: "${weather?.temperature.round() ?? 0}°",
                          isSelected: city == _selectedCity,
                          onTap: () {
                            _selectCity(city);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CityDetailsScreen(city: city),
                              ),
                            );
                          }
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
