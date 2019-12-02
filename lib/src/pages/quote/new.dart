import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final rowsQuantity = 1;
  int _currentStep = 0;

  TextEditingController _validController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.translate),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.cloudUploadAlt),
            onPressed: (){},
          ),
        ],
      ),
    );
  }

  List<String> _options = ['Contado', 'Crédito'];
  List<String> _vias = ['Aérea', 'Marítima'];
  List<String> _services = ['Importación', 'Exportación', 'Otros Servicios'];

  String _paymentMethod = 'Contado';
  String _via = 'Aérea';
  String _service = 'Importación';

  List<DropdownMenuItem<String>> getOptions() {
    List<DropdownMenuItem<String>> _list = new List();
    _options.forEach((x) {
      _list.add(DropdownMenuItem(
        child: Text(x),
        value: x,
      ));
    });
    return _list;
  }

  List<DropdownMenuItem<String>> getOptionsVia() {
    List<DropdownMenuItem<String>> _list = new List();
    _vias.forEach((x) {
      _list.add(DropdownMenuItem(
        child: Text(x),
        value: x,
      ));
    });
    return _list;
  }

  List<DropdownMenuItem<String>> getOptionsServices() {
    List<DropdownMenuItem<String>> _list = new List();
    _services.forEach((x) {
      _list.add(DropdownMenuItem(
        child: Text(x),
        value: x,
      ));
    });
    return _list;
  }

  Widget _inputPayment(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0,
              style: BorderStyle.solid,
              color: Colors.black38
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        child: DropdownButton(
          isExpanded: true,
          icon: Icon(Icons.attach_money),
          value: _paymentMethod,
          items: getOptions(),
          onChanged: (opt) {
            setState(() {
            _paymentMethod = opt; 
            });
            print(opt);
          },
        ),
      ),
    );
  }

  Widget _inputVia(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0,
              style: BorderStyle.solid,
              color: Colors.black38
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        child: DropdownButton(
          isExpanded: true,
          icon: _via == 'Aérea' ? Icon(Icons.flight) : Icon(Icons.directions_boat),
          value: _via,
          items: getOptionsVia(),
          onChanged: (opt) {
            setState(() {
            _via = opt; 
            });
            print(opt);
          },
        ),
      ),
    );
  }

  Widget _inputService(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0,
              style: BorderStyle.solid,
              color: Colors.black38
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        child: DropdownButton(
          isExpanded: true,
          icon: Icon(Icons.import_export),
          value: _service,
          items: getOptionsServices(),
          onChanged: (opt) {
            setState(() {
            _service = opt; 
            });
            print(opt);
          },
        ),
      ),
    );
  }

  Widget _inputType(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0,
              style: BorderStyle.solid,
              color: Colors.black38
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        child: DropdownButton(
          isExpanded: true,
          icon: Icon(Icons.class_),
          value: _paymentMethod,
          items: getOptions(),
          onChanged: (opt) {
            setState(() {
            _paymentMethod = opt; 
            });
            print(opt);
          },
        ),
      ),
    );
  }

  Widget _inputIncoterm(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0,
              style: BorderStyle.solid,
              color: Colors.black38
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        child: DropdownButton(
          isExpanded: true,
          icon: Icon(Icons.add_box),
          value: _paymentMethod,
          items: getOptions(),
          onChanged: (opt) {
            setState(() {
            _paymentMethod = opt; 
            });
            print(opt);
          },
        ),
      ),
    );
  }

  Widget _inputValid(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _validController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        labelText: 'Validez',
        hintText: 'Validez',
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picker = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2019),
      lastDate: new DateTime(2025),
      locale: Locale('es', 'PE')
    );

    if (picker != null) {
      setState(() {
        String date = picker.toString();
        List<String> dateSplit = date.split('-');
        _validController.text = dateSplit[2].split(' ')[0] + '/' + dateSplit[1] + '/' +dateSplit[0];
      });
    }
  }
  
  Widget _inputCient(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Cliente'
      ),
    );
  }

  Widget _inputContact(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Contacto'
      ),
    );
  }

  Widget _inputProduct(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
    );
  }

  Widget _inputOrigin(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Origen'
      ),
    );
  }

  Widget _inputDestiny(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Destino'
      ),
    );
  }

  /*Widget _buttonSave(BuildContext context) {

    return FloatingActionButton(
      child: Icon(Icons.send),
      backgroundColor: Colors.red,
      onPressed: () {},
    );
  }

  Widget _row(int index) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Text(
            //this.list[index].code.toString(),
            'Demo',
            style: TextStyle(
              color: Colors.red
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          Text('Demo 2')
          //Text(this.list[index].name)
        ],
      ),
      trailing: Switch(
        onChanged: (bool value) {
          //this.list[index].state = value;
        },
        value: true,
        //value: this.list[index].state,
      ),
    );
  }*/
}