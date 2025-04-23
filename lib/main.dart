import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
      DevicePreview(
          builder: (BuildContext context) => EasyLocalization(
              supportedLocales: [Locale("ar"),Locale("en")],
              fallbackLocale: Locale("en"),
              path: 'assets/translation',
              child: const MyApp()))
  );
}

