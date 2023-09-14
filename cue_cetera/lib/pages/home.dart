import 'package:flutter/material.dart';

import 'package:cue_cetera/pages/info.dart';
import 'package:cue_cetera/pages/settings.dart';
import 'package:cue_cetera/pages/record_video.dart';
import 'package:cue_cetera/pages/upload_video.dart';

class Home extends StatefulWidget {
  final String title;
  const Home(this.title, {Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState(title);
}

class _HomeState extends State<Home> {
  String title;
  _HomeState(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 172, 158, 158),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 172, 158, 158),
        centerTitle: true,
        toolbarHeight: 100,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Lusteria',
            color: Color.fromARGB(255, 66, 39, 39),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(50),
          ),
          color: Color.fromARGB(255, 66, 39, 39),
        ),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            const Expanded(
              flex: 4,
              child: SizedBox(
                width: double.infinity,
              ),
            ),
            Container(
              alignment: Alignment.center,
              //padding: EdgeInsets.only(top: 80),
              child: const Text(
                'Choose an Option',
                style: TextStyle(
                  fontFamily: 'Lusteria',
                  color: Color.fromARGB(255, 212, 195, 195),
                  fontSize: 37,
                ),
              ),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 30),
              child: const Text(
                'Begin your exploration',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  color: Color.fromARGB(255, 172, 158, 158),
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const Expanded(
              flex: 4,
              child: SizedBox(
                width: double.infinity,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UploadVideo()),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(250, 100),
                textStyle: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: const Color.fromARGB(255, 212, 195, 195),
                foregroundColor: const Color.fromARGB(255, 66, 39, 39),
                elevation: 0,
                shadowColor: const Color.fromARGB(255, 66, 39, 39),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text("UPLOAD VIDEO"),
            ),
            const Expanded(
              flex: 4,
              child: SizedBox(
                width: double.infinity,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecordVideo()),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(250, 100),
                textStyle: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: const Color.fromARGB(255, 212, 195, 195),
                foregroundColor: const Color.fromARGB(255, 66, 39, 39),
                elevation: 0,
                shadowColor: const Color.fromARGB(255, 66, 39, 39),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text("USE VIDEO CAMERA"),
            ),
            const Expanded(
              flex: 4,
              child: SizedBox(
                width: double.infinity,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Info()),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 50),
                textStyle: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: const Color.fromARGB(255, 35, 23, 23),
                foregroundColor: const Color.fromARGB(255, 158, 144, 144),
                elevation: 0,
                shadowColor: const Color.fromARGB(255, 66, 39, 39),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text("INFO"),
            ),
            const Expanded(
              flex: 4,
              child: SizedBox(
                width: double.infinity,
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Set()),
                );
              },
              backgroundColor: Color.fromARGB(255, 35, 23, 23),
              foregroundColor: Color.fromARGB(255, 158, 144, 144),
              child: const Icon(Icons.settings),
            ),
            const Expanded(
              flex: 4,
              child: SizedBox(
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
