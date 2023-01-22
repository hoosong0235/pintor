import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pintor/models/constant_model.dart';
import 'package:pintor/views/sign_up_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pintor/views/main_view.dart';

// ignore: must_be_immutable
class SignInView extends StatelessWidget {
  static String route = 'sign_in_view';
  SignInView({super.key});

  String email = '';
  String password = '';

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // Sign In View
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text: 'Welcome Back'
          Text(
            'Welcome Back',
            style: largeTextStyle.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),

          // Button: 'Don't have an account? Sign Up'
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account?',
                style: mediumTextStyle.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    isScrollControlled: true,
                    useSafeArea: true,
                    context: context,
                    builder: (context) => SignUpView(),
                  );
                },
                child: const Text(
                  'Sign Up',
                  style: mediumTextStyle,
                ),
              ),
            ],
          ),
          largeSizedBox,

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

          // Button: 'Sign In'
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () async {
                    EasyLoading.show(status: 'Sign In');
                    try {
                      await firebaseAuth.signInWithEmailAndPassword(
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
                  child: const Text('Sign In'),
                ),
              ),
            ],
          ),
          smallSizedBox,

          // Divider: 'Or sign in with'
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: Divider(),
              ),
              smallSizedBox,
              Text(
                'Or sign in with',
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
