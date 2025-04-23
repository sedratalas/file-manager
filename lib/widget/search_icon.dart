import 'package:flutter/material.dart';
import 'package:untitled3/screen/main_page.dart';

import '../screen/result_page.dart';

class Search extends StatefulWidget {
  final Function(String)? onSearchChanged;
   Search({Key? key, required this.onSearchChanged}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isSearch=false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
        width: isSearch? 200 : 42,
        height: 42,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Color(0xff404040)
            )
        ),
        child: Row(
          children: [
            if(!isSearch)
             IconButton(
                 onPressed: (){
                   setState(() {
                     isSearch=true;
                   });
                 },
                 icon: Image.asset("assets/icons/search.png"),
             )
            else
              Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: widget.onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  )
              ),
            if(isSearch)
              IconButton(
                  onPressed: (){
                    controller.clear();
                    setState(() {
                      isSearch = false;
                    });
                    if (widget.onSearchChanged != null) {
                      widget.onSearchChanged!("");
                    }
                  },
                  icon:Icon(Icons.close,) ,
              )

          ],
        )

    );
  }
}
// import 'package:flutter/material.dart';
//
// class Search extends StatefulWidget {
//   final Function(String)? onSearchChanged;
//
//   Search({Key? key, this.onSearchChanged}) : super(key: key);
//
//   @override
//   State<Search> createState() => _SearchState();
// }
//
// class _SearchState extends State<Search> {
//   double width = 36;
//   bool isSearch = false;
//   TextEditingController controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 300),
//       width: isSearch ? 200 : 42,
//       height: 42,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Color(0xff404040)),
//         color: Colors.white,
//       ),
//       child: Row(
//         children: [
//           if (!isSearch)
//             IconButton(
//               icon: Image.asset("assets/icons/search.png"),
//               onPressed: () {
//                 setState(() {
//                   isSearch = true;
//                 });
//               },
//             )
//           else
//             Expanded(
//               child: TextField(
//                 controller: controller,
//                 onChanged: widget.onSearchChanged,
//                 decoration: InputDecoration(
//                   hintText: 'Search...',
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 ),
//               ),
//             ),
//           if (isSearch)
//             IconButton(
//               icon: Icon(Icons.close, size: 18),
//               onPressed: () {
//                 controller.clear();
//                 setState(() {
//                   isSearch = false;
//                 });
//                 if (widget.onSearchChanged != null) {
//                   widget.onSearchChanged!(""); // clear filter
//                 }
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }
