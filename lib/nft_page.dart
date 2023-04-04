import 'package:flutter/material.dart';
import 'package:nft/contract_linking.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'contract_linking.dart';

class NFTPage extends StatelessWidget {
  const NFTPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contractLink = Provider.of<ContractLinking>(context);
    final _messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("NFT Generator")),
      body: Container(
        padding: EdgeInsets.all(16),
        child: contractLink.isLoading
            ? const CircularProgressIndicator().centered()
            : SingleChildScrollView(
                child: Form(
                child: Column(children: <Widget>[
                  const Text(
                    "Welcome to NFT Generator",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  20.heightBox,
                  TextFormField(
                    controller: _messageController,
                    decoration:
                        const InputDecoration(hintText: "Enter URI/Text"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      contractLink.createTokenURI(_messageController.text);
                      _messageController.clear();
                    },
                    child: const Text("Create NFT"),
                  ),
                  40.heightBox,
                  "All NFTs".text.bold.xl2.sky600.make(),
                  20.heightBox,
                  ...contractLink.uris!
                      .map((uri) => AStack(children: [
                            uri.text.semiBold.white
                                .make()
                                .box
                                .p32
                                .rounded
                                .outerShadow
                                .color(Vx.randomOpaqueColor)
                                .make()
                                .p8(),
                          ]))
                      .toList(),
                ]),
              )),
      ),
    );
  }
}
