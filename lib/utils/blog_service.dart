import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

class CrudMethods {
  Future<void> addData(blogData) async {

    DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Blogs");

   dbRef.child(blogData);
  }


}