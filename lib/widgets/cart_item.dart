import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).errorColor,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          right: 20,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Bist du sicher ?'),
            content: Text('Willst du den Artikel aus dem Cart entfernen ?'),
            actions: [
              TextButton.icon(
                icon: Icon(Icons.undo),
                label: Text('Nein'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton.icon(
                icon: Icon(Icons.clear),
                label: Text('Ja löschen'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: FittedBox(
                  child: Text(
                    '${price}' + ' €',
                  ),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text(
              'Summe: ${(price * quantity)}' + ' €',
            ),
            trailing: Text(
              '$quantity x',
            ),
          ),
        ),
      ),
    );
  }
}
