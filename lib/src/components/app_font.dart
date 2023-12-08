import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFont extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final double? lineHeight;
  final double? letterSpacing;
  final int? maxLine;
  final TextOverflow? overflow;
  final TextDecoration? decoration;

  const AppFont(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.color = Colors.white,
    this.fontWeight = FontWeight.normal,
    this.size = 15,
    this.maxLine,
    this.lineHeight,
    this.overflow,
    this.letterSpacing,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: overflow,
      style: GoogleFonts.notoSans(
        fontSize: size,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight,
        color: color,
        height: lineHeight,
        decoration: decoration,
      ),
    );
  }
}
