import 'package:flutter/material.dart';
import 'package:quote_acciona/src/providers/login_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      )
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final header = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Colors.red,
            Colors.redAccent
          ]
        )
      ),
    );

    final circle = Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    return Stack(
      children: <Widget>[
        header,
        Positioned( child: circle, top: 90.0, left: 30.0),
        Positioned( child: circle, top: -40.0, right: -30.0),
        Positioned( child: circle, bottom: -50.0, right: -10.0),
        Positioned( child: circle, bottom: 120.0, right: 20.0),
        Positioned( child: circle, bottom: -50.0, left: -20.0),

        Container(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            children: <Widget>[
              new SvgPicture.asset('assets/icons/acciona.svg', color: Colors.white, height: 120.0, width: 120.0),
              SizedBox(height: 10.0, width: double.infinity),
              /*Text(
                'Acciona', 
                style: TextStyle(color: Colors.white, fontSize: 25.0)
              )*/
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = LoginProvider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 150.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow> [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearButton(bloc)
              ],
            ),
          ),
          Text('¿Olvidó la contraseña?'),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.redAccent),
              hintText: 'ejemplo@acciona.com',
              labelText: 'Correo electrónico',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.redAccent),
              labelText: 'Contraseña',
              //counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.fromValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 80.0,
              vertical: 15.0
            ),
            child: Text('Ingresar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Colors.redAccent,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _login(context, bloc) : null,
        );
      }
    );
  }

  _login(BuildContext context, LoginBloc bloc) {
    Navigator.of(context).pushReplacementNamed('home');
  }
}