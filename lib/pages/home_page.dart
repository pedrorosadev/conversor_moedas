import 'package:conversor_moedas/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:conversor_moedas/Widgets/TextField.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController realController = TextEditingController();
  TextEditingController dollarController = TextEditingController();
  TextEditingController euroController = TextEditingController();

  double? dollar;
  double? euro;

  void _realChanged(String text) {
    if(text.isEmpty) {
      clearText();
      return;
    }
    double real = double.parse(text);
    dollarController.text = (real / dollar!).toStringAsPrecision(2);
    euroController.text = (real / euro!).toStringAsPrecision(2);
  }

  void _dollarChanged(String text) {
    if(text.isEmpty) {
      clearText();
      return;
    }
    double dollar = double.parse(text);
    realController.text = (this.dollar! * dollar).toStringAsPrecision(2);
    euroController.text = ((this.dollar! * dollar) / euro!).toStringAsPrecision(2);
  }

  void _euroChanged(String text) {
    if(text.isEmpty) {
      clearText();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro!).toStringAsPrecision(2);
    dollarController.text = ((euro * this.euro!) / dollar!).toStringAsPrecision(2);
  }

  void clearText(){
    realController.text = '';
    dollarController.text = '';
    euroController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text(
          '\$ Conversor \$',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: Text(
                    'Carregando dados...',
                    style: TextStyle(color: Colors.amber, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Erro ao Carregar Dados :(',
                      style: TextStyle(color: Colors.amber, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  dollar =
                      snapshot.data!['results']['currencies']['USD']['buy'];
                  euro = snapshot.data!['results']['currencies']['EUR']['buy'];
                 
                  return SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.monetization_on_outlined,
                            size: 130,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          buildTextField(
                            label: 'Real',
                            prefix: 'R\$ ',
                            hint: 'Digite o valor em Real - BRL',
                            controller: realController,
                            checkChanged: _realChanged,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          buildTextField(
                            label: 'Dólar',
                            prefix: 'US\$ ',
                            hint: 'Digite o valor em Dólar Americano - USD',
                            controller: dollarController,
                            checkChanged: _dollarChanged,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          buildTextField(
                            label: 'Euro',
                            prefix: '€ ',
                            hint: 'Digite o valor em Euro - EUR',
                            controller: euroController,
                            checkChanged: _euroChanged,
                          ),
                          
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: FloatingActionButton(
                              onPressed: clearText,
                              backgroundColor: Colors.amber,
                              child: const Icon(
                                Icons.delete,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            }
          }),
    );
  }
}
