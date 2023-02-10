import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
            child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(color: Colors.indigo))));
  }
}
