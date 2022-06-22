// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:immence_authentication/screens/profile.dart';
import 'package:immence_authentication/screens/sign_up.dart';
import 'package:immence_authentication/services/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;
  final DatabaseReference database = FirebaseDatabase.instance.ref('userData');

  late String _email;
  late String _password;

  bool _cheackValue = false;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
        child: Stack(
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'immence',
                    style: TextStyle(
                      color: Color(0xff0231C8),
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Hi, Wecome Back! 👋',
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 30),

                  // Email textformfield...
                  Text(
                    'Email',
                    style: TextStyle(
                      color: Color(0xff0231C8),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffC6C6C6),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Please Enter Your Email',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Password textformfield...
                  Text(
                    'Password',
                    style: TextStyle(
                      color: Color(0xff0231C8),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffC6C6C6),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            color: Color(0xff000000),
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  _isObscure = !_isObscure;
                                },
                              );
                            },
                          ),
                          border: InputBorder.none,
                          hintText: 'Please Enter Your Password',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Checckbox....
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        checkColor: Colors.greenAccent,
                        activeColor: Colors.red,
                        value: _cheackValue,
                        onChanged: (bool? value) {
                          setState(() {
                            _cheackValue = value!;
                          });
                        },
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.black;
                          },
                        ),
                      ),
                      Text(
                        'Remember me',
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Login Button...
                  InkWell(
                    onTap: () {
                      Authentication()
                          .signIn(email: _email, password: _password)
                          .then((value) {
                        database.child(user!.uid).update({'email': _email});
                        if (value != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          );
                        }
                      });
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xff0231C8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Text....
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
                  },
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Don't have an account ?  ",
                        style: TextStyle(
                          color: Color(0xff999EA1),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xff0231C8),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
