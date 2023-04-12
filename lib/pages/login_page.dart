import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = "";
  String _password = "";

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      final loginData = {'username': _username, 'password': _password};
      final loginDataJson = json.encode(loginData);
      final response = await fetchLoginData(loginDataJson);
      if (response == 'success') {
        // exibir mensagem de sucesso
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Login bem sucedido'),
            content: Text('Seus dados de login foram verificados com sucesso.'),
          ),
        );
      } else {
        // exibir mensagem de erro
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Erro de login'),
            content:
                Text('Verifique suas credenciais de login e tente novamente.'),
          ),
        );
      }
    }
  }

  Future<String> fetchLoginData(loginDataJson) async {
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: loginDataJson,
    );
    if (response.statusCode == 200) {
      return 'success';
    } else {
      return 'error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Login'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Digite seu login';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Digite sua senha';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Confirmar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
