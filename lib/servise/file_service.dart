import 'package:dio/dio.dart';

import '../model/file_model.dart';

class FileUploadService{
  Dio dio = Dio();
  late Response response;
  String baseUrl = "https://httpbin.org/post";

  Future<bool> uploadFile({required FileUploadModel model})async{
    try{
      response = await dio.post(baseUrl,
        data:await model.toFormData(),
        onSendProgress: (sent, total) {
        final progress = (sent / total * 100).toStringAsFixed(1);
        print("Upload Progress: $progress%");
      },
      );
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }
}