import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:triviait/controllers/triviaController.dart';
import 'package:triviait/controllers/triviaCreationController.dart';
import 'package:triviait/screens/TriviaCreateScreen.dart';
import 'package:triviait/screens/TriviaListScreen.dart';
import 'package:triviait/screens/TriviaQuestionsAnswerScreen.dart';
import 'package:triviait/screens/TriviaQuestionsScreen.dart';

import 'env/env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: Env.apiKey, authDomain: Env.authDomain, storageBucket: Env.storageBucket,
      appId: Env.appId, messagingSenderId: Env.messagingSenderId, projectId: Env.projectId,measurementId: Env.measurementId));
  configLoading();

  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 100)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..boxShadow = <BoxShadow>[]
    ..radius = 10.0
    ..progressColor = Colors.blue
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.blue
    ..textColor = Colors.black
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..successWidget = const SizedBox.shrink()
    ..errorWidget = const SizedBox.shrink()
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TriviaController(),permanent: true);
    Get.lazyPut(() => TriviaCreationController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: ()=>const TriviaListScreen()),
        GetPage(name: "/question", page: ()=>const TriviaQuestionsScreen()),
        GetPage(name: "/question/answers", page: ()=>const TriviaQuestionsAnswerScreen()),
        GetPage(name: "/trivia/creation", page: ()=>const TriviaCreateScreen()),


      ],
      builder: EasyLoading.init(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true, checkboxTheme: CheckboxThemeData(
           fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
           if (states.contains(MaterialState.disabled)) { return null; }
           if (states.contains(MaterialState.selected)) { return Colors.green; }
           return null;
           }),
           ), radioTheme: RadioThemeData(
           fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
           if (states.contains(MaterialState.disabled)) { return null; }
           if (states.contains(MaterialState.selected)) { return Colors.green; }
           return null;
           }),
           ), switchTheme: SwitchThemeData(
           thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
           if (states.contains(MaterialState.disabled)) { return null; }
           if (states.contains(MaterialState.selected)) { return Colors.green; }
           return null;
           }),
           trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
           if (states.contains(MaterialState.disabled)) { return null; }
           if (states.contains(MaterialState.selected)) { return Colors.green; }
           return null;
           }),
           ),
      ),
    );
  }
}