import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import 'colors.dart';
import 'utils.dart';

class EndDrawer extends StatelessWidget {
  EndDrawer({
    super.key,
    required this.userName,
  });

  final String userName;
  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: colorBackground,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  'Meu perfil',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorWhite,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Nome',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: colorPrimary.withOpacity(0.1),
                      ),
                      child: Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    const String message =
                        'Opa, Voçê pode melhorar o app chat ?';
                    Utils.launchURL(
                        'https://api.whatsapp.com/send?l=pt_br&phone=55${66984084478}&text=$message');
                  },
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Faça uma sugestão',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => controller.signOut(),
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.logout_outlined),
                    SizedBox(width: 12),
                    Text(
                      'Sair',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
