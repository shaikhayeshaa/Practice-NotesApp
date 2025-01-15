import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_note_screen.dart';


class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  User? userId = FirebaseAuth.instance.currentUser;
  TextEditingController noteEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          GestureDetector(
            onTap: (){
              Get.to(() => AddNoteScreen());
            },
            child: Icon(Icons.add),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('notes')
                      .where('userId', isEqualTo: userId?.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('SOMETHING WENT WRONG');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text('NO DATA FOUND'),
                      );
                    }
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var doc = snapshot.data!.docs[index];
                            var docId = snapshot.data!.docs[index].id;

                            // Convert Firestore Timestamp to DateTime
                            DateTime createdAt = (doc['createdAt'] as Timestamp).toDate();
                            // Format DateTime as a string
                            String formattedDate =
                                "${createdAt.day}-${createdAt.month}-${createdAt.year} ${createdAt.hour}:${createdAt.minute}";
                            return Card(
                              child: ListTile(
                                title: Text(doc['note']),
                                subtitle: Text(formattedDate),
                                trailing: PopupMenuButton(
                                  icon: Icon(Icons.more_vert, color: Colors.teal),
                                  color: Colors.teal[50],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 1,
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit, color: Colors.teal),
                                          SizedBox(width: 10),
                                          Text(
                                            'Edit',
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 2,
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete, color: Colors.red),
                                          SizedBox(width: 10),
                                          Text(
                                            'Delete',
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  onSelected: (value) {
                                    if (value == 1) {
                                      // Call the updated showMyDialog function with docId
                                      showMyDialog(doc['note'], docId);
                                    } else if (value == 2) {
                                      FirebaseFirestore.instance.collection('notes').doc(docId).delete();
                                      Get.snackbar("Delete", "Note deleted successfully",
                                          backgroundColor: Colors.red, colorText: Colors.white);
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
      ),
    );
  }
  Future<void> showMyDialog(String title, String docId) async {
    noteEditingController.text = title;
    return showDialog(
      barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit'),
          content: TextField(
            controller: noteEditingController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String updatedNote = noteEditingController.text.trim();
                if (updatedNote.isNotEmpty) {
                  // Update Firestore document using docId
                  FirebaseFirestore.instance
                      .collection('notes')
                      .doc(docId) // Pass the correct document ID
                      .update({'note': updatedNote});
                }
                Navigator.pop(context); // Close dialog
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

}
