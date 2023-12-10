import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreationTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final int maxLength;
  final double width;
  final void Function(String)? onChanged;
  const CreationTextFormField({
    super.key, required this.title, this.maxLength = 15, required this.controller, this.width = 100, this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey,width: 2.0),
        borderRadius: BorderRadius.circular(8),

      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
                width: width,
                child: Text(title,style: GoogleFonts.roboto(fontSize: 23,fontWeight: FontWeight.w700),textAlign: TextAlign.left,)),
            SizedBox(
              width: width,
              child: TextFormField(
                onChanged: onChanged,
                controller: controller,
                maxLength: maxLength,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
