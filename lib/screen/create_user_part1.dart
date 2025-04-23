// import 'package:flutter/material.dart';
// import 'package:untitled3/model/user_model.dart';
//
// class CreateUserPart1 extends StatefulWidget {
//   const CreateUserPart1({Key? key}) : super(key: key);
//
//   @override
//   State<CreateUserPart1> createState() => _CreateUserPart1State();
// }
//
// class _CreateUserPart1State extends State<CreateUserPart1> {
//   TextEditingController username = TextEditingController();
//   TextEditingController imageName = TextEditingController();
//   PageController controller = PageController();
//   late UserModel user;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//          children: [
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: SizedBox(
//                width: 300,
//                child: TextField(
//                  controller: username,
//                  decoration: InputDecoration(
//                    border: OutlineInputBorder(
//                      borderRadius: BorderRadius.circular(20),
//                    ),
//                  ),
//                ),
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: SizedBox(
//                width: 300,
//                child: TextField(
//                  controller: imageName,
//                  decoration: InputDecoration(
//                    border: OutlineInputBorder(
//                      borderRadius: BorderRadius.circular(20),
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          ],
//               ),
//       ),
//       floatingActionButton: FloatingActionButton(
//           onPressed: ()async{
//             user = UserModel(
//                 username: username.text,
//                 image: null,
//                 imageName: imageName.text);
//             controller.nextPage(
//                 duration: Duration(seconds: 1),
//                 curve: Curves.bounceOut
//             );
//           }
//       ),
//     );
//   }
// }
