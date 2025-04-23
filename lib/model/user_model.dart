import 'dart:io';

import 'package:dio/dio.dart';

class UserModel{
  String username;
  String imageName;
  File? image;
  UserModel({required this.username, required this.image,required this.imageName});

  UserModel copyWith({String? username, File? image, String? imageName}){
    return UserModel(
        username: username ?? this.username,
        image: image ?? this.image,
        imageName: imageName ?? this.imageName
    );
  }

  Future<FormData> toFormMap(File file) async{
    return FormData.fromMap({
      "file" : await MultipartFile.fromFile(file.path, filename: imageName),
      "username" : username,
    });
  }

  @override
  String toString() => 'UserModel(username: $username, image: $image)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username && other.image == image;
  }

  @override
  int get hashCode => username.hashCode ^ image.hashCode;

}