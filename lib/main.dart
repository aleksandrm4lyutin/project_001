import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_001/pages/home_page.dart';

void main() {
  ///
  WidgetsFlutterBinding.ensureInitialized();

  runApp(InitApp());
}


class InitApp extends StatelessWidget {
  InitApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //Check for errors
        if (snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('ERROR WHILE INITIALIZING'),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        }

        ///Show something while waiting for initialization to complete
        return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFD6D6D6)),
          ),
          home: const Scaffold(
            backgroundColor: Color(0xFF212121),
            body: Center(
              //TODO
              // child: Image(
              //   image: AssetImage('assets/images/icon.png'),
              //   height: 100.0,
              //   width: 100.0,
              // ),
            ),
          ),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}



