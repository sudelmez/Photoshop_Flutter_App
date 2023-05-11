import 'dart:io';
import 'package:flutter/services.dart';

mixin HomeModel{
  File? selectedImage;
  String? message="";
  final url = 'http://10.0.2.2:5000/datas'; 
  Uint8List? image;
}
