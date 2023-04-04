import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545";
  final String _privateKey =
      "0x6e3afcfc46b9000b502eca5509b59e63a8f14c8b09bb0ad1db92f69af98f9b12";

  Web3Client? _web3Client;
  bool isLoading = true;

  String? _abiCode;
  EthereumAddress? _contractAddress;

  Credentials? _credentials;

  DeployedContract? _contract;

  // ContractFunction? _message;

  // ContractFunction? _setMessage;

  String? deployedName;

  ContractFunction? _uris;
  ContractFunction? _createTokenURI;
  List<String>? uris;

  ContractLinking() {
    setup();
  }

  setup() async {
    _web3Client = Web3Client(
      _rpcUrl,
      Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
      },
    );
    await getAbiForNFT();
    await getCredentials();
    await getDeployedContractForNFT();
  }

  // Future<void> getAbi() async {
  //   String abiStringfile =
  //       await rootBundle.loadString('build/contracts/HelloWorld.json');
  //   final jsonAbi = jsonDecode(abiStringfile);
  //   //List<dynamic> abList = jsonAbi['abi'];
  //   _abiCode = jsonEncode(jsonAbi['abi']);

  //   _contractAddress =
  //       EthereumAddress.fromHex(jsonAbi['networks']['5777']['address']);
  // }

  Future<void> getAbiForNFT() async {
    String abiStringfile =
        await rootBundle.loadString('build/contracts/CreateNFT.json');
    final jsonAbi = jsonDecode(abiStringfile);
    //List<dynamic> abList = jsonAbi['abi'];
    _abiCode = jsonEncode(jsonAbi['abi']);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi['networks']['5777']['address']);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  // Future<void> getDeployedContract() async {
  //   _contract = DeployedContract(
  //       ContractAbi.fromJson(_abiCode!, "HelloWorld"), _contractAddress!);
  //   _message = _contract!.function("message");
  //   _setMessage = _contract!.function("setMessage");
  //   getMessage();
  // }

  Future<void> getDeployedContractForNFT() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode!, "CreateNFT"), _contractAddress!);
    _uris = _contract!.function("getAllTokenURIs");
    _createTokenURI = _contract!.function("createTokenURI");
    getURIs();
  }

  getURIs() async {
    final _myuris = await _web3Client!
        .call(contract: _contract!, function: _uris!, params: []);
    uris = (_myuris[0] as List<dynamic>).map((e) => e.toString()).toList();
    isLoading = false;
    notifyListeners();
  }

  createTokenURI(String uri) async {
    isLoading = true;
    notifyListeners();
    BigInt cId = await _web3Client!.getChainId();
    await _web3Client!.sendTransaction(
        _credentials!,
        Transaction.callContract(
            contract: _contract!,
            function: _createTokenURI!,
            parameters: [uri]),
        chainId: cId.toInt());
    getURIs();
  }
}
