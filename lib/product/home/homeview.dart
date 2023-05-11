import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:photoshop_trial/product/home/home_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeModel {
  getImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    selectedImage = pickedImage != null ? File(pickedImage.path) : null;
    setState(() {});
  }

  uploadImage() {
    final request = http.MultipartRequest("POST", Uri.parse(url));
    final headers = {'Content-type': 'multipart/form-data'};
    (selectedImage != null)
        ? request.files.add(http.MultipartFile(
            'image',
            selectedImage!.readAsBytes().asStream(),
            selectedImage!.lengthSync(),
            filename: selectedImage!.path.split('/').last))
        : null;
    request.headers.addAll(headers);
    final response = request.send();
    setState(() {});
  }

  getNewImage() async {
    final getresponse = await http.get(Uri.parse(url));
    image = getresponse.bodyBytes;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: const Icon(Icons.ads_click),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              selectedImage == null
                  ? const Text("Click to upload the image")
                  : Image.file(selectedImage!),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: uploadImage,
                      child: const Text("upload photo")),
                  ElevatedButton(
                      onPressed: getNewImage, child: const Text("edit photo")),
                ],
              ),
              (image != null)
                  ? SizedBox(
                      width: 250,
                      height: 250,
                      child: Image.network("http://10.0.2.2:5000/datas"),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
