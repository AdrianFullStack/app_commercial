import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  bool isCharge = true;

  final rowsQuantity = 1;
  int _currentStep = 0;

  TextEditingController _validController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Cotización'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.translate),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.cloudUploadAlt),
            onPressed: (){},
          ),
        ]
      ),
      body: Container(
        alignment: Alignment(0.0, 0.0),
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          //onStepTapped: (int step) => setState(() => _currentStep = step),
          onStepCancel: () => setState(() => _currentStep > 0 ? _currentStep-- : _currentStep),
          onStepContinue: () => setState(() => _currentStep < 2 ? _currentStep++ : _currentStep),
          controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      buttonNext(onStepContinue),
                      buttonBack(onStepCancel),                      
                    ]);
          },
          steps: <Step> [
            Step(
              title: Text(''),
              content: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 260.0,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: _inputPayment(context),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _inputVia(context),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.0),
                      _inputService(context),
                      SizedBox(height: 15.0),
                      _inputType(context),
                      SizedBox(height: 15.0),
                      _inputIncoterm(context),
                      SizedBox(height: 15.0),
                      _inputValid(context),
                    ],
                  ),
                )
              ),
              isActive: _currentStep == 0 ? true : false
            ),
            Step(
              title: Text(''),
              content: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _inputCient(context),
                  _inputContact(context),
                  _inputProduct(context),
                  _inputOrigin(context),
                  _inputDestiny(context),
                ],
              ),
              isActive: _currentStep == 1 ? true : false
            ),
            Step(
              title: Text(''),
              content: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 260.0,
              ),
              isActive: _currentStep == 2 ? true : false
            ),
          ],
        ),
      )
    );
  }

  Widget buttonNext(VoidCallback onStepContinue) {
    switch (_currentStep) {
      case 0:
        return Expanded(
          child: FlatButton(
            color: Colors.red,
            child: Text('Siguiente', style: TextStyle(color: Colors.white)),
            onPressed: onStepContinue,
          )
        );
        break;
      case 2:
        return FlatButton(
          color: Colors.red,
          child: Text('Guardar', style: TextStyle(color: Colors.white)),
          onPressed: () => print('Save data')
        );
        break;
      default:
        return FlatButton(
          color: Colors.red,
          child: Text('Siguiente', style: TextStyle(color: Colors.white)),
          onPressed: onStepContinue,
        );
    }
  }

  Widget buttonBack(VoidCallback onStepCancel) {
    if (_currentStep > 0) {
      return FlatButton(
        color: Colors.grey,
        child: Text('Atrás', style: TextStyle(color: Colors.white)),
        onPressed: onStepCancel,
      );
    } else {
      return SizedBox();
    }
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
        child: Text(x, style: TextStyle(fontSize: 12)),
        value: x,
      ));
    });
    return _list;
  }

  List<DropdownMenuItem<String>> getOptionsVia() {
    List<DropdownMenuItem<String>> _list = new List();
    _vias.forEach((x) {
      _list.add(DropdownMenuItem(
        child: Text(x, style: TextStyle(fontSize: 12)),
        value: x,
      ));
    });
    return _list;
  }

  List<DropdownMenuItem<String>> getOptionsServices() {
    List<DropdownMenuItem<String>> _list = new List();
    _services.forEach((x) {
      _list.add(DropdownMenuItem(
        child: Text(x, style: TextStyle(fontSize: 12)),
        value: x,
      ));
    });
    return _list;
  }

  Widget _inputPayment(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        height: 35.0,
        padding: EdgeInsets.only(left: 10.0, right: 5.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0,
              style: BorderStyle.solid,
              color: Colors.black38
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
        child: DropdownButton(
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down),
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
        height: 35.0,
        padding: EdgeInsets.only(left: 10.0, right: 5.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0,
              style: BorderStyle.solid,
              color: Colors.black38
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
        child: DropdownButton(
          isExpanded: true,
          //icon: _via == 'Aérea' ? Icon(Icons.flight) : Icon(Icons.directions_boat),
          icon: Icon(Icons.arrow_drop_down),
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
        height: 35.0,
        padding: EdgeInsets.only(left: 10.0, right: 5.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0,
              style: BorderStyle.solid,
              color: Colors.black38
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
        child: DropdownButton(
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down),
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
        height: 35.0,
        padding: EdgeInsets.only(left: 10.0, right: 5.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0,
              style: BorderStyle.solid,
              color: Colors.black38
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
        child: DropdownButton(
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down),
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
        height: 35.0,
        padding: EdgeInsets.only(left: 10.0, right: 5.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0,
              style: BorderStyle.solid,
              color: Colors.black38
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
        child: DropdownButton(
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down),
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
      style: TextStyle(fontSize: 12.0),
      enableInteractiveSelection: false,
      controller: _validController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        border: OutlineInputBorder(),
        labelText: 'Validez',
        hintText: 'Validez',
        //suffixIcon: Icon(Icons.calendar_today, size: 12.0)
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