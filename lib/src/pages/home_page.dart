import 'package:flutter/material.dart';
import 'package:quote_acciona/src/pages/partials/MenuLateral.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard')
      ),
      drawer: MenuLateral(),
      body: Container(),
      //floatingActionButton: _newSolicitude(context),
    );
  }

  /*_newSolicitude(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.red,
      onPressed: () => Navigator.pushNamed(context, 'solicitude'),
    );
  }*/
}