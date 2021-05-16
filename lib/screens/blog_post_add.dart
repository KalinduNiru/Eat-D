import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

import '../utils/blog_service.dart';
import '../screens/blog_screen.dart';

class CreateBlog extends StatefulWidget {
  static const routeName = '/blog_add';

  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _authorName = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Blogs");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String authorName, title, desc;
  File selectedImage;
  bool _isLoading = false;
  CrudMethods crudMethods = new CrudMethods();
  final _picker = ImagePicker();

  String _validateDescription(String description) {
    if (description == null || description.isEmpty){
      return 'required';}
    if (description.length < 25){
    return 'Please enter more than 25 characters';}
    else{
      return null;
    }
  }

  Future getImage() async {
    final image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(image.path);
    });
  }

  Future uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });

      /// uploading image to firebase storage
      firebase_storage.Reference firebaseStorageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child("uploads/$selectedImage");

      final firebase_storage.UploadTask task =
          firebaseStorageRef.putFile(selectedImage);

      var downloadUrl = await (await task).ref.getDownloadURL();
      print("this is url $downloadUrl");

      final user = _auth.currentUser;

      dbRef.child(Uuid().v4()).set({
        "imgUrl": downloadUrl,
        "authorName": authorName,
        "title": title,
        "desc": desc,
        "userid": user.uid,
      });
    } else {}
  }

  void _blogpage() {
    Navigator.pushNamedAndRemoveUntil(
        context, BlogScreen.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Eat'D",
              style: TextStyle(fontSize: 22, color: Colors.deepPurple),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () async {
              if (_formKey.currentState.validate()) {
                uploadBlog();
                await _blogpage();
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.file_upload),
              color: Colors.deepPurple,
            ),
          )
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: selectedImage != null
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  selectedImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              width: MediaQuery.of(context).size.width,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black45,
                              ),
                            )),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextField(
                                  decoration:
                                      InputDecoration(hintText: "Author Name"),
                                  onChanged: (val) {
                                    authorName = val;
                                  },
                                ),
                                TextField(
                                  decoration:
                                      InputDecoration(hintText: "Title"),
                                  onChanged: (val) {
                                    title = val;
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(hintText: "Desc"),
                                  onChanged: (val) {
                                    desc = val;
                                  },
                                  validator: _validateDescription,
                                  minLines: 3,
                                  maxLines: 6,
                                )
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
