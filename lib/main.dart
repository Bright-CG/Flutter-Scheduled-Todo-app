import 'package:flutter/cupertino.dart';

import './widgets/todu_list.dart';
import './models/todus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: ItemList(),
  ));
}

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  // My Initial Code that was working

  // void _presentDatePicker() {
  //   showDatePicker(
  //           context: context,
  //           initialDate: DateTime.now(),
  //           firstDate: DateTime.now(),
  //           lastDate: DateTime(2050))
  //       .then((pickedDate) {
  //     if (pickedDate == null) {
  //       return;
  //     }
  //     setState(() {
  //       _selectedDate = pickedDate;
  //     });
  //   });
  //   print('...');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: IconButton(icon: Icon(Icons.add), onPressed: null),
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
        title: Text('Todu Scheduled Tasks'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(child: Lists()),
    );
  }
}
