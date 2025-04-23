import 'dart:io';

import 'package:dio/dio.dart';

class FileUploadModel{
  final File file;

  FileUploadModel({required this.file});

  Future<FormData> toFormData() async{
    return FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, 
          filename: file.path.split(Platform.pathSeparator).last
      ),
    });
  }
}