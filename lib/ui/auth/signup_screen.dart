import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/services/signin_services.dart';
import 'package:firebaseapp/ui/auth/forgot_password_screen.dart';
import 'package:firebaseapp/ui/auth/login_screen.dart';
import 'package:firebaseapp/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController userEmailController = TextEditingController();
    TextEditingController userPhoneController = TextEditingController();
    TextEditingController userPasswordController = TextEditingController();

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: Lottie.asset('assets/Animation - 1736607104872.json'),
                    ),
                  Text(
                    'Signup',
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(child: Text('Provide you credentials')),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: userNameController,
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.person,
                            color: Colors.teal,
                          ),
                          hintText: 'Name',
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
                      controller: userEmailController,
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
                      controller: userPhoneController,
                      decoration: InputDecoration(
                          suffixIcon: Icon( Icons.phone,
                            color: Colors.teal,),
                          hintText: 'PhoneNumber',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: userPasswordController,
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
                      Get.to(()=> ForgotPasswordScreen());
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
                  SizedBox(height: 20,),
                  MainButton(
                      title: 'SignUp',
                      onTap: ()async{
                        var userName = userNameController.text.trim();
                        var userEmail = userEmailController.text.trim();
                        var userPhone = userPhoneController.text.trim();
                        var userPassword = userPasswordController.text.trim();
                        await FirebaseAuth.instance.
                        createUserWithEmailAndPassword(
                            email: userEmail,
                            password: userPassword
                        ).then((value)=>{
                          signInUser(
                              userName,
                              userEmail,
                              userPhone,
                              userPassword)
                        });
                      },
                  ),

                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=> LoginScreen());
                    },
                    child: Card(

                      child: Text('Already have an account Login'),
                    ),
                  )



                ],
              )
          )
      ),
    );
  }
}
