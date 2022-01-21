import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solana_rewards_app/models/issue_type.dart';
import 'package:solana_rewards_app/widgets/attachments/attachments.dart';
import 'package:solana_rewards_app/widgets/issue_element/issue_element_model.dart';

class CreateIssue extends StatefulWidget {
  const CreateIssue({Key? key}) : super(key: key);

  @override
  _CreateIssueState createState() => _CreateIssueState();
}

class _CreateIssueState extends State<CreateIssue> {

  List<ImageProvider> images = [];

  final ImagePicker _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  late IssueElementModel issue;

  @override
  Widget build(BuildContext context) {
    issue = IssueElementModel.empty();

    InputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: Theme
            .of(context)
            .primaryColor));

    IssueType type = IssueType.thrash;

    double interSpace = 10.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("New issue"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Padding(
                padding: EdgeInsets.only(top: interSpace),
                child: Column(
                  children: [
                  Form(
                  key: _formKey,
                  child: Column(
                      children: [
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
                    cursorColor: Theme
                        .of(context)
                        .primaryColor,
                    decoration: _buildDecoration('Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        value = "";
                      }
                      return null;
                    },
                    onSaved: (value) => issue.name = value!,
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
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((
                              Set<MaterialState> states) {
                            return Theme
                                .of(context)
                                .primaryColor
                                .withOpacity(0.5);
                          })
                      ),
                      onPressed: _chooseImage,
                      child: const Text("Add photo")),
                ),
                Container(
                  width: 100,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((
                              Set<MaterialState> states) {
                            return Theme
                                .of(context)
                                .primaryColor
                                .withOpacity(0.9);
                          })
                      ),
                      onPressed: () {},
                      child: const Text("Submit")),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: interSpace),
            child: Attachments(items: images),
          )
          ],
        ),
      ),
    ),)
    ,
    )
    ,
    );
  }

  Color _getColor(Set<MaterialState> states) {
    return Theme
        .of(context)
        .primaryColor
        .withOpacity(0.9);
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
            borderSide: BorderSide(color: Theme
                .of(context)
                .primaryColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(color: Theme
                .of(context)
                .primaryColor)),
        label: Text(label),
        floatingLabelStyle: TextStyle(color: Theme
            .of(context)
            .hintColor));
  }

  void _chooseImage() async {
    ImageProvider imageProvider = FileImage(File((await _picker.pickImage(source: ImageSource.gallery))!.path));
    images.add(imageProvider);
    setState(() {});
  }
}
