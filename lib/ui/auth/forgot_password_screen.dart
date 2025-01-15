import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController forgotPassEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    'Forgot Password',
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(child: Text('Enter the email associated with your account')),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: forgotPassEmailController,
                      decoration: InputDecoration(
                          suffixIcon: Icon( Icons.person),
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
                  MainButton(
                      title: 'Send Code',
                      onTap: () async {
                        var forgotEmail = forgotPassEmailController.text.trim();
                        try{
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: forgotEmail
                          ).then ((value)=>{
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Email send successfully')))
                          });
                        } on FirebaseAuthException catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('error : $e')));
                        }

                      }
                  ),
                  SizedBox(height: 10,),
                ],
              )
          )
      ),
    );
  }
}
