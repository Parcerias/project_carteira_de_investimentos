import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  var titleController = TextEditingController();
  var valueController = TextEditingController();
  var brokerController = TextEditingController();
  final Function onSubmitted;
  final String labelTitulo;
  final String labelValue;
  final String labelBroker;

  AdaptativeTextField(
      {this.titleController,
      this.onSubmitted,
      this.labelTitulo,
      this.labelValue,
      this.brokerController,
      this.valueController,
      this.labelBroker});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Column(
            children: <Widget>[
              CupertinoTextField(
                controller: titleController,
                onSubmitted: onSubmitted,
                placeholder: labelTitulo,
              ),
              CupertinoTextField(
                controller: valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: onSubmitted,
                placeholder: labelValue,
              ),
              CupertinoTextField(
                controller: brokerController,
                onSubmitted: onSubmitted,
                placeholder: labelBroker,
              ),
            ],
          )
        : Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                onSubmitted: onSubmitted,
                decoration: InputDecoration(
                  labelText: labelTitulo,
                ),
              ),
              TextField(
                controller: valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: onSubmitted,
                decoration: InputDecoration(
                  labelText: labelValue,
                ),
              ),
              TextField(
                controller: brokerController,
                onSubmitted: onSubmitted,
                decoration: InputDecoration(
                  labelText: labelBroker,
                ),
              ),
            ],
          );
  }
}
