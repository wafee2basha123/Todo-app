import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Home/settings/settingsTab.dart';
import 'package:todoapp/auth/registration/register.dart';
import 'package:todoapp/provider/Listprovider.dart';
import 'auth/login/login.dart';
import 'homescreen.dart';
import 'mytheme.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
  Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
create: (context) => ListProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider =  Provider.of<ListProvider>(context);

    return MaterialApp(

      debugShowCheckedModeBanner:  false,

      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SettingTab.routeName: (context) => SettingTab(),

      },
      theme : MyTheme.lightmode,
      themeMode: provider.appTheme,
      darkTheme:  MyTheme.darkmode,
    );
  }
}