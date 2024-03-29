import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttercompoundapp/core/models/post.dart';

class PostItem extends StatelessWidget {
  final Post post;
  final Function onDeleteItem;

  const PostItem({Key? key, required this.post, required this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: post.imageUrl != null ? null : 60,
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  post.imageUrl != null
                      ? SizedBox(
                          height: 250,
                          child: CachedNetworkImage(
                            imageUrl: post.imageUrl!,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        )
                      : Container(),
                  Text(post.title),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              onDeleteItem();
            },
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.grey.shade200, spreadRadius: 3)
        ],
      ),
    );
  }
}
