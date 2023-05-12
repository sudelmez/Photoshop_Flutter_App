import 'dart:io';
import 'dart:typed_data';
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

  Future<http.StreamedResponse>? streamedResponse;
  http.StreamedResponse? streamedResponse2;
  
  
  getImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    selectedImage = pickedImage != null ? File(pickedImage.path) : null;
    setState(() {});
  }

  Future<Uint8List>? uploadImage() async {
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
    streamedResponse = request.send();

    streamedResponse2= await streamedResponse;
    return streamedResponse2!.stream.toBytes();
  }


  // storeImage() {
  //   final request = http.MultipartRequest("POST", Uri.parse(saveurl));
  //   final headers = {'Content-type': 'multipart/form-data'};
  //   (myimage != null)
  //       ? request.files.add(http.MultipartFile(
  //           'image',
  //           selectedImage!.readAsBytes().asStream(),
  //           selectedImage!.lengthSync(),
  //           filename: selectedImage!.path.split('/').last))
  //       : null;
  //   request.headers.addAll(headers);
  //   final response = request.send();
  //   setState(() {});
  // }

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
                  (myimage!= null) ?  Image.memory(myimage?? Uint8List(256)) : const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: (selectedImage!=null) ? () async {
                        myimage=await uploadImage();
                        setState(() {});
                      } : null,
                      child: const Text("upload photo")),
                  // ElevatedButton(
                  //     onPressed: (myimage!=null) ? () {storeImage;} : null, child: const Text("store photo")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

