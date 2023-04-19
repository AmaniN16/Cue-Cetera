import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:video_player/video_player.dart';
import 'package:camera/camera.dart';

import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'firebase_options.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:chaquopy/chaquopy.dart';
import 'package:path_provider/path_provider.dart';

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
      debugShowCheckedModeBanner: false,
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
      backgroundColor: Color(0xff1e133d),
      appBar: AppBar(
        backgroundColor: Color(0xff1e133d),
        toolbarHeight: 100,
        elevation: 0,

        title: Center(
            child: Text(title,style: TextStyle(color: Color(0xffc9b6b9), fontSize: 30))
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

class videoRecord extends StatefulWidget {
  const videoRecord({super.key});
  @override
  State<videoRecord> createState() => _videoRecord();
}

//class _videoRecord written using code from: https://bettercoding.dev/flutter/tutorial-video-recording-and-replay/
//code references in class _videoRecord also from:
// https://pub.dev/packages/camera/example
//https://stackoverflow.com/questions/64070044/how-to-record-a-video-with-camera-plugin-in-flutter
class _videoRecord extends State<videoRecord> {
  late CameraController controllers;
  bool startRecordSetup = true;

  @override
  void initState() {
    cameraSetup();
    super.initState();
  }

  cameraSetup() async {
    final cameras = await availableCameras();
    controllers = CameraController(cameras[0], ResolutionPreset.max);
    await controllers.initialize();

    setState(() => startRecordSetup = false);
  }

  recordVideo() async {
    if (!controllers.value.isRecordingVideo) {
      await controllers.startVideoRecording();

    }
    else {
      final file = await controllers.stopVideoRecording();
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  Test(file.path),));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (startRecordSetup) {
      return Container(
        color: Color(0xffc9b6b9),
      );
    }
    else {
      return Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CameraPreview(controllers),
            FloatingActionButton(
              backgroundColor: Color(0xffc9b6b9),
              onPressed: () => recordVideo(),
              child: Icon(Icons.circle),
            ),
          ],
        ),
      );
    }
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
        backgroundColor: Color(0xff1e133d),
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

    String contents;

      try {
        // Read the file
        contents = await loadAsset();
      }
      catch(e){
        throw Exception('File not found');
      }

    String _outputOrError = "";

    final _result = await Chaquopy.executeCode(contents);
    setState(() {
      _outputOrError = _result['textOutputOrError'] ?? '';
    });

    final imgRef = storage.child("imgs");
    final appDocDir = await getApplicationDocumentsDirectory();
    final imgPath = "${appDocDir.absolute}/imgs";
    final imgs = File(imgPath);

    final downloadTask = imgRef.writeToFile(imgs);

    // FirebaseModelDownloader.instance.getModel("cue-classifier");

    setState(() {
      loadVideoPlayer(file);
    });
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/predictLabels.txt');
  }
}