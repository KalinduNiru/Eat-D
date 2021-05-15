import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/blog.dart';
import '../models/blogVideo.dart';
import '../widgets/blog_item.dart';
import 'package:firebase_database/firebase_database.dart';

import '../screens/blog_post_add.dart';


class BlogScreen extends StatefulWidget {
  static const routeName = '/blog';

  final dbRef = FirebaseDatabase.instance.reference().child("Blogs");

  List<Map<dynamic, dynamic>> blog_lists = [];

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final dbRef = FirebaseDatabase.instance.reference().child("Blogs");

  List<Map<dynamic, dynamic>> blog_lists = [];
  List<BlogVideo> _videoList = [
    BlogVideo(
      videoUrl: 'some url',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1524601500432-1e1a4c71d692?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8YmVzdCUyMGZyaWVuZHN8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    ),
    BlogVideo(
      videoUrl: 'some url',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1524601500432-1e1a4c71d692?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8YmVzdCUyMGZyaWVuZHN8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    ),
    BlogVideo(
      videoUrl: 'some url',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1524601500432-1e1a4c71d692?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8YmVzdCUyMGZyaWVuZHN8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    ),
  ];

  void _create_blog() {
    Navigator.pushNamedAndRemoveUntil(
        context, CreateBlog.routeName, (route) => false);
  }

  bool isEdgeIndex(int index) {
    return index == index;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Blog', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.iconColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: FutureBuilder(
            future: dbRef.once(),
            builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.hasData) {
                blog_lists.clear();
                Map<dynamic, dynamic> values = snapshot.data.value;
                values.forEach((key, values) {
                  blog_lists.add(values);
                });

                return new SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'READ IT',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 240,
                          width: double.infinity,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: blog_lists.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(right: 10, left: 20),
                                  width: 240,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: AppColors.primaryColor),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          // height: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  blog_lists[index]["imgUrl"]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          blog_lists[index]["authorName"],
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8),
                                        child: Text(
                                          blog_lists[index]["title"],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      GestureDetector(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8,
                                              bottom: 8,
                                              top: 8),
                                          child: Row(
                                            children: [
                                              TextButton(
                                                child: Text("Read More"),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: new Text(blog_lists[index]["title"]),
                                                          content: new Text(blog_lists[index]["desc"]),
                                                          actions: <Widget>[
                                                            new FlatButton(
                                                              child: new Text("OK"),
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                },
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.favorite_border,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                              SizedBox(width: 4),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 30),
                          child: Text(
                            'WATCH IT',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 180,
                          width: double.infinity,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: blog_lists.length,
                              itemBuilder: (context, index) {
                                BlogVideo video = _videoList[index];
                                return Container(
                                  margin: EdgeInsets.only(right: 10, left: 20),
                                  width: 240,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: AppColors.primaryColor),
                                    image: DecorationImage(
                                      image: NetworkImage(video.thumbnailUrl),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.4),
                                          BlendMode.darken),
                                    ),
                                  ),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.play_circle_outline,
                                        size: 100,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80.0, vertical: 40),
                          child: SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              elevation: 1,
                              textColor: Colors.white,
                              color: AppColors.secondaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Text(
                                'Tell your Story to Us',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              onPressed: _create_blog,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Image.asset('assets/logos/logo-word.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return CircularProgressIndicator();

            }));

  }

}
