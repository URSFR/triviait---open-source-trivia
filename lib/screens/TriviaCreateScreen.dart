import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:triviait/controllers/triviaCreationController.dart';
import 'package:triviait/firebase/firebaseQuery.dart';
import 'package:triviait/utils/colors.dart';

import '../widgets/appBarButton.dart';
import '../widgets/creationTextFormField.dart';
import '../widgets/questionTextFormField.dart';

class TriviaCreateScreen extends StatelessWidget {
  const TriviaCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GetBuilder<TriviaCreationController>(
      id: "triviaCreation",
      builder: (controller)=> Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: controller.nameET.text.isEmpty?const Text("New Trivia"):Text(controller.nameET.text),
          actions: [
            AppBarButton(title: "Publish Trivia",backgroundColor: blueBackground,onPressed: (){
              controller.uploadTrivia();
            }, icon: const Icon(Icons.check,color: Colors.green,shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: 1.0,
              ),
            ],),),
          ],
        ),
        body: SizedBox(
             width: size.width,
             height: size.height,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: SingleChildScrollView(
                 child: Column(children: [
                   CreationTextFormField(width: size.width,title: 'Trivia Name', controller: controller.nameET,onChanged: (value){
                     controller.update(["triviaCreation"]);
                   },),
                   const SizedBox(height: 25,),
                   CreationTextFormField(width: size.width,title: 'Author Name', controller: controller.authorET),
                   const SizedBox(height: 10,),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(children: [
                       Text("Questions",style: GoogleFonts.roboto(fontSize: 23,fontWeight: FontWeight.w600),),
                       IconButton(onPressed: (){
                         controller.newTriviaQuestion();
                       }, icon: const Icon(Icons.add))
                     ],),
                   ),
                   const SizedBox(height: 5,),
                   ListView.separated(
                     physics: const NeverScrollableScrollPhysics(),
                       shrinkWrap: true,
                       itemBuilder: (context, index){
                     TextEditingController questionET = TextEditingController();
                     TextEditingController reasonET = TextEditingController();
                     questionET.text = controller.listQuestions[index]["question"]??"";
                     reasonET.text = controller.listQuestions[index]["reason"];
                     return Container(
                       padding: const EdgeInsets.all(8),
                       decoration: BoxDecoration(
                           border:Border.all(color: Colors.black,width: 1.5)
                       ),
                       child: ExpansionTile(
                         subtitle: questionET.text.isEmpty||controller.listQuestions[index]["options"].contains("")||controller.listQuestions[index]["options"].contains(null)||controller.listQuestions[index]["options"].length<=1||controller.listQuestions[index]["answer"]==null||controller.listQuestions[index]["answer"]==""?
                         Text("Not Completed",style: GoogleFonts.roboto(color: Colors.red),):Text("Completed",style: GoogleFonts.roboto(color: Colors.green),),
                         title: Text("Question ${index+1}"),
                         trailing: IconButton(icon: const Icon(Icons.delete,color: Colors.red,),onPressed: (){
                           controller.removeTriviaQuestion(index: index);
                         },),
                         children: [
                           Column(children: [
                             const SizedBox(height: 5,),
                             QuestionTextFormField(title: "What is the question?",width: size.width, controller: questionET,onChanged: (value){
                               controller.listQuestions[index]["question"]=value;
                             },),
                             Container(
                               margin: const EdgeInsets.only(top: 10),
                               width: size.width,
                               child: Row(
                                 children: [
                                   Text("What are the options?",textAlign: TextAlign.left,style: GoogleFonts.roboto(fontSize: 17,fontWeight: FontWeight.w600)),
                                  IconButton(onPressed: (){
                                    controller.listQuestions[index]["options"].add("");
                                    controller.update(["triviaCreation"]);
                                  }, icon: const Icon(Icons.add))
                                 ],
                               ),
                             ),
                             Container(
                               margin: const EdgeInsets.only(top: 5),
                               width:size.width,
                               child: ListView.separated(
                                 shrinkWrap: true,
                                   itemBuilder: (context, optionsIndex){
                                     TextEditingController optionET = TextEditingController();
                                     optionET.text = controller.listQuestions[index]["options"][optionsIndex];
                                     return Row(
                                       children: [
                                         Container(
                                           decoration: BoxDecoration(
                                               border: Border.all(color: Colors.black,width: 1.0)
                                           ),
                                           width: 200,
                                           child: TextFormField(
                                             controller: optionET,
                                             onFieldSubmitted: (value){
                                               controller.update(["triviaCreation"]);
                                             },
                                             onSaved: (value){
                                               controller.update(["triviaCreation"]);
                                             },
                                             onTapOutside: (value){
                                               controller.update(["triviaCreation"]);
                                             },
                                             onEditingComplete: (){
                                               controller.update(["triviaCreation"]);
                                             },
                                             onChanged: (value){
                                               controller.listQuestions[index]["options"][optionsIndex]=value;
                                             },),
                                         ),
                                         Checkbox(value: controller.listQuestions[index]["answer"]==controller.listQuestions[index]["options"][optionsIndex]?true:false, onChanged: (value){
                                           if(controller.listQuestions[index]["options"][optionsIndex]==""){
                                             controller.update(["triviaCreation"]);
                                           }else{
                                             controller.listQuestions[index]["answer"]=controller.listQuestions[index]["options"][optionsIndex];
                                             controller.update(["triviaCreation"]);
                                           }
                                         }),
                                         IconButton(onPressed: (){
                                           controller.removeTriviaOption(index: index, optionsIndex: optionsIndex);
                                         }, icon: const Icon(Icons.delete,color: Colors.red,))
                                       ],
                                     );
                                   },
                                   separatorBuilder: (context, index){return const SizedBox(height: 5,);},
                                   itemCount:  controller.listQuestions[index]["options"].length),
                             ),
                             const SizedBox(height: 10,),
                             QuestionTextFormField(optional: true,title: "What is the reason of the answer?",width: size.width, controller: reasonET,onChanged: (value){
                               controller.listQuestions[index]["reason"]=value;
                             },),
                           ],
                         ),]
                       ),
                     );
                   }, separatorBuilder: (context, index){return const SizedBox(height: 5,);},
                       itemCount: controller.listQuestions.length),
                 ],),
               ),
             ),
           ),

      ),
    );
  }
}



