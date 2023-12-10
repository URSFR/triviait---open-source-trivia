import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarButton extends StatelessWidget {
  final Color backgroundColor;
  final void Function()? onPressed;
  final Icon icon;
  final String title;
  const AppBarButton({
    super.key, required this.backgroundColor, required this.onPressed, required this.icon, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
              side: const BorderSide(color: Colors.black)
          ),
        ),
        onPressed: onPressed,
        label: Text(title,style: GoogleFonts.roboto(color: Colors.black),),
        icon: icon,),
    );
  }
}