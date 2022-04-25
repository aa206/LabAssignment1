import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

void main() {
  runApp(const BITCrypto());
}

class BITCrypto extends StatelessWidget {
  const BITCrypto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const CryptoCurrency(),
    );
  }
}
class CryptoCurrency extends StatefulWidget {
  const CryptoCurrency({Key? key}) : super(key: key);

  @override
  State<CryptoCurrency> createState() => _CryptoCurrencyState();
}

class _CryptoCurrencyState extends State<CryptoCurrency> {
 String defaultct = "btc", description = "";
 String name = "", type = "", unit = "";
 double value = 0.0;
 List<String> crypto = [
   "btc",
   "eth",
   "ltc",
   "bch",
   "bnb",
   "eos",
   "xrp",
   "xlm",
   "link",
   "dot",
   "yfi",
   "usd",
   "aed",
   "ars",
   "aud",
   "bdt",
   "bhd",
   "bmd",
   "brl",
   "cad",
   "chf",
   "clp",
   "cny",
   "czk",
   "dkk",
   "eur",
   "gbp",
   "hkd",
   "huf",
   "idr",
   "ils",
   "inr",
   "jpy",
   "krw",
   "kwd",
   "lkr",
   "mmk",
   "mxn",
   "myr",
   "ngn",
   "nok",
   "nzd",
   "php",
   "pkr",
   "pln",
   "rub",
   "sar",
   "sek",
   "sgd",
   "thb",
   "try",
   "twd",
   "uah",
   "vef",
   "vnd",
   "zar",
   "xdr",
   "bits",
   "sats",
 ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Value Exchange App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Text(
            "Cryptocurrency",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
            "Choose a crypto to get its exchange information",
            style: TextStyle(fontSize: 12),
            ),
            DropdownButton(
              itemHeight: 60,
              value: defaultct, 
              onChanged: (newValue){
                setState((){
                  defaultct = newValue.toString();
                });
              },
              elevation: 8,
              style:TextStyle(color:Colors.brown, fontSize: 16),
              icon: Icon(Icons.arrow_drop_down_circle),
              iconEnabledColor: Colors.amberAccent,
              items: crypto.map((defaultct){
                return DropdownMenuItem(
                  child: Text(
                  defaultct,
                 ),
                  value: defaultct,
              );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _loadData, child: const Text("Get Info")),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
            ),          ],
    )));
  }

  Future<void> _loadData() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Progress"), title: const Text("Searching..."));
    progressDialog.show();

    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');
    var response = await http.get(url);
     if (response.statusCode == 200){
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      name = parsedData['rates'][defaultct]['name'];
      value = parsedData['rates'][defaultct]['value'];
      type = parsedData['rates'][defaultct]['type'];
      unit = parsedData['rates'][defaultct]['unit'];
      setState(() {
        description =
            "Name : $name \nUnit     : $unit \nValue  : $value \nType   : $type";
      });
      progressDialog.dismiss();
     }
  }
}