import 'package:estimateQ/main.dart';
import 'package:flutter/material.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved'),
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
          child: Text(
            'This is where all saved calculations will be in case the user wants to revisit an old calculation',
          ),
        ),
      ),
    );
  }
}
