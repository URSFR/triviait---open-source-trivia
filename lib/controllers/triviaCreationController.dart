
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:triviait/firebase/firebaseQuery.dart';

class TriviaCreationController extends GetxController{
  static TriviaCreationController get instance => Get.find();

  TextEditingController authorET = TextEditingController();
  TextEditingController nameET = TextEditingController();
  TextEditingController correctAnswerWhyET = TextEditingController();
  List<Map> listQuestions = [];
  String correctAnswer = "";


  uploadTrivia(){
    EasyLoading.show(status: "LOADING");
    if(listQuestions.isEmpty || nameET.text.trim().isEmpty || authorET.text.trim().isEmpty){
      Get.snackbar("ERROR","Must complete all fields");
    }else{

      if (listQuestions.every((mapa) =>
      mapa['question'] != null &&
          mapa['question'] != '' &&
          mapa['answer'] != null &&
          mapa['answer'] != '' &&
          mapa['options'] != null &&
          mapa['options'] != '' &&
          mapa['options'].length >= 2)) {
        // Utilizando forEach para iterar sobre la lista de mapas
        FirestoreFunctions().createTrivia(author: authorET.text, name: nameET.text, questionsList:  listQuestions);

      }
      else{
        Get.snackbar("ERROR","Must complete all questions");
      }
    }
  }

  newTriviaQuestion(){
    listQuestions.add({
      "question":"",
      "answer":null,
      "options":[],
      "reason":"",
    });
    update(["triviaCreation"]);
  }

  removeTriviaQuestion({required int index}){
    listQuestions.removeAt(index);
    update(["triviaCreation"]);
  }

  removeTriviaOption({required int index, required int optionsIndex}){
    if(listQuestions[index]["answer"]==listQuestions[index]["options"][optionsIndex]){
      listQuestions[index]["answer"] = null;
    }
    listQuestions[index]["options"].removeAt(optionsIndex);
    update(["triviaCreation"]);
  }
}
