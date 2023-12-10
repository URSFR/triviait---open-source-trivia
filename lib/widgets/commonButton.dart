import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const CommonButton({
    super.key, required this.onPressed, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed:onPressed, child: Text(title,style: GoogleFonts.roboto(fontSize: 18,color: Colors.blue),));
  }
}