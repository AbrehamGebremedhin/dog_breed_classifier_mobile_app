import 'package:flutter/material.dart';
import 'dart:io';

class ResultPage extends StatelessWidget {
  final File image;
  final String predictiedBreed;
  final double confidence;
  final String breedInformation;
  final String size;
  final String temperament;
  final String exerciseNeeds;
  final String suitability;
  final String sheddingTendencies;
  final String trainability;
  final String lifespan;

  const ResultPage({
    super.key,
    required this.image,
    required this.predictiedBreed,
    required this.confidence,
    required this.breedInformation,
    required this.size,
    required this.temperament,
    required this.exerciseNeeds,
    required this.suitability,
    required this.sheddingTendencies,
    required this.trainability,
    required this.lifespan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Page'),
        backgroundColor: Colors.grey[900], // Matching the home page theme
        leading: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: IconButton(
            key: const Key('back_button'),
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          color: Colors.grey[900], // Matching the home page theme
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    image,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Predicted Breed:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  predictiedBreed,
                  style: TextStyle(
                    color: Colors.grey[300], // Lighter shade of gray
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Confidence:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${confidence.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: Colors.grey[300], // Lighter shade of gray
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'About the breed:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  breedInformation,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[300], // Lighter shade of gray
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Size:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  size,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[300], // Lighter shade of gray
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Temperament:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  temperament,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[300], // Lighter shade of gray
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Exercise Needs:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  exerciseNeeds,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[300], // Lighter shade of gray
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Suitability for families:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  suitability,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[300], // Lighter shade of gray
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Shedding Tendecies:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  sheddingTendencies,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[300], // Lighter shade of gray
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Trainablility:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  trainability,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[300], // Lighter shade of gray
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Life span:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  lifespan,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[300], // Lighter shade of gray
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
