import 'package:flutter/material.dart';

class CmTextEditField extends StatelessWidget {
  final TextEditingController textController;

  // final Function? textChange;
  final String? labelText;

  const CmTextEditField({
    Key? key,
    required this.textController,
    // this.textChange,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: textController,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            labelText: labelText, border: const OutlineInputBorder()));
  }
}
