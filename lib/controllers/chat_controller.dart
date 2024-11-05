import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/chat_page.dart';
import '../repository/chat_repository.dart';

class ChatController extends GetxController {
  final chatRepository = ChatRepository();
  final codeController = TextEditingController();
  final groupNameController = TextEditingController();
  final messageController = TextEditingController();

  void createChatRoom(String userName, String groupName) async {
    final String chatCode =
        DateTime.now().millisecondsSinceEpoch.toString().substring(7);

    await chatRepository.createChatRoom(chatCode, userName, groupName);

    Get.to(() => ChatPage(), arguments: {
      'name': userName,
      'chatCode': chatCode,
      'groupName': groupName,
    });

    update();
  }

  void joinChatRoom(String userName, String chatCode, String groupName) async {
    final snapshot = await chatRepository.getChatRoom(chatCode);

    if (snapshot?.exists ?? false) {
      await chatRepository.addUserToChatRoom(chatCode, userName);

      Get.to(() => ChatPage(), arguments: {
        'name': userName,
        'chatCode': chatCode,
        'groupName': groupName,
      });
    } else {
      Get.snackbar("Erro", "Grupo não encontrada");
    }
  }

  Future<void> sendMessage(String chatCode, String userName) async {
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      await chatRepository.sendMessage(chatCode, userName, text);
      messageController.clear();
    }
  }

  void deleteChatRoom(String chatCode) async {
    await FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(chatCode)
        .delete();

    Get.snackbar(
      "Sucesso",
      "Grupo excluída com sucesso",
    );
  }

  Stream<QuerySnapshot> getUserChatRooms(String userName) {
    return chatRepository.getUserChatRooms(userName);
  }
}
