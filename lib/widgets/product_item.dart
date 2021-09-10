// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

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

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id,
            );

          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
            backgroundColor: Colors.white30,
          leading: Consumer<Product>(builder: (ctx, product, child) =>
          IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(product.isFavorite ?
                Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () => {
                product.toggleFavoriteStatus()
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
              cart.addItem(product.id, product.price, product.title,)
            },
            color: Colors.greenAccent,
          ),
        ),
      ),
    );
  }
}
