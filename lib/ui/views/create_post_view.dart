import 'package:flutter/material.dart';
import 'package:fluttercompoundapp/core/models/post.dart';
import 'package:fluttercompoundapp/core/view_models/create_post_view_model.dart';
import 'package:fluttercompoundapp/ui/shared/ui_helpers.dart';
import 'package:fluttercompoundapp/ui/widgets/input_field.dart';
import 'package:stacked/stacked.dart';

class CreatePostView extends StatelessWidget {
  final Post? editingPost;
  final TextEditingController titleController = TextEditingController();

  CreatePostView({Key? key, this.editingPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreatePostViewModel>.reactive(
      viewModelBuilder: () => CreatePostViewModel(),
      onModelReady: (model) {
        // update the text in the controller
        titleController.text = editingPost!.title;

        // set the editting post
        model.setEditingPost(editingPost!);
      },
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: !model.busy
              ? const Icon(Icons.add)
              : const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
          onPressed: () {
            if (!model.busy) {
              model.addPost(title: titleController.text);
            }
          },
          backgroundColor:
              !model.busy ? Theme.of(context).primaryColor : Colors.grey[600],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(40),
                const Text(
                  'Create Post',
                  style: TextStyle(fontSize: 26),
                ),
                verticalSpaceMedium,
                InputField(
                  placeholder: 'Title',
                  controller: titleController,
                ),
                verticalSpaceMedium,
                const Text('Post Image'),
                verticalSpaceSmall,
                GestureDetector(
                  onTap: () {
                    model.selectImage();
                  },
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: model.selectedImage == null ? Text(
                      'Tap to add post image',
                      style: TextStyle(color: Colors.grey[400]),
                    ) : Image.file(model.selectedImage!),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
