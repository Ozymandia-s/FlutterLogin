import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'main.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({Key? key}) :super (key:key);


@override 
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: ElevatedButton(onPressed: (){
        signInWithGoogle();
      },
      child: Text('Login With Google')
      ,)
    ,)
  );
}
signInWithGoogle() async {

  GoogleSignInAccount? googleUser= await GoogleSignIn().signIn(); 

  GoogleSignInAuthentication? googleAuth= await googleUser?.authentication; 

  AuthCredential credential= GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken 
  );

  UserCredential userCredential = await  FirebaseAuth.instance.signInWithCredential(credential);
  print(userCredential.user?.displayName);
  
  // if(userCredential.user != null){
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(title:'Home Page')));
  // }
}
}