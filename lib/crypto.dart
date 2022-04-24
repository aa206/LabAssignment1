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
 String defaultct = "Bitcoin", description = "";
 var name, value, type, unit;
 List<String> crypto = [
   "Bitcoin",
   "US Dollar",
   "United Arab Emirates Dirham",
   "Chinese Yuan",
   "Japanese Yen",
   "South Korean Won",
   "Malaysian Ringgit RM",
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
              onPressed: _loadData, child: const Text("Exchange")),
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
      name = parsedData['rates']['btc']['name'];
      value = parsedData['rates']['btc']['value'];
      type = parsedData['rates']['btc']['type'];
      unit = parsedData['rates']['btc']['unit'];
      setState(() {
        description =
            "Name : $name \nUnit     : $unit \nValue  : $value \nType   : $type";
      });
      progressDialog.dismiss();
     }
  }
}