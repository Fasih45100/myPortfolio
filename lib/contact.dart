import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDarkMode ? Colors.blue[200] : Colors.blue[800];

    return Scaffold(
      appBar: AppBar(title: const Text("Contact Me"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Text(
                          'Get in Touch',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildContactTile(
                          icon: Icons.email,
                          title: 'Email',
                          subtitle: 'fasihullah45100@gmail.com',
                          onTap: _launchEmail,
                          iconColor: iconColor,
                        ),
                        _buildContactTile(
                          icon: Icons.phone,
                          title: 'WhatsApp',
                          subtitle: '+923085344451',
                          onTap: _launchPhone,
                          iconColor: iconColor,
                        ),
                        _buildContactTile(
                          icon: Icons.link,
                          title: 'Portfolio',
                          subtitle: 'https://github.com/Fasih45100',
                          onTap: _launchPortfolio,
                          iconColor: iconColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text('Find me on', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIcon(
                      icon: Icons.facebook,
                      onPressed:
                          () => _launchSocial(
                            'fb://profile/fasih',
                            'https://www.facebook.com/share/15WKJfaFF4/',
                          ),
                    ),
                    _buildSocialIcon(
                      icon: Icons.code,
                      onPressed:
                          () => _launchSocial(
                            '',
                            'https://github.com/Fasih45100',
                          ),
                    ),
                    _buildSocialIcon(
                      icon: Icons.linked_camera,
                      onPressed:
                          () => _launchSocial(
                            'linkedin://profile/fasih',
                            'https://linkedin.com/in/example',
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: Icon(icon),
      color: Theme.of(context).colorScheme.primary,
      iconSize: 30,
      onPressed: onPressed,
    );
  }

  // Launcher Methods
  Future<void> _launchEmail() async {
    final uri = Uri.parse(
      'mailto:fasih@example.com?subject=Portfolio%20Contact',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchPhone() async {
    final uri = Uri.parse('tel:+923085344451');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchPortfolio() async {
    final uri = Uri.parse('https://fasihgithub.com');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchSocial(String appUrl, String webUrl) async {
    final appUri = Uri.tryParse(appUrl);
    final webUri = Uri.parse(webUrl);

    try {
      if (appUri != null && await canLaunchUrl(appUri)) {
        await launchUrl(appUri);
      } else {
        await launchUrl(webUri);
      }
    } catch (e) {
      await launchUrl(webUri);
    }
  }
}
