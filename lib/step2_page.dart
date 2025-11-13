import 'package:estimateQ/auto_estimate_result_page.dart';
import 'package:flutter/material.dart';

class AutoEstimateStep2Page extends StatelessWidget {
  const AutoEstimateStep2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Automatic Estimate'),
        titleTextStyle: const TextStyle(
          fontSize: 19,
          color: Colors.orangeAccent,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Step 2: Confirm Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Here you can review and confirm the extracted details from your building plan before generating your estimate.',
              style: TextStyle(fontSize: 15, height: 1.4),
            ),
            const SizedBox(height: 30),

            // Example confirmation info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orangeAccent, width: 1),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Building Type: 2-Bedroom Bungalow"),
                  SizedBox(height: 6),
                  Text("Estimated Floor Area: 180 m²"),
                  SizedBox(height: 6),
                  Text("Detected Features: Living Room, Kitchen, 2 Toilets"),
                ],
              ),
            ),
            const SizedBox(height: 50),

            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Back"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.orangeAccent,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Generating Estimate..."),
                        backgroundColor: Colors.orangeAccent,
                        duration: Duration(seconds: 2),
                      ),
                    );

                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AutoEstimateResultPage(),
                        ),
                      );
                    });
                  },

                  icon: const Icon(Icons.calculate_outlined),
                  label: const Text("Generate Estimate"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
