import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5352ed),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: Text('TEST')
                // Image.asset(
                //   'assets/logo_ifast.png',
                //   height: 150,
                //   width: 150,
                // ),
                ),
            SizedBox(height: 20),
            // Text(
            //   'IFAST',
            //   style: TextStyle(
            //     color: Color(0xffFFFFFF),
            //     fontSize:18,
            //     fontWeight: FontWeight.w600
            //   )
            // GoogleFonts.poppins(
            //   color: Color(0xffFFFFFF),
            //   fontSize: 30,
            //   fontWeight: FontWeight.w600,
            // ),
            // )
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String _debugLabelString = "";

  String title = '';
  @override
  void initState() {
    super.initState();
    initPlatformState();

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      print('FOREGROUND HANDLER CALLED WITH: ${event}');

      /// Display Notification, send null to not display
      event.complete(null);

      this.setState(() {
        // title =
        //     "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
        title = '${event.notification.body}';
        print('Hasil dari notif body $title');
      });
    });
  }

  static final String oneSignalAppId = "22224c18-9ec4-4b0a-8271-3d57414998b4";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: title,
        // 'https://ifast.iconpln.co.id/',
      ),

      //     Center(
      //   child: Container(
      //     color: Colors.amber,
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(title),
      //         Text('data'),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setAppId(oneSignalAppId);
  }
}
