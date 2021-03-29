import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/blog.dart';
import '../models/blogVideo.dart';
import '../widgets/blog_item.dart';

class BlogScreen extends StatefulWidget {
  static const routeName = '/blog';

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  List<Blog> _blogList = [
    Blog(
        title: 'Choose your friends wisely',
        category: 'Life',
        imgUrl:
            'https://images.unsplash.com/photo-1524601500432-1e1a4c71d692?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8YmVzdCUyMGZyaWVuZHN8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
        likes: 250),
    Blog(
        title: 'Choose your friends wisely',
        category: 'Life',
        imgUrl:
            'https://images.unsplash.com/photo-1524601500432-1e1a4c71d692?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8YmVzdCUyMGZyaWVuZHN8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
        likes: 250),
    Blog(
        title: 'Choose your friends wisely',
        category: 'Life',
        imgUrl:
            'https://images.unsplash.com/photo-1524601500432-1e1a4c71d692?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8YmVzdCUyMGZyaWVuZHN8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
        likes: 250),
  ];

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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'READ IT',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 240,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _blogList.length,
                    itemBuilder: (context, index) {
                      Blog blog = _blogList[index];
                      return BlogItem(blog: blog);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 30),
                child: Text(
                  'WATCH IT',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 180,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _blogList.length,
                    itemBuilder: (context, index) {
                      BlogVideo video = _videoList[index];
                      return Container(
                        margin: EdgeInsets.only(right: 10, left: 20),
                        width: 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.primaryColor),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 80.0, vertical: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 1,
                    textColor: Colors.white,
                    color: AppColors.secondaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      'Tell your Story to Us',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    onPressed: () {},
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
      ),
    );
  }
}
