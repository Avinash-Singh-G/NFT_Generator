// import 'package:flutter/material.dart';
// import 'package:nft/contract_linking.dart';
// import 'package:provider/provider.dart';
// import 'contract_linking.dart';

// class HelloPage extends StatelessWidget {
//   const HelloPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final contractLink = Provider.of<ContractLinking>(context);
//     final _messageController = TextEditingController();
//     return Scaffold(
//       appBar: AppBar(title: const Text("NFT Generator")),
//       body: Container(
//         padding: EdgeInsets.all(16),
//         child: Center(
//             child: contractLink.isLoading
//                 ? const CircularProgressIndicator()
//                 : SingleChildScrollView(
//                     child: Form(
//                     child: Column(children: <Widget>[
//                       Text(
//                         "Welcome to NFT Generator ${contractLink.deployedName}",
//                         style: const TextStyle(
//                           color: Colors.deepPurple,
//                           fontSize: 20,
//                         ),
//                       ),
//                       TextFormField(
//                         controller: _messageController,
//                         decoration:
//                             const InputDecoration(hintText: "Enter Message"),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           contractLink.setMessage(_messageController.text);
//                           _messageController.clear();
//                         },
//                         child: const Text("Set Message"),
//                       )
//                     ]),
//                   ))),
//       ),
//     );
//   }
// }
