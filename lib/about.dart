import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Me')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Hero Animation for Profile Image
            Hero(
              tag: 'profile-avatar', // Must match tag from HomeScreen
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 3,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset('assets/wasi_khan.jpg', fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // About Content
            const Text(
              'Fasih Khan',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Flutter Developer',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '• I am a passionate Flutter developer with 2+ years experience\n'
                '• Experience in building cross-platform applications.\n'
                '• Specialized in state management and animations\n'
                '• Passionate about clean architecture\n\n'
                'Contact me:\n'
                '• If you want to contact me, go back and click on Contact',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
