import 'package:flutter/material.dart';

class CityWeatherCard extends StatelessWidget {
  final String cityName;
  final String condition;
  final String iconUrl;
  final String temperature;
  final VoidCallback onTap;
  final bool isSelected;

  const CityWeatherCard({
    super.key,
    required this.cityName,
    required this.condition,
    required this.iconUrl,
    required this.temperature,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 156,
        height: 50,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color:  const Color(0x40FFFFFF),
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: Colors.white, width: 1.5) : null,
        ),
        child: Row(
          children: [
            // Icon
            Image.network(
              iconUrl,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.error, size: 24, color: Colors.red),
            ),
            const SizedBox(width: 10),

            // City Name + Condition
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cityName,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    condition,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 5),

            // Temperature
            Text(
              temperature,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
