import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pintor/controllers/chat_controller.dart';
import 'package:pintor/models/constant_model.dart';
import 'package:flutter/material.dart';
import 'package:pintor/models/theme_model.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  static String route = 'chat_view';
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  ChatController chatController = ChatController();
  TextEditingController textEditingController = TextEditingController();
  String string = '';
  String url = '';

  @override
  Widget build(BuildContext context) {
    // Chat View
    return Consumer<ThemeModel>(
      builder: (context, value, child) => Scaffold(
        // Scaffold: App Bar
        appBar: AppBar(
          // App Bar: 'pintor'
          title: const Text(
            'pintor',
            style: mediumTextStyle,
          ),
          actions: [
            // App Bar: Brightness
            IconButton(
              onPressed: () => setState(() => value.changeBrightness()),
              icon: value.brightness == Brightness.light
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Body: Image
              Expanded(
                child: url.isEmpty
                    ? Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                      )
                    : Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Image(image: NetworkImage(url)),
                      ),
              ),

              // Body: Textfield
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        onChanged: (value) => string = value,
                        style: mediumTextStyle.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    mediumSizedBox,
                    IconButton(
                      onPressed: () async {
                        if (string.isNotEmpty) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          textEditingController.clear();
                          EasyLoading.show(status: 'Generating');

                          value.brightness == Brightness.light
                              ? url = await chatController
                                  .generate('$string with white background')
                              : url = await chatController
                                  .generate('$string with black background');

                          EasyLoading.dismiss();
                          setState(() => string = '');
                        }
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
