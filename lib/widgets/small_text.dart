import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  double height;
  bool maxLines;

  SmallText({
    super.key,
    required this.text,
    this.color = const Color(0xFFccc7c5),
    this.size = 12,
    this.height = 1.2,
    this.maxLines = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        height: height,
      ),
      maxLines: maxLines ? 2 : 1,
      overflow: maxLines ? TextOverflow.ellipsis : null,
    );
  }
}
