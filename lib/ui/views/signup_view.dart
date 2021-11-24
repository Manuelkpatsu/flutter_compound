import 'package:flutter/material.dart';
import 'package:fluttercompoundapp/core/view_models/signup_view_model.dart';
import 'package:fluttercompoundapp/ui/shared/ui_helpers.dart';
import 'package:fluttercompoundapp/ui/widgets/busy_button.dart';
import 'package:fluttercompoundapp/ui/widgets/input_field.dart';
import 'package:fluttercompoundapp/ui/widgets/text_link.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  static const routeName = 'SignUpView';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 38,
                      ),
                    ),
                    verticalSpaceLarge,
                    // TODO: Add additional user data here to save (episode 2)
                    InputField(
                      placeholder: 'Email',
                      controller: emailController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'Password',
                      password: true,
                      controller: passwordController,
                      additionalNote: 'Password has to be a minimum of 6 characters.',
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BusyButton(
                          title: 'Sign Up',
                          busy: model.busy,
                          onPressed: () {
                            model.signUp(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          },
                        )
                      ],
                    ),
                    verticalSpaceMedium,
                    TextLink(
                      'If you already have an account, login.',
                      textAlign: TextAlign.center,
                      onPressed: () {
                        model.navigateToLogin();
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
