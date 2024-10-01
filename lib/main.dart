import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsapplication/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyD9X_65Gh8__xNrRC8Wc9TJWaPSS0s40Vo',
      appId: '1:843924827363:android:980a4ad868e03b86ea69d6',
      messagingSenderId: '843924827363',
      projectId: '843924827363',
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FutureBuilder<Widget>(
        future: checkLogin(), // Call the checkLogin function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the future is loading, show a loading indicator
            return Center(child: CircularProgressIndicator());
          } else {
            // Once the future is complete, return the appropriate widget
            return snapshot.data ?? Login(); // Fallback to Login if null
          }
        },
      ),
    );
  }

  Future<Widget> checkLogin() async {
    try {
      // Access SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // Check login status
      return prefs.getBool("isloggedin") == true ? Home() : Login();
    } catch (e) {
      print("Error accessing SharedPreferences: $e");
      return Login(); // Fallback to Login in case of error
    }
  }
}
