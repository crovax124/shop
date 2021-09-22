import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/products_provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

@override
  void initState() {
 // Provider.of<Products>(context).fetchAndSetProducts(); //wont work because .of(context) doesnt work in initstate.
 //  Future.delayed(Duration.zero).then((value) => Provider.of<Products>(context).fetchAndSetProducts(),); //not elegant
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(_isInit) {setState(() {_isLoading = true;

    });

      Provider.of<Products>(context).fetchAndSetProducts().then((_) {setState(() {
        _isLoading = false;
      });});
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einkaufen wie ein König'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(
                () {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                },
              );
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Favoriten anzeigen'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Alles anzeigen'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) => Badge(
              child: ch,
              value: cartData.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.add_shopping_cart_rounded,
              ),
              onPressed: () {Navigator.of(context).pushNamed(CartScreen.routeName);},
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : ProductsGrid(_showOnlyFavorites),
    );
  }
}
