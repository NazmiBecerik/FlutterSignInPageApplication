// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_import
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login_with_post_method/acilacakSayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.email)),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordController,
              // Parolanın gösterilmemesini sağlar . default olarak truedur. (obscure)
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Şifre",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.password)),
            ),
            SizedBox(
              height: 30,
            ),
            OutlinedButton.icon(
                onPressed: () {
                  login();
                },
                icon: Icon(
                  Icons.login,
                  size: 15,
                ),
                label: Text("Giriş Yap"))
          ],
        ))),
      ),
    );
  }

  Future<void> login() async {
    String apiAddress = "http://192.168.1.5:44347/loginService.asmx?wsdl";
    String _email = _emailController.text;
    String _password = _passwordController.text;
    print("Email: " + _email + "password: " + _password);
    Response response = await Dio().post(
      apiAddress,
      data:
          """<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                                  <soapenv:Header/>
                                  <soapenv:Body>
                                      <tem:login>
                                        <tem:email>$_email</tem:email>
                                        <tem:password>$_password</tem:password>
                                      </tem:login>
                                  </soapenv:Body>
                                </soapenv:Envelope>""",
      options: Options(contentType: "text/xml; charset=utf-8"),
    );
    //print(response.data);
    if (_passwordController.text.isNotEmpty &&
        _emailController.text.isNotEmpty) {
      print(response.data);
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AcilacakSayfa()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Doğrulama başarısız")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Boş Bırakılamaz ! ")));
    }

    print("Email: " + _email + "password: " + _password);
  }
}
