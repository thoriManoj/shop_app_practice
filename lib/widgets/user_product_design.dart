import 'package:flutter/material.dart';
import 'package:shop_app_practice/screens/edit_product_screen.dart';

class UserProductDesign extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductDesign(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(title),
        trailing: Container(
          width: 100.0,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: id);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
