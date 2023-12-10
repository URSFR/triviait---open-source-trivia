import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/triviaController.dart';
import '../utils/colors.dart';
import '../utils/helpers.dart';
import '../widgets/appBarButton.dart';

class TriviaListScreen extends StatelessWidget {
  const TriviaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController filterET = TextEditingController();
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection('trivias');
    bool forsenIsWriting = true;

    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text("Trivia IT!"),
            GestureDetector(
                onTap: () async {
                  await launchUrl(Uri.parse("https://github.com/URSFR"));
                },
                child: Text("Made by URSFR",style: GoogleFonts.adamina(fontSize: 11,color: Colors.black),)),
          ],
        ),
        actions: [
          AppBarButton(title: "New Trivia",icon: const Icon(Icons.add,color: Colors.black,),backgroundColor: greenBackground,onPressed: (){
            Get.toNamed("/trivia/creation");
          },),
        ],
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<TriviaController>(
          id: "triviaList",
          builder: (controller)=>
           Column(children: [
             Padding(
               padding: const EdgeInsets.all(16.0),
               child: Container(
                   width: size.width,
                   child: TextFormField(
                     onChanged: (value){
                       if(value.trim().isEmpty||value.trim()==""){
                         forsenIsWriting=false;
                         controller.update(["triviaList"]);

                         Future.delayed(const Duration(milliseconds: 50), () {
                             query= FirebaseFirestore.instance.collection('trivias');
                             forsenIsWriting=true;
                             controller.update(["triviaList"]);

                         });
                       }
                     },
                     controller: filterET,
                   decoration: InputDecoration(
                     suffixIcon: IconButton(onPressed: (){
                       if(filterET.text.trim().isNotEmpty){
                         forsenIsWriting=false;
                         controller.update(["triviaList"]);

                         Future.delayed(const Duration(milliseconds: 50), () {

                           query= FirebaseFirestore.instance.collection('trivias').orderBy("name").where("name",isEqualTo: filterET.text);
                           forsenIsWriting=true;

                           controller.update(["triviaList"]);
                         });
                       }

                     }, icon: const Icon(Icons.search)),
                     hintText: "Filter by Trivia Name"
                   ),)),
             ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: Visibility(
                  visible: forsenIsWriting,
                  child: FirestorePagination(
                    physics: const NeverScrollableScrollPhysics(),
                    isLive: true,
                    query: query,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemBuilder: (context, documentSnapshot, index) {
                      final data = documentSnapshot.data() as Map<String, dynamic>;
                      // print(documentSnapshot.id);
                      return InkWell(
                        onTap: (){
                          controller.questionAnswerList = [];
                          controller.choosedOption = [];
                          Future.delayed(const Duration(seconds: 1), () {
                            print(documentSnapshot.id);
                            Get.toNamed("/question",arguments: [{"id": documentSnapshot.id,"name":data["name"]}]);
                          });
                        },
                        child: Column(children: [
                          SizedBox(
                            width: size.width, child: Text("Trivia Name: ${data["name"]}",textAlign: TextAlign.left,style: GoogleFonts.roboto(fontSize: 18),)),
                          SizedBox(
                              width: size.width,
                              child: Text("Author: ${data["createdBy"]}",style: GoogleFonts.roboto(fontSize: 14))),
                          SizedBox(
                              width: size.width,
                              child: Text("Created at: ${parseTimestamp(data["createdAt"])}",style: GoogleFonts.roboto(fontSize: 14))),

                        ],),
                      );
                      // Do something cool with the data
                    },
                  ),
                ),
              ),
            ),
          ],),
        ),
      ),
    );
  }
}




