import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: AuthSerrvice().isLoggedIn()
    );
  }
}


FirebaseAuth auth = FirebaseAuth.instance;
class AuthSerrvice{
  isLoggedIn(){
    if(auth.currentUser != null){
      return HomePage();
    }
    return LoginPage();
  }
}

