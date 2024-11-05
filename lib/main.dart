import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';
import 'controllers/chat_controller.dart';
import 'firebase_options.dart';
import 'pages/chat_page.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      home: Obx(
        () {
          return Get.find<AuthController>().isLoggedIn.value
              ? ChatPage()
              : LoginPage();
        },
      ),
      initialBinding: BindingsBuilder(
        () {
          Get.put(AuthController());
          Get.put(ChatController());
        },
      ),
    );
  }
}
