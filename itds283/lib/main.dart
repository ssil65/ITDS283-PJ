import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'searchpage.dart';
import 'AddReview.dart';
import 'ReviewPage.dart';
import 'gamesInfo.dart';
import 'signin_page.dart';
import 'signup_page.dart';
import 'contact_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
      apiKey: "AIzaSyDbW3hQj3LwvwVAlpke3LIOqDnmlcqzO14",
      appId: "1:710147503651:android:6bd0ec9649b3ce1c342396",
      messagingSenderId: "710147503651",
      projectId: "my-283-app-pj",
    ),
  );
  var app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // init firebase
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GR APP',
      home: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const SignInPage();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        // home: MyHomePage(),
    );
  }
}
/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      initialRoute: '/',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      routes: {
        '/': (context) => SignInPage(),
        '/home':(context) => HomePage(),
        '/search': (context) => const SearchPage(),
        '/AddReview': (context) => AddReviewPage(),
        '/ReviewPage': (context) => ReviewPage(),
        '/GameInfo': (context) => gameInfo(),
      },
    );
  }
}*/
