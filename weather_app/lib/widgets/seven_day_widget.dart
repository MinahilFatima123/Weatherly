import 'package:flutter/material.dart';

class ForecastRow extends StatelessWidget {
  final String dayName;
  final String iconUrl;
  final String condition;
  final double lat;
  final double lon;

  const ForecastRow({
    super.key,
    required this.dayName,
    required this.iconUrl,
    required this.condition,
    required this.lat,
    required this.lon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF463260),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [

          SizedBox(
            width: 90,
            child: Text(
              dayName,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ),


          SizedBox(
            width: 57,
            height: 57,
            child: Image.network(
              iconUrl,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.error, size: 30, color: Colors.red),
            ),
          ),

          const SizedBox(width: 8),


          Expanded(
            child: Text(
              condition,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                color: Colors.white70,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),


          SizedBox(
            width: 110,
            child: Text(
              "${lat >= 0 ? '+' : '-'}${lat.toStringAsFixed(2)} "
                  "${lon >= 0 ? '+' : '-'}${lon.toStringAsFixed(2)}",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 12),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
