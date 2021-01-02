import 'package:first_test_3/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final mailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('新規登録'),
          backgroundColor: Colors.teal,
        ),
        body: Consumer<SignUpModel>(builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(hintText: 'アドレスを入力'),
                  controller: mailController,
                  onChanged: (text) {
                    model.mail = text;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'パスワードを入力'),
                  obscureText: true,
                  controller: pwController,
                  onChanged: (text) {
                    model.pw = text;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  child: Text(
                    '新規登録',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  color: Colors.teal,
                  textColor: Colors.white,
                  onPressed: () async {
                    try {
                      await model.signUp();
                      _showDialog(context, '登録完了しました');
                    } catch (e) {
                      _showDialog(context, e.toString());
                    }
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Future _showDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
