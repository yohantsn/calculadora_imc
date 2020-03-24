import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoContoller = TextEditingController();
  TextEditingController   alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _imc = "Informe seus dados";

  void _resetFields(){
    alturaController.text = "";
    pesoContoller.text = "";
    setState(() {
      _imc = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });

  }

  void _calculate(){
    setState(() {
      double peso = double.parse(pesoContoller.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura*altura);
      print(imc);
      if (imc < 18.6){
        _imc = "Abaixo do peso (${imc.toStringAsPrecision(2)}).";
      }else if((imc >= 18.6) && (imc < 25)){
        _imc = "Peso Normal (${imc.toStringAsPrecision(2)}).";
      }else if((imc >= 25) && (imc < 30)){
       _imc = "Sobrepeso (${imc.toStringAsPrecision(2)}).";
      }else if((imc >= 30) && (imc < 35)){
        _imc = "Obesidade Grau 1 (${imc.toStringAsPrecision(2)}).";
      } else if((imc >= 35) && (imc < 40)){
        _imc = "Obesidade Grau 2 (${imc.toStringAsPrecision(2)}).";
      }else if((imc >= 40)){
        _imc = "Obesidade Mórbida (${imc.toStringAsPrecision(2)}).";
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculadora de IMC',
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Color(0xFFE0F2F1),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                controller: pesoContoller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Peso (Kg)',
                  labelStyle: TextStyle(color: Colors.green, fontSize: 16.0),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 16.0),
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu peso!";
                  }
                },
              ),
              TextFormField(
                controller: alturaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Altura (cm)',
                  labelStyle: TextStyle(color: Colors.green, fontSize: 16.0),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16.0,
                ),
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Container(
                  width: 260,
                  height: 40,
                  child: RaisedButton(
                    onPressed: (){
                      if (_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                '$_imc',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
