import 'package:app_minha_consulta/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Brightness, TextInputType;
import 'package:app_minha_consulta/postgresDb.dart';
import 'package:postgres/postgres.dart';

class TelaLogin extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<TelaLogin> {
  final TextEditingController _prontuarioController = TextEditingController();
  final TextEditingController _cpfPacienteController = TextEditingController();

  @override
  Future<Widget> build(BuildContext context) async {
    print("## TelaLogin: Iniciando a aplicacao");
    var connection = new PostgreSQLConnection();
    await   connection.open();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: Colors.blue,
          brightness: Brightness.light,
          title: Text(
            'MINHA CONSULTA - login',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            textWidthBasis: TextWidthBasis.longestLine,
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              const SizedBox(height: 10.0),
              Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 500,
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
              const SizedBox(height: 20.0),
              PrimaryColorOverride(
                color: Colors.blue,
                child: Container(
                  child: TextField(
                    controller: _prontuarioController,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Prontuario',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              PrimaryColorOverride(
                color: Colors.blue,
                child: Container(
                  child: TextField(
                    controller: _cpfPacienteController,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CPF do paciente',
                    ),
                  ),
                ),
              ),
              Wrap(
                children: <Widget>[
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        child: const Text('ENTRAR'),
                        elevation: 8.0,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                      ),
                      const SizedBox(width: 40.0),
                      FlatButton(
                        child: const Text('CANCELAR'),
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TelaLogin()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(primaryColor: color),
    );
  }
}

/**
 * SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height:150,
            width: 350,
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20,20,20,20),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail'
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20,5,20,20),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha'
              ),
            ),
          ),
          RaisedButton(
            color: Colors.blueAccent,
            textColor: Colors.white,
            child: Text("ENTRAR"),
            onPressed: (){},
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Center(
              child: Text(
                  "Recuperar minha senha",
              style: TextStyle(
                color: Colors.blueAccent
              ),),
            )
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
              child: Center(
                child: Text(
                    "Cadastre-se",
                  style: TextStyle(
                    color: Colors.blueAccent
                  ),),
              )
          )
        ],
      ),
    );
 */
