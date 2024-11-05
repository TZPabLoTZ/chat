import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/chat_controller.dart';
import '../widgets/colors.dart';
import '../widgets/invite_text_form.dart';

class ChatPage extends StatelessWidget {
  final controller = Get.put(ChatController());

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    final String userName = args['name'] ?? '';
    final String chatCode = args['chatCode'] ?? '';
    final String groupName = args['groupName'] ?? '';

    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colorBackground,
        title: Text(
          groupName,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: chatCode));
              Get.snackbar("Tudo Certo!", 'Código copiado');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: colorWhite,
              ),
              child: Row(
                children: [
                  const Icon(Icons.copy, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    chatCode,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.chatRepository.getMessagesStream(chatCode),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isSentByUser = message['sender'] == userName;

                    return Align(
                      alignment: isSentByUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isSentByUser
                              ? colorPrimary.withOpacity(0.85)
                              : colorWhite,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: isSentByUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              isSentByUser ? 'Eu' : message['sender'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    isSentByUser ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              message['text'],
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color:
                                    isSentByUser ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: InviteTextForm(
                    hintText: 'Escreva uma mensagem',
                    controller: controller.messageController,
                    textAlign: TextAlign.center,
                    fillColor: const Color(0xff154689).withOpacity(0.1),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    await controller.sendMessage(chatCode, userName);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
