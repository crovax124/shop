import 'package:flutter/material.dart';


Future<Null> showErrorDialog(BuildContext context)

{
  return showDialog<Null>(
    context: context,
    builder: (context) =>
        AlertDialog(
          title: Text('Ein fehler ist aufgetreten'),
          content: Text('Etwas ist schiefgelaufen :('),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ok'))
          ],
        ),
  );
}