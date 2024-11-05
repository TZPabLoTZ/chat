import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chat_controller.dart';
import '../widgets/button_save_edit.dart';
import '../widgets/colors.dart';
import '../widgets/end_drawer.dart';
import '../widgets/invite_text_form.dart';
import '../widgets/show_bottom_sheet.dart';
import 'chat_page.dart';

class GroupsPage extends StatelessWidget {
  final controller = Get.put(ChatController());

  final String userName;

  GroupsPage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colorBackground,
        leading: SizedBox.fromSize(),
        title: const Text(
          'Seus Grupos',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      endDrawer: EndDrawer(userName: userName),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: StreamBuilder(
                      stream: controller.getUserChatRooms(userName),
                      builder: (
                        context,
                        AsyncSnapshot<QuerySnapshot> snapshot,
                      ) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              "Ocorreu um erro ao carregar os grupos.",
                            ),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text("Nenhum grupo encontrado"),
                          );
                        }

                        final chatRooms = snapshot.data!.docs;

                        return ListView.builder(
                          itemCount: chatRooms.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final chatRoom = chatRooms[index];
                            final chatCode = chatRoom['chatCode'];
                            final groupName = chatRoom['groupName'];

                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: ListTile(
                                title: Text("Grupo: $groupName"),
                                subtitle: Text(
                                  "Criado por: ${chatRoom['createdBy']}",
                                ),
                                trailing: chatRoom['createdBy'] == userName
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          controller.deleteChatRoom(chatCode);
                                        },
                                      )
                                    : SizedBox.fromSize(),
                                onTap: () {
                                  Get.to(
                                    () => ChatPage(),
                                    arguments: {
                                      'name': userName,
                                      'chatCode': chatCode,
                                      'groupName': groupName
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 28,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            colorPrimary,
                          ),
                        ),
                        onPressed: () {
                          controller.groupNameController.clear();
                          showCustomBottomSheet(
                            context: context,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InviteTextForm(
                                  hintText: 'Digite o nome do grupo',
                                  controller: controller.groupNameController,
                                  textAlign: TextAlign.center,
                                  fillColor:
                                      const Color(0xff154689).withOpacity(0.1),
                                ),
                                const SizedBox(height: 18),
                                ButtonSaveEdit(
                                  onTap: () {
                                    if (controller
                                        .groupNameController.text.isEmpty) {
                                      Get.snackbar(
                                        "Atenção",
                                        "Você deve preencher o campo do nome do grupo.",
                                      );
                                      return;
                                    }
                                    Get.back();
                                    controller.createChatRoom(
                                      userName,
                                      controller.groupNameController.text,
                                    );
                                  },
                                  numberBorder: 12,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 8,
                                  ),
                                  title: 'Criar',
                                ),
                              ],
                            ),
                            backgroundColor: const Color(0xFFF1F1F1),
                          );
                        },
                        child: const Text(
                          'Crie um grupo',
                          style: TextStyle(
                            color: colorBackground,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            colorPrimary,
                          ),
                        ),
                        onPressed: () {
                          controller.codeController.clear();
                          showCustomBottomSheet(
                            context: context,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InviteTextForm(
                                  hintText: 'Digite o codigo do grupo',
                                  controller: controller.codeController,
                                  textAlign: TextAlign.center,
                                  fillColor:
                                      const Color(0xff154689).withOpacity(0.1),
                                  onChanged: (valeu) {
                                    controller.codeController.text = valeu;
                                  },
                                ),
                                const SizedBox(height: 18),
                                ButtonSaveEdit(
                                  onTap: () {
                                    String chatCode =
                                        controller.codeController.text.trim();
                                    if (chatCode.isNotEmpty) {
                                      Get.back();
                                      controller.joinChatRoom(
                                        userName,
                                        chatCode,
                                        controller.groupNameController.text,
                                      );
                                    } else {
                                      Get.snackbar(
                                        "Erro",
                                        "O campo do grupo não pode estar vazio",
                                      );
                                    }
                                  },
                                  numberBorder: 12,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 8,
                                  ),
                                  color: colorPrimary,
                                  titleColor: Colors.white,
                                  title: 'Entrar',
                                ),
                              ],
                            ),
                            backgroundColor: Colors.white,
                          );
                        },
                        child: const Text(
                          'Entrar no Grupo',
                          style: TextStyle(
                            color: colorBackground,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
