import 'package:estimate_q/widgets/glass_nav_bar.dart';
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
  int _currentIndex = 0; // 👈 Changed to 1 (Tools page as default)

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
    // 👇 Only start animation if state is not already set
    if (!_movedUp && !_showTyping) {
      _startAnimation();
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
  }

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
    super.build(context); // 👈 Needed for AutomaticKeepAliveClientMixin
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
                size: 17,
                color: Colors.orangeAccent,
              ),
              onPressed: () => _navigateToSettings(context),
            ),
          ],
        ),
        toolbarHeight: 40,
        titleTextStyle: const TextStyle(
          fontSize: 17,
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
                    // duration: const Duration(milliseconds: 200),
                    // opacity: _visible ? 1.0 : 0.0,
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

// 👇 Add AutomaticKeepAliveClientMixin to other pages if you want to preserve their state too
class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tools'),
        automaticallyImplyLeading: false,
      ),
      body: const Center(child: Text('Tools Page Content')),
    );
  }
}

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
        title: const Text('Bot Assistant'),
        automaticallyImplyLeading: false,
      ),
      body: const Center(child: Text('Bot Assistant Page Content')),
    );
  }
}

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
        automaticallyImplyLeading: false,
      ),
      body: const Center(child: Text('Saved Page Content')),
    );
  }
}

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
        automaticallyImplyLeading: false,
      ),
      body: const Center(child: Text('Profile Page Content')),
    );
  }
}

// Settings Page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
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
              title: Text('Account Settings'),
              subtitle: Text('Manage your account preferences'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.orange),
              title: Text('Notifications'),
              subtitle: Text('Configure notification settings'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            ListTile(
              leading: Icon(Icons.security, color: Colors.orange),
              title: Text('Privacy & Security'),
              subtitle: Text('Manage your privacy settings'),
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

// Auto Estimate Page
class AutoEstimatePage extends StatelessWidget {
  const AutoEstimatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Automatic Estimate'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Automatic Estimate Calculation',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'This feature will automatically calculate material quantities and costs based on your project details.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animations/bot2.json',
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Automatic Calculation Features:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildFeatureItem('📐 Smart dimension analysis'),
                    _buildFeatureItem('🧮 Automatic quantity calculation'),
                    _buildFeatureItem('💰 Real-time cost estimation'),
                    _buildFeatureItem('📊 Material optimization'),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add your automatic calculation logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Start Automatic Calculation',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

// Manual Estimate Page
class ManualEstimatePage extends StatelessWidget {
  const ManualEstimatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual Estimate'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manual Estimate Calculation',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter your project details manually for precise control over material quantities and costs.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  _buildInputField('Project Name', 'Enter project name'),
                  _buildInputField('Length (m)', 'Enter length'),
                  _buildInputField('Width (m)', 'Enter width'),
                  _buildInputField('Height (m)', 'Enter height'),
                  _buildInputField('Material Type', 'Select material'),
                  _buildInputField('Quantity', 'Enter quantity'),
                  _buildInputField('Unit Price', 'Enter unit price'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Clear form logic
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.orange),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Clear',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Calculate logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Calculate',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.orange),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
