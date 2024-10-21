import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  InputImage? inputImage;

  late FaceDetector faceDetector;
  @override
  void initState() {
    faceDetector = FaceDetector(
        options: FaceDetectorOptions(
            enableClassification: true,
            enableContours: true,
            enableLandmarks: true,
            enableTracking: true,
            performanceMode: FaceDetectorMode.accurate));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputImage == null
                ? ElevatedButton(
                    onPressed: () async {
                      var image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      inputImage = InputImage.fromFile(File(image!.path));
                      setState(() {});
                    },
                    child: const Text("Choose Image"),
                  )
                : CircleAvatar(
                    radius: 200,
                    foregroundImage: FileImage(File(inputImage!.filePath!)),
                  ),
            ElevatedButton(
              onPressed: () async {
                List<Face> faces = await faceDetector.processImage(inputImage!);
                print(faces.length);
                for (Face face in faces) {
                  
                  if (face.smilingProbability != null) {
                    double? isSmiling = face.smilingProbability;
                    print(isSmiling);
                    if (isSmiling! > .5) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Smiling")));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Not Smiling")));
                    }
                  }
                }
              },
              child: const Text("Detect"),
            ),
          ],
        ),
      ),
    );
  }
}
