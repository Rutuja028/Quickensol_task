/*
Use this password while login because the credentials are taken from the dummy API Reqres.in and it is a mock API and doesn't validate passwords so I have used hardcoded password

Password = "password123"

*/

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool showPass = false;

  String samplePassword = "password123"; //dummy password for testing

  Future<void> loginUser() async {
    final response = await http.get(
      Uri.parse('https://reqres.in/api/users?page=1'),
    );

    if (response.statusCode == 200) {
      List<dynamic> users = jsonDecode(response.body)['data'];
      bool userFound = false;

      for (var user in users) {
        if (user['email'] == usernameController.text &&
            passwordController.text == samplePassword) {
          userFound = true;
          break;
        }
      }

      if (userFound) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserListScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login failed. Invalid username or password."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Unable to fetch users. Please try again later."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      offset: Offset(0, 3),
                      blurRadius: (10),
                    ),
                  ]),
              height: 35,
              width: 250,
              child: TextFormField(
                controller: usernameController,
                focusNode: usernameFocusNode,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Enter Your Email",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    fontSize: 15,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(250, 235, 235, 0.135),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter a User Name";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(height: 15),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      offset: Offset(0, 3),
                      blurRadius: (10),
                    ),
                  ]),
              height: 35,
              width: 250,
              child: TextFormField(
                controller: passwordController,
                focusNode: passwordFocusNode,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: const InputDecoration(
                  hintText: "Create your password",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    fontSize: 15,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(250, 235, 235, 0.135),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter password";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 20),
            Container(
              height: 35,
              width: 250,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      offset: Offset(0, 3),
                      blurRadius: (10),
                    ),
                  ]),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color.fromRGBO(14, 161, 125, 1),
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                onPressed: loginUser,
                child: const Text("Log In",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
