import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/colors.dart';
import '../widgets/invite_text_form.dart';
import 'groups_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Bem vindo!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Coloque um nome para começarmos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              InviteTextForm(
                hintText: "Escreva seu nome",
                fillColor: Colors.white,
                controller: nameController,
                borderValue: 10,
                textAlign: TextAlign.center,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
                onChanged: (valeu) {
                  nameController.text = valeu;
                },
              ),
              const SizedBox(height: 45),
              ElevatedButton(
                onPressed: () {
                  String name = nameController.text.trim();
                  if (name.isNotEmpty) {
                    nameController.clear();

                    Get.offAll(
                      () => GroupsPage(userName: name),
                      arguments: name,
                    );
                  } else {
                    Get.snackbar(
                      "Erro",
                      "O nome não pode ficar em branco",
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorPrimary,
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Entrar",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: colorBackground,
    );
  }
}
