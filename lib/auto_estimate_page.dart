import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Example: import your Step 2 page
import 'step2_page.dart'; // make sure this file exists

class AutoEstimatePage extends StatefulWidget {
  const AutoEstimatePage({super.key});

  @override
  State<AutoEstimatePage> createState() => _AutoEstimatePageState();
}

class _AutoEstimatePageState extends State<AutoEstimatePage> {
  File? _selectedImage;

  // Function to pick image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'The automatic building quantity estimator tool simply processes your building plans and generates a detailed bill of quantities in minutes.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),

              // Steps Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStepChipActive("Step 1"),
                  _buildStepChip("Step 2"),
                  _buildStepChip("Result"),
                ],
              ),
              const SizedBox(height: 20),

              const Text(
                "Plan Upload",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
              const Text("Let's start by uploading your building plan."),
              const SizedBox(height: 20),

              // 👉 Image Upload Section
              Center(
                child: ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.upload_file),
                  label: const Text("Choose Building Plan Image"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // 👉 Image Preview Section
              if (_selectedImage != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Preview & Confirm",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(_selectedImage!, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Is this the correct plan? If yes, click Next to proceed.",
                    ),
                  ],
                )
              else
                const Text("No image selected yet."),
              const SizedBox(height: 40),

              // Next Button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: _selectedImage != null
                        ? () {
                            // Show SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Processing Image..."),
                                backgroundColor: Colors.orangeAccent,
                                duration: Duration(seconds: 2),
                              ),
                            );

                            // Wait a short time before navigating
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AutoEstimateStep2Page(),
                                ),
                              );
                            });
                          }
                        : null,
                    // disabled if no image
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("Next"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.orangeAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepChipActive(String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _buildStepChip(String label) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 199, 137),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
