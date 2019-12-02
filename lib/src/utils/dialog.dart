import 'package:flutter/material.dart';

class MyDialog {

  static showModalDialog(BuildContext context, String _title, String _content) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_title),
          content: Text(
            _content,
            textAlign: TextAlign.justify,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK', style: TextStyle(color: Colors.red),),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      }
    );
  }

  static confirmDialog(BuildContext context, String _title, String _content, Function _callback) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_title),
          content: Text(_content),
          actions: <Widget>[
            FlatButton(
              child: Text('NO', style: TextStyle(color: Colors.red.shade300),),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('SI', style: TextStyle(color: Colors.red),),
              onPressed: _callback,
            )
          ],
        );
      }
    );
  }


  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key, {String text = 'Cargando...'}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            key: key,
            //backgroundColor: Colors.black54,
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 10,),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }
    );    
  }

}