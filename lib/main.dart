import 'package:ffffffff/about.dart';
import 'package:ffffffff/contact.dart';
import 'package:ffffffff/model/skill.dart';
import 'package:ffffffff/provider/theme_provider.dart';
import 'package:ffffffff/service/api_service.dart';
import 'package:ffffffff/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Portfolio',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const HomeScreen(),
      routes: {
        '/about': (context) => const About(),
        '/contact': (context) => const Contact(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Portfolio'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileSection(isDarkMode),
              _buildSkillsSection(context, isDarkMode),
              _buildActionButtons(context, isDarkMode),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(bool isDarkMode) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Hero(
          tag: 'profile-avatar',
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isDarkMode ? Colors.blue[300]! : Colors.blue[700]!,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset('assets/wasi_khan.jpg', fit: BoxFit.cover),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Fasih',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        Text(
          "Flutter Developer",
          style: TextStyle(
            fontSize: 18,
            color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
          ),
        ),
        const SizedBox(height: 30),
        _buildSocialIcons(isDarkMode),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildSocialIcons(bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(Icons.code, isDarkMode),
        _buildSocialIcon(Icons.link, isDarkMode),
        _buildSocialIcon(Icons.email, isDarkMode),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: isDarkMode ? Colors.blueGrey[800] : Colors.blue[500],
        child: IconButton(
          icon: Icon(icon),
          color: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context, bool isDarkMode) {
    return FutureBuilder<List<Skill>>(
      future: ApiService.fetchSkills(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerLoading();
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Failed To Load skills',
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    _buildSkillsSection(context, isDarkMode);
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Text(
                  'My Skills',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final skill = snapshot.data![index];
                    return _buildSkillCard(skill, isDarkMode);
                  },
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSkillCard(Skill skill, bool isDarkMode) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 140,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.blueGrey[800] : Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            duration: const Duration(microseconds: 500),
            opacity: 1,
            child: Text(
              skill.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: skill.proficiency / 100,
            backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey[300],
            color: Colors.blue,
            minHeight: 8,
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 12,
              color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
            ),
            child: Text("${skill.proficiency}%"),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          _buildActionButton(
            context,
            "About Me",
            Icons.person,
            '/about',
            isDarkMode,
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            context,
            "Contact",
            Icons.email,
            '/contact',
            isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text,
    IconData icon,
    String routeName,
    bool isDarkMode,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          foregroundColor: isDarkMode ? Colors.white : Colors.blue,
          backgroundColor: isDarkMode ? Colors.blueGrey[800] : Colors.blue[50],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (_, __, ___) {
                switch (routeName) {
                  case '/about':
                    return const About();
                  case '/contact':
                    return const Contact();
                  default:
                    return const About();
                }
              },
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
