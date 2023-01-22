import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pintor/models/theme_model.dart';
import 'package:pintor/views/main_view.dart';
import 'package:pintor/views/initial_view.dart';
import 'package:pintor/views/sign_in_view.dart';
import 'package:pintor/views/sign_up_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Pintor());
}

class Pintor extends StatelessWidget {
  const Pintor({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (context) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, value, child) => MaterialApp(
          builder: EasyLoading.init(),
          initialRoute: InitialView.route,
          routes: {
            InitialView.route: (context) => const InitialView(),
            SignUpView.route: (context) => SignUpView(),
            SignInView.route: (context) => SignInView(),
            MainView.route: (context) => const MainView(),
          },
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: value.colorSchemeSeed,
            brightness: value.brightness,
          ),
        ),
      ),
    );
  }
}
