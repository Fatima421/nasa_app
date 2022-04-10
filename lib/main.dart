import 'package:flutter/material.dart';
import 'package:nasa_app/apiService/apiService.dart';
import 'package:nasa_app/detailStateful.dart';
import 'package:http/http.dart' as http;

import 'detail.dart';
import 'bottomNav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var _user = TextEditingController();
    _user.text="fatima.sahar";
    var _pass = TextEditingController();
    _pass.text="123456";
    final ApiService apiService = new ApiService();
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: 80, top: 10, bottom: 5, right: 100),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Colors.cyan, Colors.pink],
                ),
              ),
              child: Image.asset("assets/images/planet.png"),
              height: 250,
            ),
            Center(
              child: Card(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Usuari"),
                        controller: _user,

                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Contrasenya"),
                        obscureText: true,
                        controller: _pass,
                      ),
                      const SizedBox(height: 40),
                      Builder(
                        builder: (context) => ElevatedButton(
                          onPressed: () async {
                            bool loginSuccess = await apiService.login(_user.text, _pass.text);
                            if (loginSuccess) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomNav()));
                            }
                          },
                          child: const Text('Login'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
