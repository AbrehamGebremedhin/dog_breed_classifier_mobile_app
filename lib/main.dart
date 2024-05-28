import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dog_breed_classifier/result.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dog Breed Classifier',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      home: const ImageUploadScreen(),
    );
  }
}

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({Key? key}) : super(key: key);

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image;
  bool _loading = false;
  String _loadingText = "Predicting Breed";

  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImage() async {
    setState(() {
      _loading = true;
    });

    const url =
        'http://192.168.1.3:8000/api/';

    if (_image == null) {
      // No image selected
      setState(() {
        _loading = false;
      });
      return;
    }

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(
        await http.MultipartFile.fromPath('image', _image!.path),
      );
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              image: _image!,
              predictiedBreed: data['breed'],
              confidence: data['percentage'],
              breedInformation: data['info'],
              size: data['size'],
              temperament: data['temperament'],
              exerciseNeeds: data['exercise_needs'],
              suitability: data['suitability'],
              sheddingTendencies: data['shedding'],
              trainability: data['trainability'],
              lifespan: data['lifespan'],
            ),
          ),
        );
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

    setState(() {
      _loading = false;
    });
  }

  void startLoadingAnimation() {
    Stream.periodic(const Duration(milliseconds: 500), (count) => count)
        .takeWhile((_) => _loading)
        .listen((count) {
      setState(() {
        _loadingText = "Predicting Breed" + "." * ((count % 3) + 1);
      });
    });
  }

  Color _cameraButtonBorderColor = Colors.blue;
  Color _galleryButtonBorderColor = Colors.blue;
  Color _uploadButtonBorderColor = Colors.blue;

  void _changeCameraButtonBorderColor(Color color) {
    setState(() {
      _cameraButtonBorderColor = color;
    });
  }

  void _changeGalleryButtonBorderColor(Color color) {
    setState(() {
      _galleryButtonBorderColor = color;
    });
  }

  void _changeUploadButtonBorderColor(Color color) {
    setState(() {
      _uploadButtonBorderColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dog Breed Classifier'),
      ),
      body: _loading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(_loadingText),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _image == null
                      ? const Text('No image selected.')
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(_image!, height: 200),
                        ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTapDown: (_) =>
                        _changeCameraButtonBorderColor(Colors.orange),
                    onTapUp: (_) => _changeCameraButtonBorderColor(Colors.blue),
                    onTapCancel: () =>
                        _changeCameraButtonBorderColor(Colors.blue),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        border: Border.all(
                          color: _cameraButtonBorderColor,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.camera),
                          SizedBox(width: 10),
                          Text('Take Picture'),
                        ],
                      ),
                    ),
                    onTap: () {
                      getImage(ImageSource.camera);
                    },
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTapDown: (_) =>
                        _changeGalleryButtonBorderColor(Colors.orange),
                    onTapUp: (_) =>
                        _changeGalleryButtonBorderColor(Colors.blue),
                    onTapCancel: () =>
                        _changeGalleryButtonBorderColor(Colors.blue),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        border: Border.all(
                          color: _galleryButtonBorderColor,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.photo),
                          SizedBox(width: 10),
                          Text('Select from Gallery'),
                        ],
                      ),
                    ),
                    onTap: () {
                      getImage(ImageSource.gallery);
                    },
                  ),
                  const SizedBox(height: 10),
                  _image == null
                      ? Container()
                      : GestureDetector(
                          onTapDown: (_) =>
                              _changeUploadButtonBorderColor(Colors.orange),
                          onTapUp: (_) => _changeUploadButtonBorderColor(
                              Colors.deepPurple.shade900),
                          onTapCancel: () => _changeUploadButtonBorderColor(
                              Colors.deepPurple.shade900),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              border: Border.all(
                                color: _uploadButtonBorderColor,
                                width: 2,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.upload),
                                SizedBox(width: 10),
                                Text('Predict Breed'),
                              ],
                            ),
                          ),
                          onTap: () {
                            uploadImage();
                            startLoadingAnimation();
                          },
                        ),
                ],
              ),
            ),
    );
  }
}
