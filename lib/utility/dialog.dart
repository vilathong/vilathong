import 'package:final_project/utility/my_style.dart';
import 'package:flutter/material.dart';

Future<Null> normalDialog(BuildContext context, String string) async {
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            title: ListTile(
              leading: Icon(
                Icons.add_alert,
                size: 30.0,
                color: Mystyle().primaryColor,
              ),
              title: Text('Error'),
              subtitle: Text(string),
            ),
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text('Close'))
            ],
          ));
}
