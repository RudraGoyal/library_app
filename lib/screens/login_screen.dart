import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:library_app/screens/error_dialog.dart';
import 'package:library_app/services/google_signin.dart';
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String? userid;
  String? password;
  TextEditingController tec = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login To MyLibrary'),
        backgroundColor: Colors.purple[400],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 230,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Card(
                  color: Colors.amber,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Student Login',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    RaisedButton.icon(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () async {
                        auth.googleSignup(context);
                      },
                      icon: const Icon(
                        Icons.g_mobiledata_outlined,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Sign In With Google',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.purple[400],
                    ),
                  ]),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              color: Colors.blue[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 3,
              child: Form(
                key: _formkey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(children: [
                    const Text(
                      'ADMIN Login',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) => value == null || value == ''
                          ? 'Enter valid User ID'
                          : null,
                      onChanged: (val) => userid = val,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'User ID...',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) => value == null || value == ''
                          ? 'Enter valid password'
                          : null,
                      onChanged: ((value) => password = value),
                      cursorColor: Colors.black,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password...',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RaisedButton.icon(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          Response response = await post(
                              Uri.parse(
                                  'https://sids438.pythonanywhere.com/login/'),
                              body: {
                                // "username": "SUTT_admin",
                                // "password": "1234567890",
                                "username": "$userid",
                                "password": "$password"
                              });
                          var message = await jsonDecode(response.body);
                          print(message);
                          if (message == "Logged In") {
                            await auth.adminLogin();
                            Navigator.pushReplacementNamed(context, '/admin');
                          } else {
                            errorDialog(context);
                          }
                        }
                      },
                      icon: const Icon(Icons.login),
                      label: const Text('Login'),
                      color: Colors.blue[600],
                    ),
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
