import 'package:flutter/material.dart';
import 'package:pintor/models/constant_model.dart';
import 'package:pintor/models/theme_model.dart';
import 'package:pintor/views/sign_in_view.dart';
import 'package:pintor/views/sign_up_view.dart';
import 'package:provider/provider.dart';

class InitialView extends StatefulWidget {
  static String route = 'initial_view';
  const InitialView({super.key});

  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  @override
  Widget build(BuildContext context) {
    // Initial View
    return Consumer<ThemeModel>(
      builder: (context, value, child) => Scaffold(
        // Scaffold: App Bar
        appBar: AppBar(
          actions: [
            // App Bar: Brightness
            IconButton(
              onPressed: () => setState(() => value.changeBrightness()),
              icon: Theme.of(context).brightness == Brightness.light
                  ? const Icon(Icons.wb_sunny_outlined)
                  : const Icon(Icons.wb_sunny),
            ),

            // App Bar: Colorscheme
            PopupMenuButton<Color>(
              onSelected: (color) => setState(
                () => value.changeColorSchemeSeed(color),
              ),
              itemBuilder: (context) => List.generate(
                colorOptions.length,
                (index) => PopupMenuItem(
                  value: colorOptions[index],
                  child: Row(
                    children: [
                      Icon(
                        value.colorSchemeSeed == colorOptions[index]
                            ? Icons.color_lens
                            : Icons.color_lens_outlined,
                        color: colorOptions[index],
                      ),
                      smallSizedBox,
                      Text(
                        colorText[index],
                        style: mediumTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        // Scaffold: Body
        body: Padding(
          padding: largeEdgeInsets,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image: 'logo.png'
              const Expanded(child: smallSizedBox),
              const Image(
                image: AssetImage('assets/logo.png'),
                width: 128,
                height: 128,
              ),
              const Expanded(child: smallSizedBox),

              // Text: 'Your Next Image Generator'
              Text(
                'Your Next Image Generator',
                style: mediumTextStyle.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),

              // Text: 'Pintor'
              Text(
                'Pintor',
                style: largeTextStyle.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              largeSizedBox,

              // Button: 'Sign Up', and 'Sign In'
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: () => showModalBottomSheet(
                      isScrollControlled: true,
                      useSafeArea: true,
                      context: context,
                      builder: (context) => SignUpView(),
                    ),
                    child: const Text('Sign Up'),
                  ),
                  mediumSizedBox,
                  OutlinedButton(
                    onPressed: () => showModalBottomSheet(
                      isScrollControlled: true,
                      useSafeArea: true,
                      context: context,
                      builder: (context) => SignInView(),
                    ),
                    child: const Text('Sign In'),
                  ),
                ],
              ),
              const Expanded(child: smallSizedBox),
            ],
          ),
        ),
      ),
    );
  }
}
