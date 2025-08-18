import 'package:flutter/material.dart';

class HourlyWeatherCard extends StatelessWidget {
  final String time;
  final String iconUrl;
  final String temp;

  const HourlyWeatherCard({
    super.key,
    required this.time,
    required this.iconUrl,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 99,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0x40FFFFFF), // semi-transparent white
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          Image.network(
            iconUrl,
            width: 37,
            height: 30,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 4),
          Text(
            temp,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
