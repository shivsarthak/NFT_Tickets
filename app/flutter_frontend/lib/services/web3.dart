import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_frontend/config.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class Web3 {
  late Client httpClient;
  late Web3Client ethClient;
  late Credentials credentials;

  Web3() {
    httpClient = Client();
    ethClient = Web3Client(RPCServer, httpClient, socketConnector: () {
      return IOWebSocketChannel.connect(WSUrl).cast<String>();
    });
    credentials = EthPrivateKey.fromHex(
      '12742466693134b1057b08b6b09e8a723174226ea75c95400c80d306e2fa5ccb',
    );
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/EventContract.json");
    String contractAddress = ContractAddress;
    DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abi, "EventContract"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> query(String functionName,
      {List args = const []}) async {
    DeployedContract contract = await loadContract();
    ContractFunction function = contract.function(functionName);
    var response = await ethClient.call(
        contract: contract, function: function, params: args);
    return response[0];
  }

  Future<String> createEvent(String uri, String name, int count) async {
    DeployedContract contract = await loadContract();
    final res = await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract,
            function: contract.function("createEvent"),
            parameters: [uri, name, BigInt.from(count)]));
    print(res);
    return res;
  }
}
