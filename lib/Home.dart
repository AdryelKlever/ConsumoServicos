import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerCep = TextEditingController();

  String _resultado = "Resultado";

  _recuperarCEP() async {
    String cepDigitado = _controllerCep.text;
    String URL = "https://viacep.com.br/ws/${cepDigitado}/json/";

    http.Response response;
    response = await http.get(URL);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    setState(() {
      _resultado = "${logradouro}, ${complemento}";
    });

    print(
      "Resposta - logradouro: ${logradouro} - complemento: ${complemento}"
    );

    //print("Resposta; " + response.statusCode.toString());
    //print("Resposta; " + response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço WEB"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o cep"
              ),
              style: TextStyle(
                fontSize: 20
              ),
              controller: _controllerCep,
            ),
            RaisedButton(
              child: Text("Clique aqui"),
              onPressed: _recuperarCEP,
            ),
            Text(_resultado)
          ],
        ),
      ),
    );
  }
}
