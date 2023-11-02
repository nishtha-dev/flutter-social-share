import 'dart:io';

import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:screenshot/screenshot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScreenshotController screenshotController = ScreenshotController();
  AppinioSocialShare appinioSocialShare = AppinioSocialShare();
  Future<void> shareToWhatsApp(String message, String filePath) async {
    print(filePath);
    String response =
        await appinioSocialShare.shareToWhatsapp(message, filePath: filePath);
    print(response);
  }

  Future<void> shareToTelegram(String message, String filePath) async {
    print(filePath);
    String response =
        await appinioSocialShare.shareToTelegram(message, filePath: filePath);
    print(response);
  }

  Future<void> shareToTwitter(String message, String filePath) async {
    print(filePath);
    String response =
        await appinioSocialShare.shareToTwitter(message, filePath: filePath);
    print(response);
  }

  // Future<void> requestPermission() async {
  //   // final status = await Permission.storage.request();
  //   print("permision :- $status");
  //   if (status.isGranted) {
  //     print("Permission granted, you can now share the file");
  //     // Permission granted, you can now share the file
  //   } else {
  //     print("per:- ${status.isPermanentlyDenied}");
  //     // Permission denied, handle accordingly
  //     // if (status.isPermanentlyDenied) {
  //     print("Permission denied");
  //     // The user has permanently denied the permission, you can open app settings
  //     // openAppSettings();
  //     // }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          Screenshot(
            controller: screenshotController,
            child: Container(
              color: Colors.white,
              child: Center(
                child: Text("Here"),
              ),
            ),
          ),
          // ElevatedButton(
          //     onPressed: () async {
          //       await screenshotController
          //           .capture()
          //           .then((capturedImage) async {
          //         final tempDir = await getDownloadsDirectory();

          //         // print(
          //         //     "new path: ${tempDir.path.substring(tempDir.path.indexOf('data') + 4)}");
          //         final file = File('${tempDir?.path}/image.jpg');
          //         await file.writeAsBytes(capturedImage!, flush: true);
          //         bool isThere =
          //             await File('${tempDir?.path}/image.png').exists();
          //         print(isThere);
          //         // print(file.exists());

          //         print("path:- ${file.absolute.path}");
          //         shareToTelegram("Message Text!!", file.absolute.path);
          //       });
          //     },
          //     child: Text("Click Here")),
          ElevatedButton(
              onPressed: () async {
                await screenshotController
                    .capture(
                        delay: const Duration(milliseconds: 10),
                        pixelRatio: MediaQuery.of(context).devicePixelRatio)
                    .then((capturedImage) async {
                  print(capturedImage);
                  if (capturedImage != null) {
                    try {
                      final tempDir = await getApplicationDocumentsDirectory();

                      final file = File('${tempDir?.path}/image.jpg');
                      print("path:- ${tempDir?.path}");
                      await file.writeAsBytes(capturedImage!, flush: true);
                      bool isThere =
                          await File('${tempDir?.path}/image.png').exists();
                      print(isThere);
                      // print(file.exists());

                      print("path hello:- ${file.absolute.path}");
                      shareToWhatsApp("", file.absolute.path);
                    } catch (e) {
                      print("eror:- $e");
                    }
                    // final tempDir = await getApplicationDocumentsDirectory();

                    // // print(
                    // //     "new path: ${tempDir.path.substring(tempDir.path.indexOf('data') + 4)}");
                    // final file = File('${tempDir.path}/image.jpg');
                    // await file.writeAsBytes(capturedImage, flush: true);
                    // bool isThere =
                    //     await File('${tempDir.path}/image.png').exists();
                    // print(isThere);
                    // // print(file.exists());

                    // print("path:- ${file.absolute.path}");
                    // shareToTelegram("Message Text!!", file.absolute.path);
                  }
                });
              },
              child: Text("Click Here")),
          ElevatedButton(
              onPressed: () async {
                await screenshotController
                    .capture()
                    .then((capturedImage) async {
                  try {
                    final tempDir = await getApplicationDocumentsDirectory();

                    final file = File('${tempDir?.path}/image.jpg');
                    print("path:- ${tempDir?.path}");
                    await file.writeAsBytes(capturedImage!, flush: true);
                    bool isThere =
                        await File('${tempDir?.path}/image.png').exists();
                    print(isThere);
                    // print(file.exists());

                    print("path hello:- ${file.absolute.path}");
                    shareToTwitter("", file.absolute.path);
                  } catch (e) {
                    print("eror:- $e");
                  }

                  // final result =
                  //     await ImageGallerySaver.saveFile(file.absolute.path);
                });
              },
              child: Text("Save Image in Gallery"))
        ],
      ),
    );
  }
}
