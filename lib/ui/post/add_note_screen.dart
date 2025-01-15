import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController noteController = TextEditingController();
    @override
  Widget build(BuildContext context) {
      User? userid = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        // automaticallyImplyLeading: false,
        title: Text('Add Notes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10 , left: 10,right: 10),
            child: TextFormField(
              controller: noteController,
              maxLength: null,
                decoration: InputDecoration(
                  hintText: 'Add new Text',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.teal,
                    )
                  ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.teal,
                        )
                    ),
                ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: Text('Add'),
            onPressed: ()async{
              var note = noteController.text.trim();
              if(note!='') {
                try {
                 await FirebaseFirestore.instance
                      .collection('notes')
                      .doc()
                      .set({
                    'createdAt' : DateTime.now(),
                    'note' : note,
                    'userId' : userid!.uid
                  }).then ((value)=>{
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text('Note added')),
                   )});

                } catch (e) {

                }
              }
              },
          ),
         
        ],
      ),

    );
  }
}
