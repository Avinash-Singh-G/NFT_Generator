import 'package:flutter/material.dart';
import 'package:nft/nft_page.dart';
import 'package:provider/provider.dart';
import 'contract_linking.dart';
import 'hello_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContractLinking>(
      create: (context) => ContractLinking(),
      child: MaterialApp(
        title: 'NFT',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NFTPage(),
      ),
    );
  }
}
