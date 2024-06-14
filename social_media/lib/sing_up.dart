import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';
// ignore_for_file: prefer_const_constructors

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
TextEditingController email = TextEditingController();
TextEditingController paasword = TextEditingController();
TextEditingController  USERNAME = TextEditingController();
Future<void> signUp() async {
  try {
    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text.trim(), // Ensure email is trimmed
      password: paasword.text,
    );
  Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginView()),
      );

    // Sign-up successful (handle success in your UI)
    // For example, show a success message or navigate to a different screen
    print('Sign-up successful for user: ${userCredential.user!.uid}');

    // Optionally, send a verification email (recommended for security)
    await userCredential.user!.sendEmailVerification();
    print('Verification email sent to ${userCredential.user!.email}');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      // Show an error message to the user (e.g., "Password must be at least 6 characters")
    } else if (e.code == 'email-already-in-use') {
      print('The email address is already in use by another account.');
      // Show an error message to the user (e.g., "Email already exists")
    } else if (e.code == 'invalid-email') {
      print('The email address is invalid.');
      // Show an error message to the user (e.g., "Invalid email format")
    } else {
      print(e.code); // Log the error for debugging
      // Show a generic error message to the user
    }
  } catch (e) {
    print(e.toString()); // Log any other unexpected errors
    // Show a generic error message to the user
  }
}





  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return 'Please enter an email';
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePhoneNumber(value) {
    if (value!.isEmpty) {
      return 'Please enter a phone number';
    }
    if (value.length != 10) {
      return 'Please enter a 10-digit phone number';
    }
    return null;
  }

  String? _validatePassword(value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }

    return null;
  }

  String? _validateUsername(value) {
    if (value!.isEmpty) {
      return 'Please enter a username';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF252634),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 80.0,
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(
                        "Create new Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration:
                            _buildInputDecoration("Username", Icons.person),
                        validator: _validateUsername),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: _buildInputDecoration("Email", Icons.email),
                        validator: _validateEmail,
                        controller:email ,
                        
                        ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration:
                          _buildInputDecoration("Phone number", Icons.call),
                      validator: _validatePhoneNumber,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: _buildInputDecoration("Password", Icons.lock),
                      validator: _validatePassword,
                      controller: paasword,
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFF15900)),
                            onPressed: signUp,
                            child: Text("Create",
                                style: TextStyle(fontSize: 20)))),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                        );
                      },
                      child: Text(
                        "Login",
                        style:
                            TextStyle(color: Color(0xFFF15900), fontSize: 20),
                      ),
                    )
                  ],
                )),
          ),
        ));
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
        fillColor: Color(0xAA494A59),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x35949494))),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        filled: true,
        labelStyle: TextStyle(color: Color(0xFF949494)),
        labelText: label,
        suffixIcon: Icon(
          suffixIcon,
          color: Color(0xFF949494),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
  }
}
