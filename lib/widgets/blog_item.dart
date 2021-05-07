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

                  TextButton(onPressed: (){
                    AlertDialog(
                      title: Text('Test'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('This is a demo alert dialog.'),
                            Text('Would you like to approve of this message?'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Approve'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                    ),
                  Spacer(),
                  IconButton(
                    icon: new Icon(Icons.arrow_forward_ios),
                    onPressed: (){},
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
