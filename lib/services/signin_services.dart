import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/ui/auth/login_screen.dart';
import 'package:get/get.dart';


signInUser(
    String userName ,
    String userEmail ,
    String userPhone ,
    String userPassword
    )async  {
  User? userId = FirebaseAuth.instance.currentUser;

  try{
    await FirebaseFirestore.instance.
    collection('users').
    doc(userId!.uid).
    set({
      'userName' : userName,
      'userEmail' : userEmail,
      'userPhone' : userPhone,
      'userPassword' : userPassword,
      'createdAt' : DateTime.now(),
      'userId' : userId.uid
    }).then((value)=>{
      FirebaseAuth.instance.signOut(),
      Get.to((() => LoginScreen()))
    });
  } on FirebaseAuthException catch(e){
    print('error $e');
  }

}