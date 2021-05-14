import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Reais para Dólares'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController myControllerReal = TextEditingController();
  TextEditingController myControllerDolar = TextEditingController();
  num _total = 0;

  @override
  void dispose() {
    myControllerReal.dispose();
    myControllerDolar.dispose();
    super.dispose();
  }

  void _doExchange() {
    num real = num.parse(myControllerReal.text);
    num dolar = num.parse(myControllerDolar.text);


    setState(() {
      _total = real / dolar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Icon(
                  Icons.monetization_on_sharp,
                  size: 64,
                ),
              ),
              TextField(
                controller: myControllerReal,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Quantidade em Reais'),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 15),
                child: TextField(
                  controller: myControllerDolar,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Cotação do Dolar'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: ElevatedButton(
                        onPressed: () {
                          myControllerReal.clear();
                          myControllerDolar.clear();
                          setState(() {
                            _total = 0;
                          });
                        },
                        child: Text('Limpar')),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: ElevatedButton(
                        onPressed: () {
                          _doExchange();
                        }, child: Text('Calcular')),
                  ))
                ],
              ),
              if(myControllerReal.text != '' && myControllerDolar.text != '' && _total > 0)
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    'Com ${myControllerReal.text} reais é possível comprar ${_total.toStringAsFixed(2)} dolares a ${myControllerDolar.text} cada!',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
            ],
          ),
        ),
      )
    );
  }
}
