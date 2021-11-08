import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  String? errorText;
  String amount = '';

  bool isNumeric(String string) {
    final number = num.tryParse(string);
    if (number == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
            child: Text("Currency Converter"),
        alignment: Alignment.center,),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          children: <Widget>[
            Align(
              child: Image.asset('assets/images/currency_converter_logo.png',
              scale: 3),
              alignment: Alignment.center,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(decimal:true),
                decoration: InputDecoration(
                  hintText: 'Enter amount in EUR',
                  errorText: errorText,
                  suffix: IconButton(
                      onPressed: () => controller.clear(),
                      icon: const Icon(Icons.close)
                  )
              )
              ),
            ),
            OutlinedButton(
              child: const Text('Convert', textScaleFactor: 1.5),
              onPressed: () {
                if (!isNumeric(controller.text)) {
                  setState (() {
                    errorText = 'Enter a valid amount';
                    amount = '';
                  });
                } else {
                  setState(() {
                    errorText = null;
                    amount = (double.parse(controller.text) * 4.95).toStringAsFixed(2) + ' RON';
                  });
                }
              },
            ),
            Text(amount, textScaleFactor: 1.5)
          ],
        )
      )
    );
  }
}

