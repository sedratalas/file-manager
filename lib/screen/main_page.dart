import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/servise/user_servise.dart';


import '../model/user_model.dart';
import 'create_user_part1.dart';
PageController controller =PageController();
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}
int step = 0;
class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: 300,
            height: 300,
            child: Stepper(
              currentStep: step,
                onStepTapped: (value){
                step = value;
                controller.nextPage(
                  duration: Duration(seconds: 1),
                  curve: Curves.bounceOut,
                );
                setState(() {});
                },
                steps: [
                  Step(title: Text("name"), content: Icon(Icons.info_rounded)),
                  Step(title: Text("image"), content: Icon(Icons.person)),
                ]
            ),
          ),
          SizedBox(
            height: 400,
           child:  PageView(
              controller: controller,
              children: [CreateUserPagePartOne(), CreateUserPart2()],
            ),
          )

        ],
      ),
    );
  }
}

late UserModel user;

class CreateUserPagePartOne extends StatelessWidget {
  CreateUserPagePartOne({super.key});
  TextEditingController username = TextEditingController();
  TextEditingController imageName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: TextField(
                  controller: username,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: TextField(
                  controller: imageName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          user = UserModel(
            username: username.text,
            image: null,
            imageName: imageName.text,
          );
          // step++;
          controller.nextPage(
            duration: Duration(seconds: 1),
            curve: Curves.bounceOut,
          );
        },
      ),
    );
  }
}

class CreateUserPart2 extends StatefulWidget {
  const CreateUserPart2({Key? key}) : super(key: key);

  @override
  State<CreateUserPart2> createState() => _CreateUserPart2State();
}

class _CreateUserPart2State extends State<CreateUserPart2> {
  File? file;
  bool isActive = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: ()async{
            try{
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result != null) {
                file = File(result.files.single.path!);
                if (file.runtimeType != null) {
                  setState(() {
                    isActive = true;
                  });
                }
                log("file added");
              } else {
                // User canceled the picker
              }
            }catch(e){
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Can not access files")));
            }
          },
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child:
            file == null
                ? Text("upload your file")
                : Image.file(File(file!.path)),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: isActive,
        replacement: FloatingActionButton(
          onPressed: () {},
          child: CircularProgressIndicator(),
        ),
        child: FloatingActionButton(
            onPressed: ()async{
              if(!isActive){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("please Wait until the file uploaded"),
                      backgroundColor: Colors.blue,
                    ),
                );
              }else{
                bool status = await UserService().createNewUser(
                    user: user.copyWith(image: file),
                );
                if (status) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Mshe Alhal"),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Ma Mshe Alhal"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            }
            ) ,
      ),
    );
  }
}
