// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class Utils {
  static launchURL(String url) async {
    if (Platform.isAndroid) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      await launchUrl(Uri.parse(Uri.encodeFull(url)));
    }
  }
}
