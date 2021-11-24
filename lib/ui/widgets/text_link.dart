import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextAlign? textAlign;

  const TextLink(
    this.text, {
    Key? key,
    this.textAlign = TextAlign.start,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        textAlign: textAlign,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      ),
    );
  }
}
