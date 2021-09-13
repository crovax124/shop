import 'package:flutter/material.dart';

import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(id: null, title: '', price: 0, imageUrl: '');

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produkt bearbeiten'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            children: [
              SingleChildScrollView(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Produktname',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceFocusNode),
                  validator: (value) {
                    if(value.isEmpty) {return 'Bitte Produktnamen eingeben.';}
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: null,
                        description: _editedProduct.description,
                        imageUrl: _editedProduct.imageUrl,
                        title: value,
                        price: _editedProduct.price);
                  },
                ),
              ),
              SingleChildScrollView(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Preiß',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  validator: (value) {
                    if(value.isEmpty) {return 'Bitte Preiß eingeben.';}
                    return null;
                  },
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode),
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: null,
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      title: _editedProduct.title,
                      price: double.parse(value),
                    );
                  },
                ),
              ),
              SingleChildScrollView(
                child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Beschreibung',
                      border: OutlineInputBorder(),
                    ),
                    focusNode: _descriptionFocusNode,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    validator: (value) {
                      if(value.isEmpty) {return 'Geben sie eine Beschreibung ein.';}
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: null,
                          description: value,
                          imageUrl: _editedProduct.imageUrl,
                          title: _editedProduct.title,
                          price: _editedProduct.price);
                    }),
              ),
              SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text(
                        'URL eingeben',
                        textAlign: TextAlign.center,
                      )
                          : FittedBox(
                        child: Image.network(_imageUrlController.text),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                          decoration: InputDecoration(labelText: 'Bild WebUrl'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          focusNode: _imageUrlFocusNode,
                          validator: (value) {
                            if(value.isEmpty) {return 'Bitte Url eingeben.';}
                            return null;
                          },
                          onFieldSubmitted: (_) => _saveForm(),
                          onEditingComplete: () {
                            setState(() {});
                          },
                          onSaved: (value) {
                            _editedProduct = Product(
                                id: null,
                                description: _editedProduct.description,
                                imageUrl: value,
                                title: _editedProduct.title,
                                price: _editedProduct.price);
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
