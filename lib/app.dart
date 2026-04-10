import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {

    //State manage, controller binding, route management ,,GETX diya sikmu akon
    return GetMaterialApp(

      navigatorKey: navigationKey,

      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),


      theme: ThemeData( //onek somoy app e same design bar bar use kortey hoy .. tai by default design er jonno themedate te kori ..
        inputDecorationTheme:const InputDecorationTheme(
          fillColor: Colors.black12,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),


        textTheme: const TextTheme( //ei ta app er onno jaygay call korley auto style niya nibay.
          titleLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),

        primaryColor: Colors.green,
        primarySwatch: Colors.green,//app er prathomik babey prottekta jinish er bydefault colour ta green kore dibe.

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),

        ),


      ),
      initialBinding: ControllerBinder(),//

    );
  }
}

//jei sokol controller getx e use korbo tader material app a initial binding kore dei tar class


class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
  }

}