import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quote_acciona/src/models/quote_list.dart';
import 'package:quote_acciona/src/pages/partials/MenuLateral.dart';
import 'package:quote_acciona/src/providers/quote_provider.dart';
import 'package:quote_acciona/src/utils/dialog.dart';
import 'package:quote_acciona/src/utils/utils.dart' as utils;

class ListPage extends StatefulWidget {
  @override
  _ListQuotesPageState createState() => _ListQuotesPageState();   
}

class _ListQuotesPageState extends State<ListPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final _quoteProvider = new QuoteProvider();

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
      body: _list(context),
      /*body: ListView.builder(
        itemCount: _itemsCount,
        itemBuilder: (BuildContext context, int i) {
          return _item(context, i);
        },
      ),*/
      floatingActionButton: _newSolicitude(context),
    );
  }

  Widget _list(BuildContext context) {
    return FutureBuilder(
      future: _quoteProvider.loadQuotes(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if ( snapshot.hasData ) {
          List<dynamic> _quotes = snapshot.data;
          return ListView.builder(
              itemCount: _quotes.length,
              itemBuilder: (BuildContext context, int i) => _item(context, _quotes[i])
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _item(BuildContext context, QuoteList quote) {
    return Container(
      height: 80.0,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(width: 5.0, color: _getColor(quote))
        ),
        color: Colors.white
      ),
      child: RaisedButton(
        color: Colors.white,
        onPressed: () => _selectedItem(context, quote),
        child: Container(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        quote.reference,
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        quote.client,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.circle,
                            color: Colors.grey,
                            size: 8.0
                          ),
                          SizedBox(width: 2.0),
                          Text(
                            quote.origin,
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.solidCircle,
                            color: Colors.grey,
                            size: 8.0
                          ),
                          SizedBox(width: 2.0),
                          Text(
                            quote.destiny,
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
                  _vence(quote)
                ],
              )
            ],
          ),
        )
      )
    );
  }

  Color _getColor(QuoteList quote) {
    if (quote.expiryInDays > 0) return Colors.black87;

    Color color = Colors.green; 
    switch (quote.state) {
      case 0:
        color = Colors.black45;
        break;
      case 2:
        color = Colors.red;
        break;        
    }
    return color;
  }

  Text _vence(QuoteList quote) {
    int days = quote.expiryInDays;
    if (days > 0 && quote.state == 0) {
      return Text(
        '$days días vencida',
        style: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          color: Colors.red.shade400
        ),
      );
    }
    return Text('');    
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

  void _selectedItem(BuildContext context, QuoteList quote) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(          
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0)
            ),
            child: Container(
              height: 300.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton( // A normal IconButton
                            icon: Icon(Icons.arrow_back),
                            onPressed: (){
                              Navigator.of(context).pop();
                            }
                          ),
                          Flexible(
                            child: Text(
                              'Opciones',
                              style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Opacity( // A Opacity widget
                            opacity: 0.0, // setting opacity to zero will make its child invisible
                            child: IconButton(
                                icon: Icon(Icons.clear), // some random icon
                                onPressed: null, // making the IconButton disabled
                            )
                          ),
                        ],
                      ),
                      Divider(height: 1.0,),
                      Expanded(child: _buildBottomNavigationMenu(context, quote),)
                    ],
                  ),
                ],
              ),
            ),
          )
        );
      }
    );
    /*showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 240.0,
          padding: EdgeInsets.only(
            left: 10.0,
            right: 10.0
          ),
          child: Container(
            child: _buildBottomNavigationMenu(context, quote),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)
              )
            ),
          ),
        );
      }
    );*/
  }

  ListView _buildBottomNavigationMenu(BuildContext context, QuoteList quote) {
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
          onTap: () => _changeStateQuote(context, quote),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.thumbsDown),
          title: Text('Rechazar'),
          onTap: () => {}
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.trash),
          title: Text('Eliminar'),
          onTap: () => _deleteQuote(context, quote),
        ),
      ],
    );
  }

  Future<void> _changeStateQuote(BuildContext context, QuoteList quote) async {
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


  void _deleteQuote(BuildContext context, QuoteList quote) {
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