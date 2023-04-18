import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'firebase_options.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:chaquopy/chaquopy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CUE-CETERA',
      theme: ThemeData(
        primaryColor: Color(0xff1e133d),
      ),
      home: MyHomePage(title: 'CUE-CETERA'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc9b6b9),
      appBar: AppBar(
        backgroundColor: Color(0xff1e133d),
        toolbarHeight: 100,
        title: Center(
          child: Text(title),
        ),
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const videoUpload()),
                    );
                  },
                  child: Text("UPLOAD VIDEO"),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(250, 110),
                    textStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    primary: Color(0xffc9b6b9),
                    onPrimary: Color(0xff1e133d),
                    elevation: 20,
                    shadowColor: Color(0xff1e133d),
                    shape: StadiumBorder(),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const videoRecord()),
                    );
                  },
                  child: Text("USE VIDEO CAMERA"),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(250, 110),
                    textStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    primary: Color(0xffc9b6b9),
                    onPrimary: Color(0xff1e133d),
                    elevation: 20,
                    shadowColor: Color(0xff1e133d),
                    shape: StadiumBorder(),
                  )),
            ],
          )),
    );
  }
}

class videoRecord extends StatelessWidget {
  const videoRecord({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc9b6b9),
      appBar: AppBar(
        backgroundColor: Color(0xff1e133d),
        toolbarHeight: 100,
        title: Center(
          child: Text("CUE-CETERA"),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0)),
        ),
      ),
      body: Container(),
    );
  }
}

class videoUpload extends StatelessWidget {
  const videoUpload({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc9b6b9),
      appBar: AppBar(
        backgroundColor: Color(0xff1e133d),
        toolbarHeight: 100,
        title: Center(
          child: Text("CUE-CETERA"),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0)),
        ),
      ),
      body: Container(

          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () async {
                    var picked = await FilePicker.platform.pickFiles();

                    if (picked != null) {
                      print(picked.files.first.size/(1024*1024));
                      if(picked.files.first.size/(1024*1024) > 50){
                        print('File size cannot exceed 50 MB');
                      }else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  Test(picked.files.first.path!)),
                        );
                      }
                    }
                  },
                  child: Text("SELECT"),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(250, 110),
                    textStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    primary: Color(0xffc9b6b9),
                    onPrimary: Color(0xff1e133d),
                    elevation: 20,
                    shadowColor: Color(0xff1e133d),
                    shape: StadiumBorder(),
                  )),
            ],
          )
      ),
    );
  }
}

class Test extends StatefulWidget {
  String filePath;
  Test(this.filePath);

  @override
  State<Test> createState() => playVideo(filePath);
}

class playVideo extends State<Test> {
  String filePath;

  playVideo(this.filePath);
  VideoPlayerController? _videoPlayerController;
  loadVideoPlayer(File file) {
    if(_videoPlayerController != null) {
      _videoPlayerController!.dispose();
    }
    print(filePath.toString() + " HII");

    OpenFile.open(filePath!);

    _videoPlayerController = VideoPlayerController.file(file);
    _videoPlayerController!.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc9b6b9),
      appBar: AppBar(
        backgroundColor: Color(0xff1e133d),
        toolbarHeight: 100,
        title: Center(
          child: Text("CUE-CETERA"),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: selectVideo,
        child: Icon(
          Icons.play_circle_outline_outlined,
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            if (_videoPlayerController != null) ...[
              AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController!),
              ),
            ]
          ],
        ),
      ),
    );
  }

  void selectVideo() async {
    //send file name to db
    DatabaseReference ref = FirebaseDatabase.instance.ref("Videos");

    ref.child('paths').push().set({
      "Path": filePath,
    });

    //send video itself to storage
    final storage = FirebaseStorage.instance.ref();

    final storRef = storage.child(filePath);

    File file = File(filePath);

    try {
      await storRef.putFile(file);
    } on FirebaseException catch (e) {
      throw Exception('Failed to save video');
    }

       // final path = 'src/main/python/predictLabels.py';
    // File backend = File(path);
    String contents;

      try {
        // Read the file
        contents = await loadAsset();
      }
      catch(e){
        throw Exception('File not found');
      }

    Chaquopy.executeCode(contents);

    setState(() {
      loadVideoPlayer(file);
    });
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/predictLabels.py');
  }
}