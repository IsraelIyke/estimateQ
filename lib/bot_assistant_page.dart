import 'package:estimateQ/main.dart';
import 'package:flutter/material.dart';

class BotAssistantPage extends StatefulWidget {
  const BotAssistantPage({super.key});

  @override
  State<BotAssistantPage> createState() => _BotAssistantPageState();
}

class _BotAssistantPageState extends State<BotAssistantPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Bot'),
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
            'I will integrate a chat bot here for users to ask construction related question',
          ),
        ),
      ),
    );
  }
}
