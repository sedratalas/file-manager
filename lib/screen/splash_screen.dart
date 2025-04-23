import 'package:flutter/material.dart';
import 'package:untitled3/screen/home.dart';

class SplashScreen extends StatelessWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient:LinearGradient(colors: [Color(0xff7747FD),Color(0xff9D79FF)],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
    )
    ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/splash_file.png"),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Manage your files\n   in a simple way",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("You could integrate your local files\n     with the files in cloud storage",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                  gradient:LinearGradient(colors: [Color(0xffFDA8FE),Color(0xffFC69FF)],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  )
              ),
              child: IconButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>Home())
                    );
                  },
                  icon: Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 30,)),
            )

          ],
        ),
      ),
    );
  }
}
