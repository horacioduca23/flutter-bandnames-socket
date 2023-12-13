import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(
      id: '1',
      name: 'Metallica',
      votes: 5,
    ),
    Band(
      id: '2',
      name: 'Linkin Park',
      votes: 44,
    ),
    Band(
      id: '3',
      name: 'The Offsprings',
      votes: 22,
    ),
    Band(
      id: '4',
      name: 'Hermetica',
      votes: 1,
    ),
    Band(
      id: '5',
      name: 'Guasones',
      votes: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          'Name Bands App',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: _addNewBand,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) => _bandTile(
          bands[index],
        ),
      ),
    );
  }

  Widget _bandTile(Band band) => Dismissible(
        key: Key(band.id),
        direction: DismissDirection.startToEnd,
        background: Container(
          padding: const EdgeInsets.only(
            left: 8.0,
          ),
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: ListTile(
              leading: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              title: Text(
                'Delete band',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[200],
            child: Text(
              band.name.substring(
                0,
                2,
              ),
            ),
          ),
          title: Text(band.name),
          trailing: Text(
            '${band.votes}',
            style: const TextStyle(fontSize: 20),
          ),
          onTap: () {
            print(band.name);
          },
        ),
        onDismissed: (direction) {
          print('direction: $direction');
        },
      );

  _addNewBand() {
    final textController = TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            actions: [
              MaterialButton(
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => _addBandToList(textController.text),
                child: Text('Add'),
              ),
            ],
            title: Text('New Band Name:'),
            content: TextField(
              controller: textController,
            ),
          );
        },
      );
    }

    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => _addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
          title: const Text('New Band Name'),
          content: Material(
            child: TextField(
              controller: textController,
            ),
          ),
        );
      },
    );
  }

  void _addBandToList(String bandName) {
    print(bandName);

    if (bandName.length > 1) {
      bands.add(
        Band(
          id: DateTime.now.toString(),
          name: bandName,
          votes: 2,
        ),
      );

      setState(() {});
    }

    Navigator.pop(context);
  }
}
