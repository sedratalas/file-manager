import 'package:flutter/material.dart';

class CreateUserPart2 extends StatefulWidget {
  const CreateUserPart2({Key? key}) : super(key: key);

  @override
  State<CreateUserPart2> createState() => _CreateUserPart2State();
}

class _CreateUserPart2State extends State<CreateUserPart2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          //child: ,
        ),
      ),
    );
  }
}
