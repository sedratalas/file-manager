import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSearchField(),
          ],
        ),
      ),
    );
  }
  Widget _buildSearchField(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 340,
        height: 51,
        decoration: BoxDecoration(
            color: Color(0xffF8F8F8),
            borderRadius: BorderRadius.circular(44),
            boxShadow: [
              BoxShadow(
                color: Color(0xffC9C9C9),
                offset: Offset(3, 3),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ]
        ),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffF8F8F8),
            suffixIcon: Icon(Icons.search, color: Colors.grey,),
            hintText: "Search ..",
            hintStyle: TextStyle(
              color: Color(0xff989898),
              fontSize: 14,
            ),
            contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(44),
              borderSide: BorderSide(
                color: Color(0xffF8F8F8),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(44),
              borderSide: BorderSide(
                color: Color(0xffF8F8F8),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(44),
              borderSide: BorderSide(
                color: Color(0xffF8F8F8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
