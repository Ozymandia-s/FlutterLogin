import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key });
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Text(
              'Home Screen',
              style: TextStyle(),
            ),
            ElevatedButton(
              onPressed: (){
                try {
                  GoogleSignIn().signOut();
                  FirebaseAuth.instance.signOut();
                } catch (_) {
                }
              },
              child: const Text( 'Logout',
              style: TextStyle(),
              ),
            ),
          ],
      ),
      ),
    ); //return your home screen widget here
  }
}