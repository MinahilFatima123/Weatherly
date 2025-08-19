import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF463260),
      appBar: CustomAppBar(
        title: 'Feedback',
        // leadingImagePath: "assets/png/arrow-left.png",
        // onLeadingTap: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Your feedback can help everyone see more accurate weather conditions!",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),

            // First row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          "assets/png/circle_feedback.png",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          "assets/png/sunny.png",
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Sunny",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          "assets/png/circle_feedback.png",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          "assets/png/cloudy.png",
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Cloudy",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          "assets/png/circle_feedback.png",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          "assets/png/rainy.png",
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Rain",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Second row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          "assets/png/circle_feedback.png",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          "assets/png/snow.png",
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Snow",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          "assets/png/circle_feedback.png",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          "assets/png/storm.png",
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Storm",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          "assets/png/circle_feedback.png",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          "assets/png/thunder.png",
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Thunder",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 150),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(387, 41),
                backgroundColor: Colors.white.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                elevation: 0,
              ),
              child: Text(
                'Submit',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
