import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ProductListPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController ctrUsername = TextEditingController();
  TextEditingController ctrPassword = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initialObject();
  }

  void initialObject() async {
    prefs = await SharedPreferences.getInstance();
    String session = prefs.getString("username") ?? "";
    print("login page: " + session);
    if (session.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductListPage()),
      );
    }
  }

  Widget myTextField(
      String label, bool isObsecure, TextEditingController myController) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        controller: myController,
        obscureText: isObsecure,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              myTextField('username', false, ctrUsername),
              myTextField('password', true, ctrPassword),
              ElevatedButton(
                  onPressed: () async {
                    await prefs.setString(
                        'username', ctrUsername.text.toString());
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductListPage()),
                    );
                  },
                  child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
