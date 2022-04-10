import 'package:flutter/material.dart';
import 'package:nasa_app/detailStateful.dart';
import 'package:nasa_app/favList.dart';
import 'package:nasa_app/myList.dart';
import 'detail.dart';

void main() => runApp(const BottomNav());

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    const MyList(),
    const DetailStateful(),
    const FavList()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NASA App'),
      ),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.list),
            label: 'Llista',
            backgroundColor: Colors.lightBlue[100],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.document_scanner),
            label: 'Detall',
            backgroundColor: Colors.pink[100],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: 'Favorits',
            backgroundColor: Colors.green[100],
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple[200],
        onTap: _onItemTapped,
      ),
    );
  }
}
