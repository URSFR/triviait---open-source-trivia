import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:xid/xid.dart';

class FirestoreFunctions{

  Future<List<Map<String, dynamic>>> queryQuestions({required String id}) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('trivias')
        .doc(id)
        .collection("questions")
        .get();
    List<Map<String, dynamic>> result = [];
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      Map<String, dynamic> data = querySnapshot.docs[i].data();
      result.add(data);
    }
    return result;
     }


     createTrivia({required String author, required String name, required List<Map> questionsList}){
      try{
        var triviaID = Xid();
        FirebaseFirestore.instance.collection("trivias").doc(triviaID.toString()).set({
          "createdAt": DateTime.now().millisecondsSinceEpoch.toString(),
          "createdBy": author,
          "name": name
        }).whenComplete(() {
          uploadQuestions(documentList: questionsList, id: triviaID.toString()).whenComplete(() {
            EasyLoading.showSuccess("SUCCESS").whenComplete(() {
              Get.toNamed("/");
            });
          });
        });
      }catch(e){
        return false;
      }

  }

  Future<void> uploadQuestions(
      {required List<Map> documentList, required String id}) async {
    for (int i = 0; i < documentList.length; i++) {
      Map document = documentList[i];

      // Puedes agregar más lógica para manejar etiquetas u otros datos según tus necesidades

      // Convertir el contenido del documento a bytes (puedes ajustar esto según el tipo de contenido que estés manejando)

      try {
        var questionID = Xid();
        await FirebaseFirestore.instance
            .collection('trivias').doc(id).collection("questions").doc(questionID.toString()).set({
          "question":document["question"],
          "answer":document["answer"],
          "options":document["options"],
          "reason":document["reason"],
        });

      } on FirebaseException catch (e) {
        EasyLoading.showError("ERROR");
        print("BIG PROBLEM ${e}");
      }
    }
  }
}



