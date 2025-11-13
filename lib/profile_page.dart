import 'package:estimateQ/main.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        titleTextStyle: const TextStyle(
          fontSize: 19,
          color: Colors.orangeAccent,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: const Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Nothing much for now. I might add Authentication later so users can store in the cloud too',
              ),
              SizedBox(height: 20),
              Text(
                'And who knows add a status update feature for architects and engineers to share their personal designs. ',
              ),
              SizedBox(height: 20),
              Text(
                'And also use image recognition to remove any status update that is not related 😅',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
