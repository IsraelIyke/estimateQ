import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        titleTextStyle: const TextStyle(
          fontSize: 19,
          color: Colors.orangeAccent,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.orangeAccent,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.person, color: Colors.orange),
              title: Text('General Settings'),
              subtitle: Text('Manage your preferences like theme'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),

            ListTile(
              leading: Icon(Icons.help, color: Colors.orange),
              title: Text('Help & Support'),
              subtitle: Text('Get help and contact support'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.orange),
              title: Text('About'),
              subtitle: Text('App version and information'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}
