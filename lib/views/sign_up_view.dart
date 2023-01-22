import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pintor/models/constant_model.dart';
import 'package:pintor/views/main_view.dart';
import 'package:pintor/views/sign_in_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class SignUpView extends StatelessWidget {
  static String route = 'sign_up_view';
  SignUpView({super.key});

  String name = '';
  String email = '';
  String password = '';

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // Sign Up View
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text: 'Create an Account'
          Text(
            'Create an Account',
            style: largeTextStyle.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),

          // Button: 'Already a member? Sign In'
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already a member?',
                style: mediumTextStyle.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    isScrollControlled: true,
                    useSafeArea: true,
                    context: context,
                    builder: (context) => SignInView(),
                  );
                },
                child: const Text(
                  'Sign In',
                  style: mediumTextStyle,
                ),
              ),
            ],
          ),
          largeSizedBox,

          // TextField: 'Name'
          TextField(
            style: mediumTextStyle.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onChanged: (value) => name = value,
            decoration: const InputDecoration(
              labelText: 'Name',
              labelStyle: smallTextStyle,
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          smallSizedBox,

          // TextField: 'Email address'
          TextField(
            style: mediumTextStyle.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onChanged: (value) => email = value,
            decoration: const InputDecoration(
              labelText: 'Email address',
              labelStyle: smallTextStyle,
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          smallSizedBox,

          // TextField: 'Password'
          TextField(
            style: mediumTextStyle.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onChanged: (value) => password = value,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              labelStyle: smallTextStyle,
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          largeSizedBox,

          // Button: 'Sign Up'
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () async {
                    EasyLoading.show(status: 'Sign Up');
                    try {
                      await firebaseAuth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      EasyLoading.dismiss();
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, MainView.route);
                    } catch (e) {
                      EasyLoading.dismiss();
                    }
                  },
                  child: const Text('Sign Up'),
                ),
              ),
            ],
          ),
          smallSizedBox,

          // Divider: 'Or sign up with'
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: Divider(),
              ),
              smallSizedBox,
              Text(
                'Or sign up with',
                style: smallTextStyle.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              smallSizedBox,
              const Expanded(
                child: Divider(),
              ),
            ],
          ),
          smallSizedBox,

          // Button: 'Google'
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Google'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
