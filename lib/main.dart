import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import "package:lottie/lottie.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'estimateQ Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const MyHomePage(title: 'estimateQ Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool _visible = true;
  bool _movedUp = false;
  bool _showTyping = false;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  Future<void> _startAnimation() async {
    // Blink 3 times
    for (int i = 0; i < 3; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() => _visible = !_visible);
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() => _visible = !_visible);
    }

    // Move text upward
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() => _movedUp = true);

    // Wait for the move animation, then show typing
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _showTyping = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        toolbarHeight: 40,
        titleTextStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedAlign(
                duration: const Duration(seconds: 1),
                alignment: _movedUp
                    ? const Alignment(10, -0.5)
                    : Alignment.center,
                curve: Curves.easeOut,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _visible ? 1.0 : 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'hello',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Lottie.asset('assets/animations/wink.json'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_showTyping)
                DefaultTextStyle(
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'I am estimateQ, a simple CV tool for getting Building material quantity and cost.',
                        speed: const Duration(milliseconds: 80),
                        textAlign: TextAlign.center,
                      ),
                      TypewriterAnimatedText(
                        'How may I help you today?',
                        speed: const Duration(milliseconds: 80),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    totalRepeatCount: 1,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
