import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pintor/models/constant_model.dart';
import 'package:pintor/views/sign_up_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pintor/views/main_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: must_be_immutable
class SignInView extends StatefulWidget {
  static String route = 'sign_in_view';
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String email = '';

  String password = '';

  String error = '';

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

          //Text: error
          error.isEmpty
              ? Container()
              : Row(
                  children: [
                    Expanded(
                      child: Text(
                        error,
                        textAlign: TextAlign.end,
                        style: smallTextStyle.copyWith(color: Colors.red),
                      ),
                    ),
                  ],
                ),
          error.isEmpty ? largeSizedBox : mediumSizedBox,

          // Button: 'Sign In'
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () async {
                    EasyLoading.show(status: 'Sign In');
                    try {
                      await firebaseAuth.signOut();

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
                      setState(
                        () => error =
                            e.toString().split(' ').sublist(1).join(' '),
                      );

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
                  onPressed: () async {
                    EasyLoading.show(status: 'Sign In');
                    try {
                      await firebaseAuth.signOut();

                      final GoogleSignInAccount? googleUser =
                          await GoogleSignIn().signIn();

                      final GoogleSignInAuthentication? googleAuth =
                          await googleUser?.authentication;

                      final credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth?.accessToken,
                        idToken: googleAuth?.idToken,
                      );

                      await FirebaseAuth.instance
                          .signInWithCredential(credential);

                      EasyLoading.dismiss();
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, MainView.route);
                    } catch (e) {
                      setState(
                        () => error =
                            e.toString().split(' ').sublist(1).join(' '),
                      );

                      EasyLoading.dismiss();
                    }
                  },
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
