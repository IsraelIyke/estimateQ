import 'package:estimateQ/auto_estimate_page.dart';
import 'package:estimateQ/bot_assistant_page.dart';
import 'package:estimateQ/manual_estimate_page.dart';
import 'package:estimateQ/profile_page.dart';
import 'package:estimateQ/saved_page.dart';
import 'package:estimateQ/settings_page.dart';
import 'package:estimateQ/tools_page.dart';
import 'package:estimateQ/widgets/glass_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import "package:lottie/lottie.dart";
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'estimateQ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const MainNavigator(),
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  // 👇 Using PageStorage to save state for each page
  final List<Widget> _pages = [
    const MyHomePage(title: 'estimateQ'),
    const ToolsPage(),
    const BotAssistantPage(),
    const SavedPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageStorage(
        bucket: PageStorageBucket(),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: GlassNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
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
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool _visible = true;
  bool _movedUp = false;
  bool _showTyping = false;
  bool _showText = false;
  bool _showFirstButton = false;
  bool _showSecondButton = false;

  // 👇 Add this to preserve state
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadAnimationState();
  }

  // Load animation state from shared preferences
  Future<void> _loadAnimationState() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Check if animation has already been shown
      final animationShown = prefs.getBool('animation_shown') ?? false;

      if (animationShown) {
        // If animation was shown before, set all states to their final values
        if (mounted) {
          setState(() {
            _movedUp = true;
            _showTyping = false;
            _showText = true;
            _showFirstButton = true;
            _showSecondButton = true;
          });
        }
      } else {
        // If animation hasn't been shown, start it
        _startAnimation();
      }
    } catch (e) {
      // If there's any error, start the animation
      _startAnimation();
    }
  }

  // Save animation state to shared preferences
  Future<void> _saveAnimationState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('animation_shown', true);
    } catch (e) {
      print('Error saving animation state: $e');
    }
  }

  Future<void> _startAnimation() async {
    // Blink 3 times
    for (int i = 0; i < 3; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return;
      setState(() => _visible = !_visible);

      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return;
      setState(() => _visible = !_visible);
    }

    // Move text upward
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    setState(() => _movedUp = true);

    // Wait for the move animation, then show typing
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _showTyping = true);
  }

  // Called when typing finishes
  Future<void> _showButtons() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    setState(() => _showText = true);

    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() => _showFirstButton = true);

    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _showSecondButton = true);

    // 👇 Save animation state when all animations are complete
    _saveAnimationState();
  }

  // ... rest of your existing methods remain the same
  void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsPage()),
    );
  }

  void _navigateToAutoEstimate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AutoEstimatePage()),
    );
  }

  void _navigateToManualEstimate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ManualEstimatePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title),
            IconButton(
              icon: const Icon(
                Icons.settings,
                size: 19,
                color: Colors.orangeAccent,
              ),
              onPressed: () => _navigateToSettings(context),
            ),
          ],
        ),
        toolbarHeight: 55,
        titleTextStyle: const TextStyle(
          fontSize: 19,
          color: Colors.orangeAccent,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedAlign(
                  duration: const Duration(seconds: 1),
                  alignment: _movedUp
                      ? const Alignment(0, -0.5)
                      : Alignment.center,
                  curve: Curves.easeOut,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 90,
                          width: 160,
                          child: Lottie.asset('assets/animations/bot2.json'),
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
                          'I am estimateQ, a simple tool for getting Building material quantities and cost.',
                          speed: const Duration(milliseconds: 60),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      totalRepeatCount: 1,
                      onFinished: _showButtons,
                    ),
                  ),
                const SizedBox(height: 20),

                if (_showText)
                  DefaultTextStyle(
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'How may I help you today?',
                          speed: const Duration(milliseconds: 60),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      totalRepeatCount: 1,
                      onFinished: _showButtons,
                    ),
                  ),
                const SizedBox(height: 20),
                // Text
                AnimatedOpacity(
                  opacity: _showText ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1200),
                  child: _showText
                      ? const Text(
                          "Assist with running",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 12),
                // First button fade-in
                AnimatedOpacity(
                  opacity: _showFirstButton ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1200),
                  child: _showFirstButton
                      ? ElevatedButton(
                          onPressed: () => _navigateToAutoEstimate(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 17,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Automatic estimate calculation',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 12),
                // Second button fade-in
                AnimatedOpacity(
                  opacity: _showSecondButton ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1200),
                  child: _showSecondButton
                      ? OutlinedButton(
                          onPressed: () => _navigateToManualEstimate(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 17,
                            ),
                            side: const BorderSide(color: Colors.orange),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Manual estimate calculation',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
