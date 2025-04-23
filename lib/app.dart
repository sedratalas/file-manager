import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/screen/create_user_part1.dart';

import 'screen/home.dart';
import 'screen/home_page.dart';
import 'screen/main_page.dart';
import 'screen/my_folder.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home:HomePage(),
      //FileExplorerPage(path: initialPath,),
    );
  }
}