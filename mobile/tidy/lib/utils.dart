import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'base_provider.dart';

Directory? docsDir;

Future selectDate(
  BuildContext context,
  BaseProvider inProvider,
  String inDateString,
) async {
  DateTime initialDate = DateTime.now();
  if (inDateString != null) {
    List dateParts = inDateString.split(',');
    initialDate = DateTime(
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
      int.parse(dateParts[2]),
    );
  }
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );
  if (picked != null) {
    inProvider
        .setChosenDate(DateFormat.yMMMMd('en_US').format(picked.toLocal()));
    return '${picked.day},${picked.month},${picked.year}';
  }
}
