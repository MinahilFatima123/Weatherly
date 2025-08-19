import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF463260), // same background color
      appBar: CustomAppBar(
        title: 'Notifications',
        leadingImagePath: "assets/png/arrow-left.png",
        onLeadingTap: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(

           child: Text(
              "Your Notfications will appear here!",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,



            ),



        ),
      ),
      ),
    );
  }
}
