import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InviteTextForm extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Function(String)? onChanged;
  final Function()? onTap;
  final int? maxLength;
  final double? borderValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final Color? fillColor;
  final Color? hintColor;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final EdgeInsetsGeometry? contentPadding;

  const InviteTextForm({
    super.key,
    this.controller,
    required this.hintText,
    this.onChanged,
    this.onTap,
    this.maxLength,
    this.borderValue = 12,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.fillColor = Colors.white,
    this.hintColor = const Color(0xFFCCCBCB),
    this.textAlign = TextAlign.start,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.focusNode,
    this.maxLengthEnforcement,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 1,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLengthEnforcement: maxLengthEnforcement,
      focusNode: focusNode,
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      maxLength: maxLength,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly,
      textAlign: textAlign,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        constraints: BoxConstraints.loose(
          Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          ),
        ),
        fillColor: fillColor,
        filled: true,
        prefixIcon: prefixIcon,
        contentPadding: contentPadding,
        counterText: '',
        hintStyle: const TextStyle(
          color: Colors.black45,
          fontFamily: 'Montserrat',
          fontSize: 15,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(borderValue!)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(borderValue!)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(borderValue!)),
        ),
        hintText: hintText,
      ),
    );
  }
}
