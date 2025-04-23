import 'package:dio/dio.dart';

import '../model/user_model.dart';

class UserService{
  Dio dio = Dio();
  late Response response;
  String baseURL = "https://httpbin.org/post";

  Future<bool> createNewUser({required UserModel user})async{
    try{
      response = await dio.post(
          baseURL,
          data: await user.toFormMap(user.image!),
      onSendProgress: (count, total) {
        print((count / total) * 100);
      });
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }
}