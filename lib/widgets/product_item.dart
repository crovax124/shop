import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  //
  // // ignore: use_key_in_widget_constructors
  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    final snackBar = SnackBar(
      content: Row(
        children: [
          Text(
            'Zur Bestellung hinzugefügt.',
            textAlign: TextAlign.center,
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.undo_rounded),
            onPressed: () {
              cart.removeSingleItem(product.id);
            },
            color: Theme.of(context).errorColor,
          )
        ],
      ),
      duration: Duration(seconds: 2),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.white30,
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () => {
                product.toggleFavoriteStatus(authData.token, authData.userId),
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.add_shopping_cart_rounded,
            ),
            onPressed: () => {
              cart.addItem(
                product.id,
                product.price,
                product.title,
              ),
              ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              ScaffoldMessenger.of(context).showSnackBar(snackBar)
            },
            color: Colors.greenAccent,
          ),
        ),
      ),
    );
  }
}
