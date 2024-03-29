import 'package:flutter/material.dart';
import 'package:fluttercompoundapp/core/view_models/home_view_model.dart';
import 'package:fluttercompoundapp/ui/shared/ui_helpers.dart';
import 'package:fluttercompoundapp/ui/widgets/post_item.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.listenToPosts(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: !model.busy ? const Icon(Icons.add) : const CircularProgressIndicator(),
          onPressed: model.navigateToCreateView,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(20),
                Row(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                      child: Image.asset('assets/images/title.png'),
                    ),
                  ],
                ),
                Expanded(
                  child: model.posts.isNotEmpty
                      ? ListView.builder(
                          itemCount: model.posts.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () => model.editPost(index),
                            child: PostItem(
                              post: model.posts[index],
                              onDeleteItem: () => model.deletePost(index),
                            ),
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
