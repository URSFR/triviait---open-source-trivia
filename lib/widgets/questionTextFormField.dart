import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionTextFormField extends StatelessWidget {
  const QuestionTextFormField({
    super.key,
    required this.width,
    required this.controller,
    required this.onChanged,
    required this.title,
    this.optional = false
  });

  final bool optional;
  final void Function(String)? onChanged;
  final double width;
  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black,width: 0.5)
      ),
      child: Column(
        children: [
          SizedBox(
              width: width,
              child: Text(title,textAlign: TextAlign.left,style: GoogleFonts.roboto(fontSize: 17,fontWeight: FontWeight.w600),)
          ),
          SizedBox(
            width: width,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: optional?"Optional":null,
              ),
              controller: controller,
              onChanged: onChanged,),
          ),
        ],
      ),
    );
  }
}