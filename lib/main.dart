import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:users_app/appInfo/app_info.dart';
import 'package:users_app/authentication/login_screen.dart';
import 'package:users_app/authentication/signup_screen.dart';
import 'package:users_app/pages/home_page.dart';
import 'dart:io';
Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid || Platform.isIOS
      ? await Firebase.initializeApp(
    options: const FirebaseOptions
      (
        apiKey: 'AIzaSyCxevwjA9FGdoBGXE4sm3o2wCj9H3Y-Wbw',
        appId: '1:389684649868:android:845ed0898baa0b2a3040a9',
        messagingSenderId: '389684649868',
        projectId: 'flutter-uber-clone-with-16ccf'
    )
  ): await Firebase.initializeApp();

  await Permission.locationWhenInUse.isDenied.then((valueOfPermission){
     if(valueOfPermission){
       Permission.locationWhenInUse.request();
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return ChangeNotifierProvider(
      create: (context) => AppInfo(),
      child: MaterialApp(
        title: 'Flutter User App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),
        home: FirebaseAuth.instance.currentUser == null ? LoginScreen() : HomePage(),
      ),
    );
  }
}
