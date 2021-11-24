import 'package:flutter/material.dart';
import 'package:fluttercompoundapp/core/view_models/login_view_model.dart';
import 'package:fluttercompoundapp/ui/shared/ui_helpers.dart';
import 'package:fluttercompoundapp/ui/widgets/busy_button.dart';
import 'package:fluttercompoundapp/ui/widgets/input_field.dart';
import 'package:fluttercompoundapp/ui/widgets/text_link.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  static const routeName = 'LoginView';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset('assets/images/title.png'),
              ),
              InputField(
                placeholder: 'Email',
                controller: emailController,
              ),
              verticalSpaceSmall,
              InputField(
                placeholder: 'Password',
                password: true,
                controller: passwordController,
              ),
              verticalSpaceMedium,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BusyButton(
                    title: 'Login',
                    busy: model.busy,
                    onPressed: () {
                      model.login(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    },
                  )
                ],
              ),
              verticalSpaceMedium,
              TextLink(
                'Create an Account if you\'re new.',
                onPressed: () {
                  model.navigateToSignUp();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
