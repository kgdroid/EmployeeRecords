import 'package:employer/screens/homepage.dart';
import 'package:employer/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// This will check if user is siegned in or not
//  // If already signed in then proceed to HOMEPAGE
//  // Else SignIn page
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return const HomePage();
          }else{
            return const Register();
          }
        },
      ),
    );
  }
}