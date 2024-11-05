import 'package:flutter/material.dart';

class ShowCustomBottomSheet extends StatelessWidget {
  final Widget child;

  const ShowCustomBottomSheet({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.84,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            // boxShadow: [
            //   BoxShadow(
            //     color: Color(0xFF797979),
            //     offset: Offset(0, 0),
            //     blurRadius: 1,
            //     blurStyle: BlurStyle.outer,
            //   ),
            // ],
          ),
          child: child,
        ),
      ),
    );
  }
}

showCustomBottomSheet({
  required BuildContext context,
  required Widget child,
  required Color backgroundColor,
}) {
  showModalBottomSheet(
    elevation: 0,
    context: context,
    isScrollControlled: true,
    barrierColor: Colors.transparent,
    backgroundColor: backgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      // side: BorderSide(
      //   color: Color(0xFF797979),
      //   width: 1.5,
      // ),
    ),
    builder: (ctx) {
      return ShowCustomBottomSheet(
        child: child,
      );
    },
  );
}
