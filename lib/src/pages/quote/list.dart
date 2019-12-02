import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quote_acciona/src/pages/partials/MenuLateral.dart';
import 'package:quote_acciona/src/utils/dialog.dart';

class ListPage extends StatefulWidget {
  @override
  _ListQuotesPageState createState() => _ListQuotesPageState();   
}

class _ListQuotesPageState extends State<ListPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  int _itemsCount = 5;  

  @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotizaciones')
      ),
      drawer: MenuLateral(),
      body: ListView.builder(
        itemCount: _itemsCount,
        itemBuilder: (BuildContext context, int i) {
          return _item(context, i);
        },
      ),
      floatingActionButton: _newSolicitude(context),
    );
  }

  Widget _item(BuildContext context, int i) {
    return Container(
      height: 60.0,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(width: 5.0, color: Colors.green)
        ),
        color: Colors.white
      ),
      child: RaisedButton(
        color: Colors.white,
        onPressed: () => _selectedItem(context, i),
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'EA112019-2803',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        'MOVING SYSTEMS SAC',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'LIMA  ',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey
                            ),
                          ),
                          Icon(
                            //FontAwesomeIcons.plane, 
                            //FontAwesomeIcons.ship,
                            FontAwesomeIcons.arrowRight, 
                            color: Colors.grey,
                            size: 12.0
                          ),
                          Text(
                            '  ESPAÑA',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    '3 días vencida',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade400
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      )
    );
  }

  Widget _newSolicitude(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.red,
      onPressed: () {
        Navigator.pushNamed(context, 'quote.new');
      },
    );
  }

  void _selectedItem(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xFF737373),
          height: 240.0,
          padding: EdgeInsets.only(
            left: 5.0,
            right: 5.0
          ),
          //padding: EdgeInsets.all(5.0),
          child: Container(
            child: _buildBottomNavigationMenu(context, index),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)
              )
              //borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
          ),
        );
      }
    );
  }

  ListView _buildBottomNavigationMenu(BuildContext context, int index) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(FontAwesomeIcons.eye),
          title: Text('Observaciones'),
          onTap: () => MyDialog.showModalDialog(context, 'Observaciones', 'I am also having this issue. The text is justified but for lines that take the whole width of the screen but for things like the last line or lines that contain few words it is aligned to the left, not the right.'),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.edit),
          title: Text('Editar'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.clone),
          title: Text('Clonar'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.thumbsUp),
          title: Text('Aprobar'),
          onTap: () => _changeStateQuote(context, index),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.thumbsDown),
          title: Text('Rechazar'),
          onTap: () => {}
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.trash),
          title: Text('Eliminar'),
          onTap: () => _deleteQuote(context, index),
        ),
      ],
    );
  }

  Future<void> _changeStateQuote(BuildContext context, int index) async {
    try {
      MyDialog.showLoadingDialog(context, _keyLoader);
      //await serivce.login(user.uid);
      await Future.delayed(Duration(seconds: 10));
      //Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
      Navigator.of(_keyLoader.currentContext).pop();//close the dialoge
    } catch (err) {
      print(err);
    }
  }


  void _deleteQuote(BuildContext context, int index) {
    MyDialog.confirmDialog(
      context,
      'Eliminar', 
      '¿Estás seguro de eliminar la cotización EA112019-2018?',
      () => _abc(context)
    );
  }

  Future<void> _abc(BuildContext context) async {
    Navigator.of(context).pop();
    MyDialog.showLoadingDialog(context, _keyLoader, text: 'Eliminando...');
    await Future.delayed(Duration(seconds: 10));
    Navigator.of(_keyLoader.currentContext).pop();//close the dialoge
    _itemsCount = _itemsCount - 1;
    setState(() {
      Navigator.of(context).pop();
    });
  }
}