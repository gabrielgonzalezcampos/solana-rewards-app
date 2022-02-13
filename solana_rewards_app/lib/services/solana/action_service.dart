

import 'dart:typed_data';

import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:borsh_annotation/src/struct_annotation.dart';
import 'package:solana/solana.dart';
import 'package:solana_rewards_app/config/config.dart';
import 'package:solana_rewards_app/models/issue.dart';
import 'package:solana_rewards_app/models/issue_schema.dart';
import 'package:solana_rewards_app/services/mappers/issues_mapper.dart';
import 'package:tuple/tuple.dart';

class ActionService {

  static const String programId = ProgramId;
  static const String _saveIssueId = saveIssueId;
  static const String validatorAccount = validatorAccountAddress;

  static Future<Tuple3<List<Issue>, int, int>> getAccountMessageHistory(
      SolanaClient connection,
      String pubKeyStr
      ) async {
    print("Getting issues");
    Account? sentAccount = await connection.rpcClient.getAccountInfo(pubKeyStr, encoding: Encoding.jsonParsed);

    print("Response get");
    if (sentAccount == null) {
      print("empty");
      throw Exception('Account $pubKeyStr does not exist');
    }
    //deserialize data
    BinaryAccountData dataBuffer = sentAccount.data as BinaryAccountData;

    ByteData _view = ByteData.sublistView(Uint8List.fromList(dataBuffer.data));
    List<IssueSchema> receivedIssuesList = _view.issuesListFromBorsh(dataBuffer.data);
    List<Issue> issuesList = [];
    String dummyTitle = buildDummyString();
    print(dummyTitle);
    String initialTitle = "";
    int reward = 0;
    for(IssueSchema element in receivedIssuesList){
      if (element.title == dummyTitle ||element.title ==initialTitle) {
        return Tuple3(issuesList, sentAccount.lamports, reward);
      }
      print(element.title);
      initialTitle = element.title;
      issuesList.add(Issue.fromSchema(element));
      reward += element.reward;
    }
    return Tuple3(issuesList, sentAccount.lamports, reward);//chat.chatMessageList();
  }

  static Future<String> saveIssue(
      SolanaClient connection,
      Wallet wallet,
      String destPubkeyStr,
      Issue issue
      ) async {
    print("start sendMessage");
    Instruction messageInstruction = Instruction(
        programId: programId,
        accounts: [
          AccountMeta.writeable(pubKey: destPubkeyStr, isSigner: false),
          AccountMeta.writeable(pubKey: validatorAccount, isSigner: false),
        ],
        data: buildSaveRequest(IssueSchema.fromIssue(issue))
    );
    print("message");
    Message messageTransaction = Message(instructions: [messageInstruction]);
    print("done");
    String signature = await connection.rpcClient.signAndSendTransaction(messageTransaction, [wallet]);
    print("signed");
    await connection.waitForSignatureStatus(signature, status: ConfirmationStatus.finalized);
    print("finalized");
    TransactionDetails? result = await connection.rpcClient.getTransaction(signature, commitment: Commitment.finalized);
    print("result");
    if (result == null) {
      return "OK: Message saved Successfully";
    }
    print("end sendMessage");
    print(result.toString());
    return result.toString();
  }


}