import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _price = "0";
  String _preco = "0";

  void _recuperarPreco() async {

    var url = Uri.parse("https://blockchain.info/ticker");
    http.Response response = await http.get(url);

    Map<String, dynamic> retorno = json.decode( response.body );
    setState(() {
      _price = retorno["USD"]["buy"].toString();
      _preco = retorno["BRL"]["buy"].toString();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Image.asset("images/bitcoin.png"),
                Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 50),
                  child: Text(
                    "U\$D: $_price\n" +
                    "\nR\$: $_preco",
                    style: const TextStyle(
                      fontSize: 27
                    ),
                    ),
                  ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                ),
                  onPressed: _recuperarPreco,
                  child: const Text(
                    "Atualizar",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
               )
            ],
          ),
        ),
      ),
    );
  }
}
