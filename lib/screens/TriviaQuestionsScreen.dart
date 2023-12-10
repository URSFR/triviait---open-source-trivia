import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:triviait/controllers/triviaController.dart';
import 'package:triviait/firebase/firebaseQuery.dart';

import '../widgets/commonButton.dart';

class TriviaQuestionsScreen extends StatefulWidget {
  const TriviaQuestionsScreen({super.key});

  @override
  State<TriviaQuestionsScreen> createState() => _TriviaQuestionsScreenState();
}

class _TriviaQuestionsScreenState extends State<TriviaQuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments[0]["name"]),
        backgroundColor: Colors.blue,
      ),
      body: GetBuilder<TriviaController>(
        init: TriviaController(),
        id: "triviaDetailsScreen",
        builder: (controller) {
            controller.getQuestions(id: Get.arguments[0]["id"]);
          return controller.questionAnswerList.isNotEmpty?SizedBox(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: size.height, minHeight: 56.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                   itemCount: controller.questionAnswerList.length,
                   separatorBuilder: (context, index) {
                     return const SizedBox(height: 15,);
                   },
                   itemBuilder: (context, index){
                     return Container(
                       padding: const EdgeInsets.all(6),
                       decoration: BoxDecoration(
                         border: Border.all(color: Colors.blue,width: 1.5)
                       ),
                       child: Column(
                         children: [
                           SizedBox(
                               width: size.width,
                               child: Text(controller.questionAnswerList[index]["question"],textAlign: TextAlign.left,style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),)),
                           const SizedBox(height: 5,),
                           ListView.separated(
                             shrinkWrap: true,
                             itemCount: controller.questionAnswerList[index]["options"].length,
                             separatorBuilder: (context, index) {
                               return const Divider();
                             },
                             itemBuilder: (context, indexInside){
                               return Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Row(
                                   children: [
                                     Text("${controller.questionAnswerList[index]["options"][indexInside]}",style: GoogleFonts.roboto(fontSize: 15),),
                                     const SizedBox(width: 45,),
                                     Checkbox(value: controller.choosedOption[index] == controller.questionAnswerList[index]["options"][indexInside]?true:false, onChanged: (value){
                                       controller.choosedOption[index] = controller.questionAnswerList[index]["options"][indexInside];
                                       controller.update(["triviaDetailsScreen"]);
                                     }),
                                   ],
                                 ),
                               );
                             },
                           ),
                         ],
                       ),
                     );

                   }),
                ),
              ),
                CommonButton(
                  onPressed: (){
                    controller.checkAnswers(id: Get.arguments[0]["id"], name: Get.arguments[0]["name"]);
                  },
                  title: "Check Answers",
                ),
              ],),
            ),
          ):const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

