import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'package:solana_rewards_app/helpers/common.dart';
import 'package:solana_rewards_app/models/issue_state.dart';
import 'package:solana_rewards_app/models/issue_type.dart';
import 'package:solana_rewards_app/services/solana/action_service.dart';
import 'package:solana_rewards_app/store/actions/issue_action.dart';
import 'package:solana_rewards_app/store/states/app_state.dart';
import 'package:solana_rewards_app/store/states/issues_state.dart';
import 'package:solana_rewards_app/store/states/wallet_state.dart';
import 'package:solana_rewards_app/widgets/attachments/attachments.dart';
import 'package:solana_rewards_app/widgets/issue_element/issue_element_model.dart';

class CreateIssue extends StatefulWidget {
  const CreateIssue({Key? key}) : super(key: key);

  @override
  _CreateIssueState createState() => _CreateIssueState();
}

class _CreateIssueState extends State<CreateIssue> {
  List<ImageProvider> images = [];
  List<File> files = [];

  final ImagePicker _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  late IssueElementModel issue;

  late WalletState walletState;
  late Store _store;
  bool loading = true;
  // late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    // _context = context;
    issue = IssueElementModel.empty();

    InputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: Theme.of(context).primaryColor));

    IssueType type = IssueType.thrash;

    double interSpace = 10.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("New issue"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StoreConnector<AppState, IssuesState>(
          distinct: true,
          converter: (store) {
            walletState = store.state.walletState;
            _store = store;
            return store.state.issuesState;
          },
          builder: (context, vm) {
            print("Builder ${vm.loading }, $loading, ${vm.error}");
            if (!vm.loading && !loading){
              if (!vm.error){
                WidgetsBinding.instance!.addPostFrameCallback((_) => _showToast(context, true));
              } else {
                WidgetsBinding.instance!.addPostFrameCallback((_) => _showToast(context, false));
              }
            }
            return Center(
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Padding(
                  padding: EdgeInsets.only(top: interSpace),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(children: [
                          TextFormField(
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: _buildDecoration('Title'),
                            validator: (value) {
                              _nonNullValidator(value);
                            },
                            onSaved: (value) => issue.name = value!,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: interSpace),
                            child: TextFormField(
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: _buildDecoration('Description'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  value = "";
                                }
                                return null;
                              },
                              onSaved: (value) => issue.description = value!,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: interSpace),
                            child: DropdownButtonFormField<IssueType>(
                                decoration: _buildDecoration('Type'),
                                items: IssueType.values
                                    .map<DropdownMenuItem<IssueType>>(
                                        (IssueType value) {
                                  return DropdownMenuItem<IssueType>(
                                    value: value,
                                    child: Text(value.toText()),
                                  );
                                }).toList(),
                                onChanged: (value) => type = value!,
                                onSaved: (value) => issue.type = value!),
                          )
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: interSpace),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100,
                              child: ElevatedButton(
                                  style: ButtonStyle(backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (Set<MaterialState> states) {
                                    return Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5);
                                  })),
                                  onPressed: _chooseImage,
                                  child: const Text("Add photo")),
                            ),
                            Container(
                              width: 100,
                              child: ElevatedButton(
                                  style: ButtonStyle(backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (Set<MaterialState> states) {
                                    return Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.9);
                                  })),
                                  onPressed: () => {_submitIssue()},
                                  child: const Text("Submit")),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: interSpace),
                        child: Attachments(items: images),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String? _nonNullValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Title';
    }
    return null;
  }

  InputDecoration _buildDecoration(String label) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        label: Text(label),
        floatingLabelStyle: TextStyle(color: Theme.of(context).hintColor));
  }

  void _chooseImage() async {
    File file = File((await _picker.pickImage(source: ImageSource.gallery, imageQuality: 25))!.path);
    print("Length");
    print(base64Encode(file.readAsBytesSync()).length);
    files.add(file);
    ImageProvider imageProvider = FileImage(file);
    images.add(imageProvider);
    setState(() {});
  }

  _submitIssue() {
    loading = false;
    _formKey.currentState?.save();
    issue.state = IssueState.uploaded;
    issue.attachments = _imagesToString(files);
    _store.dispatch(SubmitIssueAction(issue: issue.toIssue()));
    showToast(context, "Saving Issue...");
  }

  _showToast(BuildContext c, bool correctlySaved) {
    if (correctlySaved){
      showToast(context, "Issue Saved");
      Navigator.pop(context);
    } else {
      showToast(context, "Error Saving Issue");
    }
  }

  List<String> _imagesToString(List<File> files) {
    List<String> list = [];
    for(File file in files){
      list.add(base64Encode(file.readAsBytesSync()));
      print("Length");
      print(base64Encode(file.readAsBytesSync()).length);
    }
    return list;
  }

}
