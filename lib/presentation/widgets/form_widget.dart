
import 'dart:html';

import 'package:cleanutter/domain/model/club.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormWidget extends StatefulWidget {
  final bool isForUpdate;
  final Club? club;

  const FormWidget({Key? key, this.club, required this.isForUpdate})
      : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _clubName = TextEditingController();
  TextEditingController _shortName = TextEditingController();
  TextEditingController _position = TextEditingController();
  TextEditingController _league = TextEditingController();

  @override
  void initState() {
    if (widget.isForUpdate) {
      _clubName.text = widget.club!.clubName;
      _shortName.text = widget.club!.shortName;
      _position.text = widget.club!.position.toString();
      _league.text = widget.club!.league;
    }
    super.initState();
  }

  void validateInput() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final club = Club(
        id: widget.isForUpdate ? widget.club!.id : 0,

      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                  controller: _clubName,
                  validator: (val) =>
                      val!.isEmpty ? "Club name can't be empty" : null,
                  decoration: InputDecoration(hintText: "Club name"))),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                  controller: _shortName,
                  validator: (val) =>
                      val!.isEmpty ? "Club short name can't be empty" : null,
                  decoration: InputDecoration(hintText: "Short name"),
                  maxLines: 6,
                  minLines: 1)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                  controller: _position,
                  validator: (val) =>
                  val!.isEmpty ? "Club position can't be empty" : null,
                  decoration: InputDecoration(hintText: "Position"),
                  maxLines: 6,
                  minLines: 1)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                  controller: _league,
                  validator: (val) =>
                  val!.isEmpty ? "Club league can't be empty" : null,
                  decoration: InputDecoration(hintText: "League"),
                  maxLines: 6,
                  minLines: 1)),
          ElevatedButton.icon(
            onPressed: validateInput,
            icon: widget.isForUpdate ? Icon(Icons.edit) : Icon(Icons.add),
            label: Text(widget.isForUpdate ? "Update" : "Add"),
          )
        ],
      ),
    );
  }
}
