import 'package:app_minha_consulta/consulta/Consultas.dart';
import 'package:app_minha_consulta/consulta/ConsultasForm.dart';
import 'package:app_minha_consulta/consulta/ConsultasList.dart';
import 'package:flutter/material.dart';

class TelaConsulta extends StatefulWidget {
  @override
  _TelaConsultaState createState() => _TelaConsultaState();
}

class _TelaConsultaState extends State<TelaConsulta> {
  @override
  Widget build(BuildContext context) {
    print("## TelaConsulta: inicio");
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Consultas"),
          backgroundColor: Colors.blueAccent,
          bottom: TabBar(tabs: [
            Tab(
              text: "AGENDADAS",
            ),
            Tab(
              text: "HISTORICO",
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            ConsultasList(),
            ConsultasForm(),
          ],
        ),
      ),
    );
  }
}

/**
 * 
 */

/**
 * SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  height: 75,
                  width: 500,
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Sobre a empresa",
                    style: TextStyle(fontSize: 40, color: Colors.deepOrange),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text("escrever texto aqui 123......." +
                      "escrever texto aqui ......." +
                      "escrever texto aqui ......." +
                      "escrever texto aqui ......." +
                      "escrever texto aqui ......." +
                      "escrever texto aqui ......." +
                      "escrever texto aqui ......." +
                      "escrever texto aqui ......." +
                      "escrever texto aqui ......." +
                      "escrever texto aqui ......." +
                      "escrever texto aqui ......." +
                      "escrever texto aqui ......." +
                      "escrever texto aqui ......." +
                      "escrever texto aqui ......." +
                      "escrever texto aqui ......." +
                      "escrever texto aqui ......."),
                )
              ],
            ),
          ),
        ),
 */
