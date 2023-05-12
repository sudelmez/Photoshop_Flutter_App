import 'dart:io';
import 'package:flutter/services.dart';

mixin HomeModel{
  File? selectedImage;
  final url = 'http://10.0.2.2:5000/process'; 
  final saveurl = 'http://10.0.2.2:5000/save'; 
  Uint8List? myimage;  
}
