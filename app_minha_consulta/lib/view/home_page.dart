/*import 'dart:math';

import 'package:app_minha_consulta/view/tela_alergia.dart';
import 'package:app_minha_consulta/view/tela_arquivo.dart';
import 'package:app_minha_consulta/view/tela_cadastro.dart';
import 'package:app_minha_consulta/view/tela_consulta.dart';
import 'package:app_minha_consulta/view/tela_contato.dart';
import 'package:app_minha_consulta/view/tela_horario.dart';
import 'package:app_minha_consulta/view/tela_lembrete.dart';*/
import 'package:app_minha_consulta/nota/Notas.dart';
import 'package:app_minha_consulta/view/tela_cadastro.dart';
import 'package:app_minha_consulta/view/tela_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print("## HomePage: Menu da aplicacao");
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Minha Consulta - home"),
          backgroundColor: Colors.blueAccent,
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "INÍCIO",
            ),
            Tab(
              icon: Icon(Icons.message),
              text: "MENSAGENS",
            ),
            Tab(
              icon: Icon(Icons.account_circle),
              text: "CONTA",
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            TelaMenu(),
            TelaCadastro(),
            Notas(),
          ],
        ),
      ),
    );
  }
}

/**
 * var connection = new PostgreSQLConnection(
    "localhost", 5432, "SistemaAGHU", 
    username: "dart", password: "dart"
    );
    //await connection.open();
 */
