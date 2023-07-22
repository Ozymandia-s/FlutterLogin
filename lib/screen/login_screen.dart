import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/auth_/google_auth_cubit.dart';
import 'package:proyecto/auth_/google_auth_state.dart';


class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    if (EmailValidator.validate(emailController.text)) {
      final auth = FirebaseAuth.instance;
      try {
        await auth.signInWithEmailAndPassword(
          email: emailController.text,
          password:passwordController.toString().trim(),
        );
        debugPrint('LOG: Login successful');
      } catch (e) {
        debugPrint('LOG: Login failed - ${e.toString()}');
      }
    } else {
      debugPrint('LOG: Invalid email address format');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.length > 6) {
                    // TODO: Log in the user
                    login();
                  } else {
                    debugPrint('LOG: Email is empty or password is invalid');
                  }
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  final auth = FirebaseAuth.instance;
                  auth.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                },
                child: const Text('Sign up'),
              ),
              BlocConsumer<GoogleAuthCubit,GoogleAuthState>(
                listener: (context, state){},
                builder: (context, state){
                  return ElevatedButton(
                    onPressed: state is GoogleAuthLoadingState
                    ? null
                    : () => context.read<GoogleAuthCubit>().login
                    (),
                    child: state is GoogleAuthLoadingState
                    ? const CircularProgressIndicator()
                    : const Text('Login with google'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}// preguntarle a chat como se podria dejar solo el login with google y quitar el sign in y el sign up.