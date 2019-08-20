import 'package:flutter/widgets.dart';
import 'package:quote_acciona/src/blocs/login_bloc.dart';
export 'package:quote_acciona/src/blocs/login_bloc.dart';

class LoginProvider extends InheritedWidget {
  final loginBloc = LoginBloc();

  LoginProvider({ Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(LoginProvider) as LoginProvider).loginBloc;
  }
}