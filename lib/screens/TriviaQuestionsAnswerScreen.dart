import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/triviaController.dart';
import '../widgets/commonButton.dart';

class TriviaQuestionsAnswerScreen extends StatelessWidget {
  const TriviaQuestionsAnswerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments[0]["name"]),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<TriviaController>(
        id: "triviaDetailsScreen",
        builder: (controller) {
          return SizedBox(
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

                          return const Divider();
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
                                    return Column(
                                      children: [
                                        controller.questionAnswerList[index]["answer"] == controller.questionAnswerList[index]["options"][indexInside]?Container(
                                          alignment: Alignment.centerLeft,
                                          width: size.width,
                                          child: controller.questionAnswerList[index]["reason"]!=null&&controller.questionAnswerList[index]["reason"]!=""?ExpansionTile(
                                            shape: Border.all(color: Colors.transparent),
                                            expandedAlignment: Alignment.centerLeft,
                                            title: Text(controller.questionAnswerList[index]["answer"],style: GoogleFonts.roboto(color: Colors.green),)
                                            ,children: [Text(controller.questionAnswerList[index]["reason"],style: GoogleFonts.roboto(),)],
                                          ):Container(padding: EdgeInsets.all(10),width: size.width,child: Text("${controller.questionAnswerList[index]["options"][indexInside]}",textAlign: TextAlign.left,style: GoogleFonts.roboto(color: Colors.green,fontSize: 20),)),
                                        ):controller.choosedOption[index] == controller.questionAnswerList[index]["options"][indexInside] && controller.questionAnswerList[index]["answer"] != controller.questionAnswerList[index]["options"][indexInside]?
                                        Container(padding: const EdgeInsets.all(10),width: size.width,child: Text("${controller.questionAnswerList[index]["options"][indexInside]}",textAlign: TextAlign.left,style: GoogleFonts.roboto(color: Colors.red,fontSize: 15),)):
                                            Container(padding: const EdgeInsets.all(10),width: size.width, child: Text(controller.questionAnswerList[index]["options"][indexInside],textAlign: TextAlign.left,style: GoogleFonts.roboto(fontSize: 15)),
                                            ),
                                      ],
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
                    controller.leaveTrivia();
                  },
                  title: "Leave Trivia",
                ),
              ],),
            ),
          );
        },
      ),
    );

  }
}
