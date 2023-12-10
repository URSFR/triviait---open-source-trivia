
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:triviait/firebase/firebaseQuery.dart';

class TriviaController extends GetxController{
  static TriviaController get instance => Get.find();

  List<Map> questionAnswerList = [];
  List choosedOption = [];


  getQuestions({required String id}) async {
    if(questionAnswerList.isEmpty){
      questionAnswerList = await FirestoreFunctions().queryQuestions(id: Get.arguments[0]["id"]);
      questionAnswerList.shuffle();
      for (int i = 0; i < questionAnswerList.length; i++) {
        choosedOption.add("");
      }
        update(["triviaDetailsScreen"]);
      // print(cuteandfunny.first.options);
    }
  }

  checkAnswers({required String id,required String name}){
    EasyLoading.show(status: "Analizando respuestas");

    bool todosLosElementosSonValidos = choosedOption.every((elemento) {
      return elemento != null && elemento.isNotEmpty;
    });
    print(todosLosElementosSonValidos);

    if (todosLosElementosSonValidos) {
      Future.delayed(const Duration(seconds: 2), () {

// Here you can write your code
        EasyLoading.showSuccess("");
        print("Todos los elementos son válidos.");
        Get.toNamed("/question/answers",arguments: [
          {"id": id,
          "name":name}
        ]);

      });


    } else {
      Get.snackbar("ERROR","Check all questions");
      EasyLoading.showError("");

    }
  }

  leaveTrivia(){
    questionAnswerList.clear();
    choosedOption.clear();
    Get.offAllNamed("/");
  }

}
