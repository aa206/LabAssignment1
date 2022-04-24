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
 var data;
 List<String> crypto = [
   "btc",
   "eth",
   "ltc",
 ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bitcoin Exchange App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Text(
            "Cryptocurrencies",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            DropdownButton(
              itemHeight: 60,
              value: defaultct, 
              onChanged: (newValue){
                setState((){
                  defaultct = newValue.toString();
                });
              },
              items: crypto.map((defaultct){
                return DropdownMenuItem(
                  child: Text(
                  defaultct,
                 ),
                  value:defaultct,
              );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _loadData, child: const Text("Load Weather")),
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
      data = parsedData['rates'];
      setState(() {
        description =
            "Name: $data ";
      });
      progressDialog.dismiss();
     }
  }
}