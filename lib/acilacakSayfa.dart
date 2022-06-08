// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_with_post_method/main.dart';

class AcilacakSayfa extends StatefulWidget {
  const AcilacakSayfa({Key? key}) : super(key: key);

  @override
  State<AcilacakSayfa> createState() => _AcilacakSayfaState();
}

class _AcilacakSayfaState extends State<AcilacakSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hoşgeldin!"),
          SizedBox(
            height: 50,
          ),
          OutlinedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              icon: Icon(Icons.exit_to_app),
              label: Text("Çıkış Yap"))
        ],
      ))),
    );
  }
}
