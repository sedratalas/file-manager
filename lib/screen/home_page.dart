import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'my_folder.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
final String initialPath = 'C:\\';
class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  List<Widget> pages = [Home(), FileExplorerPage(path: initialPath,)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFBFBFB),
      body: pages[currentIndex],
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(context.locale.languageCode=='ar'){
              context.setLocale(Locale("en"));
            }else{
              context.setLocale(Locale("ar"));
            }
          }),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Image.asset("assets/icons/home.png"), label: 'home',),
          NavigationDestination(icon:Image.asset("assets/icons/folder.png"), label: 'folder'),
          NavigationDestination(icon:Image.asset("assets/icons/cloud.png"), label: 'cloud'),


        ],
        backgroundColor: Color(0xffFBFBFB),
        //shadowColor: Color(0xffFBFBFB),
        indicatorColor: Color(0xffFBFBFB),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedIndex: currentIndex,
      ),
    );
  }
}
