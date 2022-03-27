// ignore_for_file: prefer_const_constructors
import 'package:flash_chat/components/progress_loader.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends ConsumerWidget {
  static const String id = 'login_screen';


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(authProvider);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 237, 237),
      body: ProgressLoader(
        loading: model.loading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) => model.email = value,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (v) => model.password = v,
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                colour: Colors.lightBlueAccent,
                title: 'Log in',
                onPressed: () async {
                  model.login(onDone: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, ChatScreen.id, (route) => false);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
