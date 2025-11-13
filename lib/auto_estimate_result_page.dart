import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutoEstimateResultPage extends StatefulWidget {
  const AutoEstimateResultPage({super.key});

  @override
  State<AutoEstimateResultPage> createState() => _AutoEstimateResultPageState();
}

class _AutoEstimateResultPageState extends State<AutoEstimateResultPage> {
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    final headRoom = 3;
    final totalWallLength = 40;
    final lintelHeight = 0.225;
    final windowArea = 1.2 * 1.2;
    final totalOpenings = 2;
    final blockArea = 0.45 * 0.225;
    final allowance = 1.25;

    final totalWallArea = totalWallLength * (headRoom - lintelHeight);
    final totalOpeningArea = windowArea * totalOpenings;
    final netWallArea = totalWallArea - totalOpeningArea;
    final quantityOfBlocks = netWallArea / blockArea;
    final blockPlusAllowance = quantityOfBlocks * allowance;

    final resultData = {'multiply': totalWallArea.toString()};

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
              "Estimation Result",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "Assumptions",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("◼ Building height = 3 meters"),
                Text("◼ Concrete block = 6 inches Hollow"),
                Text("◼ Allowance = 25 %"),
                Text("◼ Mortar joint thickness = 15 mm"),
                Text("◼ Water to cement ratio = 0.45"),
                Text("◼ Wall plaster thickness = 15 mm"),
                Text("◼ Mortar mix ratio = 1 : 5"),
                Text("◼ Concrete mix ratio = 1 : 2 : 4"),
                Text("◼ Tile bed thickness = 20 mm"),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  "Quantity of Blocks:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  " ${blockPlusAllowance.round()} Blocks",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            // Mortar details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Block Laying Mortar:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Text(
                      "   Cement:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " ${blockPlusAllowance.round()} Blocks",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "   Sand:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " ${blockPlusAllowance.round()} Blocks",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "   Water:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " ${blockPlusAllowance.round()} Blocks",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Tile quantity
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tile Quantity:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Text(
                      "   Floor tile quantity:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " ${blockPlusAllowance.round()} Blocks",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "   Skirting tile quantity:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " ${blockPlusAllowance.round()} Blocks",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Tile Bed
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tile Bed/Base:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Text(
                      "   Cement:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " ${blockPlusAllowance.round()} Blocks",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "   Sand:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " ${blockPlusAllowance.round()} Blocks",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Tile Bed
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tile cement paste/slurry:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Text(
                      "   Cement:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " ${blockPlusAllowance.round()} Blocks",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Skirting mortar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Skirting tile mortar:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Text(
                      "   Cement:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " ${blockPlusAllowance.round()} Blocks",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "   Sand:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " ${blockPlusAllowance.round()} Blocks",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "   Water:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " ${blockPlusAllowance.round()} Blocks",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "PVC ceiling:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  " ${blockPlusAllowance.round()} Blocks",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Lintel and Roof Concrete:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  "⚠ Warning: This part is Structural and should be ignored for non-professionals.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 5),

                Row(
                  children: [
                    const Text(
                      "   Cement:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " ${blockPlusAllowance.round()} Blocks",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "   Sand:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " ${blockPlusAllowance.round()} Blocks",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "   Water:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " ${blockPlusAllowance.round()} Blocks",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),

            const Text(
              "Final Result (to be saved)",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...resultData.entries.map((entry) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    entry.value,
                    style: const TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 15,
                    ),
                  ),
                ],
              );
            }).toList(),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _isSaved
                    ? null
                    : () async {
                        final prefs = await SharedPreferences.getInstance();
                        for (var entry in resultData.entries) {
                          await prefs.setString(entry.key, entry.value);
                        }
                        setState(() {
                          _isSaved = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Result saved successfully!"),
                            backgroundColor: Colors.orangeAccent,
                          ),
                        );
                      },
                icon: const Icon(Icons.save),
                label: Text(_isSaved ? "Saved" : "Save Result"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 45),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
