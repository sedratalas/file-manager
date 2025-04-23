import 'dart:io';

import 'package:disk_space_plus/disk_space_plus.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:untitled3/core/utils/string_manager.dart';
import 'package:untitled3/widget/search_icon.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double usedSpacePercentage = 0;
  String usedLabel = '';
  String freeLabel = '';

  @override
  void initState() {
    super.initState();
    getDiskSpace();
  }

  void getDiskSpace() async {
    final result = await Process.run(
      'wmic',
      ['logicaldisk', 'get', 'size,freespace,caption'],
    );

    final lines = result.stdout.toString().trim().split('\n');

    for (var line in lines) {
      if (line.contains("C:")) {
        final parts = line.trim().split(RegExp(r'\s+'));
        if (parts.length == 3) {
          final free = double.tryParse(parts[1]) ?? 0;
          final total = double.tryParse(parts[2]) ?? 1;

          final used = total - free;
          final percentUsed = used / total;

          setState(() {
            usedSpacePercentage = percentUsed;
            usedLabel = '${(used / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
            freeLabel = '${(free / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
          });
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(StringManager.GOODMORNING,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
              ),
             // Padding(
             //   padding: const EdgeInsets.all(32.0),
             //   child: Search(),
             // ),
            ],),
            SizedBox(
              height: 50,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 220,
                  height: 250,
                  child: CircularPercentIndicator(
                      radius: 120,
                    lineWidth: 24.0,
                    percent: usedSpacePercentage,
                    circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Color(0xff9D79FF),
                    backgroundColor: Color(0xffF2F2F2),
                  ),
                ),
                Column(
                  children: [
                    Text('${(usedSpacePercentage * 100).toStringAsFixed(0)}%',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32, color: Color(0xff9D79FF))),
                    Text("Used"),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Used: $usedLabel | Free: $freeLabel", style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,

              ),),
            ),
            SizedBox(
              height: 60,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: Text("Category",
            //     textAlign: TextAlign.left,
            //     style: TextStyle(
            //         fontWeight: FontWeight.w500,
            //         fontSize: 20
            //     ),
            //   ),
            // ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 10),
                      child: Image.asset("assets/icons/files.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, left: 40, right: 20),
                      child: Text("Docs"),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Image.asset("assets/icons/photos.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, left: 20, right: 20),
                      child: Text("Photos"),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Image.asset("assets/icons/video.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, left: 20, right: 20),
                      child: Text("Videos"),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 32),
                      child: Image.asset("assets/icons/music.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, left: 18, right: 40),
                      child: Text("Music"),
                    ),
                  ],
                ),

              ],
            ),
          ],
        ),
      ),

    );
  }
}
