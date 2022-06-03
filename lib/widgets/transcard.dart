import 'package:flutter/material.dart';

Widget cardd({title, subtitle, Widget? leading}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: leading,
    ),
  );
}
