import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/todus.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../models/database_helper.dart';

class Lists extends StatefulWidget {
  final Function addTx;

  Lists(this.addTx);
  @override
  _ListsState createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  final dbHelper = DatabaseHelper.instance;
  void _addNewTransaction(BuildContextcontext) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          // Where i started the code pasting from
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 0.000,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                        controller: _titleController,
                        autofocus: true,
                        onSubmitted: null,
                        // onChanged: (val) {
                        //   titleInput = val;
                        // },
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Description'),
                        controller: _discriptionController,
                        onSubmitted: null,
                        // onChanged: (val) => amountInput = val,
                      ),
                      Container(
                        height: 70,
                        child: Row(
                          children: [
                            Text(selectedDateAndTime == null
                                    ? 'No Date Choosen'
                                    : DateFormat('MM/dd/yyyy HH:mm')
                                        .format(selectedDateAndTime)
                                // : DateFormat.yMd()
                                //     .format(_selectedDate),
                                ),
                            FlatButton(
                              textColor: Theme.of(context).primaryColor,
                              child: Icon(Icons.calendar_today),
                              // onPressed: () async {
                              //   var value = await _selectedTime();
                              // },
                              onPressed: () => _selectDayAndTimeL(context),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        child: Text('Save Todo'),
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).textTheme.button.color,
                        onPressed: _submitData,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  final _titleController = TextEditingController();
  final _discriptionController = TextEditingController();
  var favorite;
  // DateTime _selectedDate;
  DateTime selectedDateAndTime;
  @override
  void dispose() {
    super.dispose();
    _discriptionController.dispose();
    _titleController.dispose();
  }

  Future _selectDayAndTimeL(BuildContext context) async {
    DateTime _selectedDay = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2030),
        builder: (BuildContext context, Widget child) => child);

    TimeOfDay _selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (_selectedDay != null && _selectedTime != null) {
      //a little check
    }
    setState(() {
      selectedDateAndTime = DateTime(
        _selectedDay.year,
        _selectedDay.month,
        _selectedDay.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );
      // _selectedDate = _selectedDay;
    });
    // print('...');
  }

  List<ItemLists> items = [
    ItemLists(
      title: 'Best Music of the Year',
      description: 'Davido',
      favorite: false,
    ),
    ItemLists(
      title: 'Best Album Cover design',
      description: 'Brighter Press',
      favorite: false,
    ),
    ItemLists(
      title: 'Best Vocalist',
      description: 'Simi-Sola',
      favorite: false,
    ),
    ItemLists(
      title: 'Best Danced',
      description: 'Black Camaru',
      favorite: false,
    ),
    ItemLists(
      title: 'Best Performance',
      description: 'Shofeni-Were',
      favorite: false,
    ),
    ItemLists(
      title: 'Best Act',
      description: 'You Want to See Craze',
      favorite: false,
    ),
  ];

  void _submitData() {
    // if (_amountController.text.isEmpty) {
    //   return;
    // }
    final enteredTitle = _titleController.text;
    final enteredDescription = _discriptionController.text;

    if (enteredTitle.isEmpty) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredDescription,
      selectedDateAndTime,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Dismissible(
                key: ObjectKey(items[index]),
                background: Container(
                  color: Colors.red,
                ),
                child: Card(
                    child: ListTile(
                  leading: new IconButton(
                      icon: Icon(
                        Icons.check,
                        color:
                            items[index].favorite ? Colors.green : Colors.grey,
                      ),
                      tooltip: 'Add to Favorite',
                      onPressed: () {
                        setState(() {
                          items[index].favorite = !items[index].favorite;
                        });
                      }),
                  title: Text('${items[index].title}'),
                  subtitle: Text('${items[index].description}'),
                  trailing: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDayAndTimeL(context),
                  ),
                )),
                onDismissed: (direction) {
                  final String myTitle = items[index].title;
                  // Remove the item from the data source.
                  setState(() {
                    var deletedItems = items.removeAt(index);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$myTitle Deleted'),
                        action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () => setState(
                                  () => items.insert(index, deletedItems),
                                )),
                      ),
                    );
                  });
                });
          },
          itemCount: items.length,
        ),
      ),
    );
    floatingActionButton:
    FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => _addNewTransaction(context),
      backgroundColor: Colors.redAccent,
    );
  }
}
