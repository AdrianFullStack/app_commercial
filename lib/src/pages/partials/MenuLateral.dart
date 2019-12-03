import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Rogelio Adrián Suclupe Tello'),
            accountEmail: Text('rsuclupe@acciona.com'),
            currentAccountPicture: new CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/freight-forwarder.jpg'),
                fit: BoxFit.cover
              )
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.chartArea),
            title: Text("Dashboard"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('home');
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.fileInvoiceDollar),
            title: Text("Cotizaciones"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('quote.list');
              //Navigator.popAndPushNamed(context, 'quote.list');
            },
          )
        ],
      ),
    );
  }

}