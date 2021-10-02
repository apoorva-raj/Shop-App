import 'package:flutter/material.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class EditProductsScreen extends StatefulWidget {
  //const EditProductsScreen({ Key? key }) : super(key: key);

  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final pricePocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final imageURLinput = TextEditingController();
  final imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var editedProduct =
      Product(id: '', title: '', price: 0, description: '', imageURL: '');
  void dispose() {
    super.dispose();
    pricePocusNode.dispose();
    descriptionFocusNode.dispose();
    imageURLinput.dispose();
    imageFocusNode.dispose();
    imageFocusNode.removeListener(updateImageUrl);
  }

  void initState() {
    imageFocusNode.addListener(updateImageUrl);
    super.initState();
  }

  void updateImageUrl() {
    if (!imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  var isLoading = false;
  void saveform() {
    _form.currentState!.save();
    setState(() {
      isLoading = true;
    });
    print(editedProduct.title);
    print(editedProduct.price);
    print(editedProduct.imageURL);
    Provider.of<Products>(context, listen: false)
        .addProducts(editedProduct)
        .catchError((error) {
      return showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text("An Something went wrong"),
                actions: [
                  FlatButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text("Okay"))
                ],
              ));
    }).then((value) {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit the Product"),
        actions: [
          IconButton(onPressed: saveform, icon: Icon(Icons.save)),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(pricePocusNode);
                        },
                        onSaved: (value) {
                          editedProduct = Product(
                              id: '',
                              title: value.toString(),
                              price: editedProduct.price,
                              description: editedProduct.description,
                              imageURL: editedProduct.description);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: pricePocusNode,
                        onSaved: (value) {
                          editedProduct = Product(
                              id: '',
                              title: editedProduct.title,
                              price: double.parse(value.toString()),
                              description: editedProduct.description,
                              imageURL: editedProduct.description);
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(descriptionFocusNode);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Description'),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        onSaved: (value) {
                          editedProduct = Product(
                              id: '',
                              title: editedProduct.title,
                              price: editedProduct.price,
                              description: value.toString(),
                              imageURL: editedProduct.description);
                        },
                        focusNode: descriptionFocusNode,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: imageURLinput.text.isEmpty
                                ? Text("Enter a URL")
                                : FittedBox(
                                    child: Image.network(imageURLinput.text),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Enter image URL'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: imageURLinput,
                              focusNode: imageFocusNode,
                              onSaved: (value) {
                                editedProduct = Product(
                                    id: '',
                                    title: editedProduct.title,
                                    price: editedProduct.price,
                                    description: editedProduct.description,
                                    imageURL: value.toString());
                              },
                              onFieldSubmitted: (_) {
                                saveform();
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
