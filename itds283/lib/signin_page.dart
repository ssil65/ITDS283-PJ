import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'contact_page.dart';
import 'homepage.dart';
import 'signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //Login Function
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code != "unknown") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("SIGN IN FAILED: Invalid Email or Password"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIGN IN'),
        backgroundColor: const Color.fromARGB(255, 11, 0, 172),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactPage()),
                );
              },
              child: const Icon(Icons.contact_support),
            ),
          ),
        ],
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: NetworkImage(
                      "https://mahidol.ac.th/temp/2019/06/logo-MU_Color.png"),
                  width: 150,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        labelText: 'Email',
                        hintText: 'Enter Your Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.blueGrey,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        labelText: 'Password',
                        hintText: 'Enter Your Password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.blueGrey,
                        )),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    User? user = await loginUsingEmailPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context);
                    if (user != null) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomePage()));
                    } else if (_formKey.currentState!.validate()) {
                      return;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: const Color.fromARGB(255, 11, 0, 172),
                      foregroundColor: Colors.yellow),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SignUpPage()));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: const Color.fromARGB(255, 59, 57, 88),
                      foregroundColor: Colors.yellow),
                  child: const Text(
                    'Create your account',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                const Image(
                  image: NetworkImage(
                      "https://wallpapercave.com/wp/wp8857061.png"),
                  height: 320,
                  width: 320,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}