import 'package:flutter/material.dart';

import '../models/blog.dart';
import '../constants/app_colors.dart';

class BlogItem extends StatelessWidget {
  final Blog blog;

  const BlogItem({Key key, @required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 20),
      width: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              // height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(blog.imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              blog.category,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Text(
              blog.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8, bottom: 8, top: 8),
              child: Row(
                children: [
                  Text(
                    'Read More >>',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                    size: 20,
                  ),
                  SizedBox(width: 4),
                  Text(
                    blog.likes.toString(),
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
