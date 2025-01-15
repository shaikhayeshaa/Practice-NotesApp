import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/ui/auth/forgot_password_screen.dart';
import 'package:firebaseapp/ui/auth/signup_screen.dart';
import 'package:firebaseapp/ui/post/home_screen.dart';
import 'package:firebaseapp/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController loginEmailController = TextEditingController();
    TextEditingController loginPasswordController = TextEditingController();
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('Login'),
      // ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60,),
                Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: Lottie.asset('assets/Animation - 1736607104872.json'),
                ),

                Text(
                    'Login',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 40,),
                Center(child: Text('Provide you credentials')),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: loginEmailController,
                    decoration: InputDecoration(
                      suffixIcon: Icon( Icons.email,
                        color: Colors.teal,),
                      hintText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: loginPasswordController,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: Icon( Icons.lock,
                          color: Colors.teal,),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(() => ForgotPasswordScreen() );
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 5) ,
                    child: Align(
                      alignment:
                      Alignment.centerRight, // Aligns the text to the right
                      child: Text(
                        'Forget password?',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: 'RubikRegular',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40,),

                MainButton(
                    title: 'Login',
                    onTap: () async {
                      var loginEmail = loginEmailController.text.trim();
                      var loginPassword = loginPasswordController.text.trim();

                      if (loginEmail.isEmpty || loginPassword.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(
                                'Email and Password cannot be empty')));
                        return;
                      }
                      try {
                        final User? firebaseUser = (await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: loginEmail,
                          password: loginPassword,
                        )).user;

                        if (firebaseUser != null) {
                          Get.to(() => HomeScreen());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(
                                  'Login failed: Email or password is incorrect'))
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        print('FirebaseAuthException: $e');
                      } catch (e) {
                        print('Unexpected error: $e');
                      }
                    }
                ),
                SizedBox(height: 20,),

                GestureDetector(
                  onTap: (){
                    Get.to(() => SignupScreen());
                  },
                  child: Card(
                    child: Text('Dont have an account Signup'),
                  ),
                )



              ],
            )
          )
      ),
    );
  }
}
