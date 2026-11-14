//import 'package:benim_uygulamam/user_profile_card.dart';
import 'package:benim_uygulamam/views/login_screen.dart';
import 'package:flutter/material.dart';

//import 'package:benim_uygulamam/detail_screen.dart';

//import 'package:benim_uygulamam/detail_screen.dart';
//import 'package:benim_uygulamam/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //myapp widgetı statleswidgetten türetilmiştir. statleswidget → değişmeyen widget demektir. yani bu widgetın durumu değişmez.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // build arayüzü oluşturur
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Home Screen',
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         centerTitle:
//             true, //true olursa otada klır false olursa eski haline döner
//         backgroundColor: const Color.fromARGB(255, 217, 163, 226),
//         leading: Icon(Icons.arrow_back, color: Colors.transparent), //leading → AppBar'ın sol tarafına bir widget yerleştirir. Burada geri ok simgesi eklenmiştir.
//       ),
//       body: Center(
//         child: Text(
//           //child içine tek bir widget yerleştirmek için kuallnılır
//           "HELLO WORLD",
//           style: TextStyle(
//             fontSize: 24.0,
//             color: const Color.fromARGB(255, 5, 0, 13),
//           ),
//         ),
//       ),
//       // Arayüz değişikliklerinizi buraya yazabilirsiniz
//     );
//   }
// }
