import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../pages/login_page.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Rxn<User?> firebaseUser = Rxn<User?>();
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(auth.authStateChanges());
    ever(firebaseUser, (user) {
      isLoggedIn.value = user != null;
    });
  }

  void loginAnonymously() async {
    await auth.signInAnonymously();
  }

  void signOut() async {
    await auth.signOut();

    Get.offAll(() => LoginPage());
  }
}
