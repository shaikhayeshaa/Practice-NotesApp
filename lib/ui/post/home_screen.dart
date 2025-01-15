import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/ui/auth/login_screen.dart';
import 'package:firebaseapp/ui/post/add_note_screen.dart';
import 'package:firebaseapp/ui/post/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;
  TextEditingController noteEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100.0, // Adjust the height as needed
              color: Colors.teal,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 20),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add a Note'),
              onTap: () {
                Get.to(() => AddNoteScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.contact_page),
              title: Text('Contact'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.off(() => LoginScreen());
            },
            child: Icon(Icons.login_sharp),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
             GestureDetector(
               onTap: (){
                 Get.to(() => NotesScreen());
               },
               child: Container(
                 height: 80,
                 width: double.infinity ,
                 child: Center(child: Text('Notes',
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 20
                 ) ,
                 )),
                 decoration: BoxDecoration(
                   color: Colors.teal[50],
                   // border: Border.all(
                   //   color: Colors.teal,
                   //   width: 3
                   // ),
                   // borderRadius: BorderRadius.circular(20)
                 ),
               ),
             )
            ],
          ),
        ),),
    );
  }
}
