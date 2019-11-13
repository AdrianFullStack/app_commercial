import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotizaciones')
      ),
      body: Container(),
      floatingActionButton: _newSolicitude(context),
    );
  }

  _newSolicitude(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.red,
      onPressed: () => Navigator.pushNamed(context, 'solicitude'),
    );
  }
}