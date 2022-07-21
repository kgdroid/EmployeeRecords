import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //TextController
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(
                  Icons.emoji_people,
                  size: 100,
                ),
                const SizedBox(
                  height: 75,
                ),
                const Text(
                  'Emloye.ez',
                  style: TextStyle(fontSize: 52),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Smart way to track employee records',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      label: Text('Email'),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      floatingLabelStyle: TextStyle(color: Color(0xFF0b8793)),
                      hintStyle: TextStyle(
                          color: Color(0xFFACACAC), fontSize: 14),
                      contentPadding:
                          EdgeInsets.only(top: 20, left: 38, bottom: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC7C7C7)),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF360033)),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      label: Text('Password'),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      floatingLabelStyle: TextStyle(color: Color(0xFF0b8793)),
                      hintStyle: TextStyle(
                          color: Color(0xFFACACAC), fontSize: 14),
                      contentPadding:
                          EdgeInsets.only(top: 20, left: 38, bottom: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC7C7C7)),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF360033)),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            signIn();
                          },
                          child: const Text(
                            'SignIn',
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
