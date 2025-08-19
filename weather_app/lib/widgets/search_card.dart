import 'package:flutter/material.dart';

class SearchCityWeatherCard extends StatelessWidget {
  final String cityName;
  final String condition;
  final String iconUrl;
  final VoidCallback onTap;
  final bool isSelected;

  const SearchCityWeatherCard({
    super.key,
    required this.cityName,
    required this.condition,
    required this.iconUrl,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 321,
        height: 90,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: const Color(0x40FFFFFF),
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: Colors.white, width: 1.5)
              : null,
        ),
        child: Row(
          children: [

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cityName,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      condition,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 12,  color: Colors.white70,),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),



              Image.network(
                iconUrl,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.error, size: 40, color: Colors.red),
              ),



          ],
        ),
      ),
    );
  }
}
