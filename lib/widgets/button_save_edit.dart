import 'package:flutter/material.dart';

class ButtonSaveEdit extends StatelessWidget {
  final String title;
  final double? width;
  final Color? titleColor;
  final Color? color;
  final double numberBorder;
  final BoxBorder? border;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;

  const ButtonSaveEdit({
    super.key,
    required this.title,
    this.numberBorder = 24,
    this.color = const Color(0xff154689),
    this.fontWeight = FontWeight.bold,
    this.titleColor = Colors.white,
    this.border,
    this.fontSize,
    this.padding,
    this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(numberBorder),
          border: border,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: titleColor,
          ),
        ),
      ),
    );
  }
}
