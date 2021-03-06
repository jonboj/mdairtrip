
import 'dart:html';

import "package:mdcdavan/mdcdavan.dart";

class UserCredentials {
  final String email;
  final String userid;
  final String password;
  const UserCredentials(this.email, this.userid, this.password);
}

const String CSS_TEXT_FIELD = 'signin_reg_text_field';

class SigninRegTextField extends MdcTextField {

  SigninRegTextField(final String type, final String helpText)
      : super([
    MdcTextFieldInput(type),
    MdcFloatingLabel(helpText)]) {
    element.classes.add(CSS_TEXT_FIELD);
  }
}

class Logout extends MdaBaseElem {

  static const String STREAM_ID = 'LOGOUT';

  ButtonElement _buttonElement = const MdcElemSpec('button', MDC_CSS.BUTTON, [MDC_CSS.BUTTON__RAISED])
      .build()..text = 'Logout';

  Logout(final String userId) {
    element = new DivElement()..text = userId + ' logout here ';
    element.append(_buttonElement);
    element.classes.add(CSS_TEXT_FIELD);
  }

  Stream<MouseEvent> logoutStream() => _buttonElement.onClick;
}

class Signin extends MdaNodeElemStatic {

  SigninRegTextField _mdcInputEmail = SigninRegTextField('email', 'Email');
  SigninRegTextField _mdcInputUserId = SigninRegTextField('text', 'Userid');
  MdcTextField _mdcInputPassword = SigninRegTextField('password', 'Password');

  ButtonElement _buttonElement = const MdcElemSpec('button', MDC_CSS.BUTTON, [MDC_CSS.BUTTON__RAISED])
      .build()..text = 'Login';

  Signin(SigninRegTextField this._mdcInputEmail,
         SigninRegTextField this._mdcInputUserId,
         MdcTextField this._mdcInputPassword)
      : super(new DivElement(), [_mdcInputEmail, _mdcInputUserId, _mdcInputPassword]) {
      element.append(_buttonElement);
  }

  factory Signin.std() {
    return new Signin(
       new SigninRegTextField('email', 'Email'),
       new SigninRegTextField('text', 'Userid'),
       new SigninRegTextField('password', 'Password'));
  }

  Stream<UserCredentials> userCredStream() =>
      _buttonElement.onClick
          .map((MouseEvent e) => _getUserCred())
          .where((UserCredentials u) => u.userid.isNotEmpty);

  UserCredentials _getUserCred() =>
    new UserCredentials(_mdcInputEmail.getValue(), _mdcInputUserId.getValue(), _mdcInputPassword.getValue());
}

class SigninRegister extends MdaNodeElem {

  Signin _signin;
  Logout _logout;

  SigninRegister(final String userId)
    : super(new DivElement()) {
    buildWithChilds([_subNode(userId)]);
  }

  Stream<UserCredentials> userCredStream() =>
      _signin.userCredStream();

  Stream<MouseEvent> logoutStream() =>
      _logout.logoutStream();

  MdaBaseElem _subNode(final String userId) {
    if (userId.isEmpty) {
      _signin =  new Signin.std();
      return _signin;
    }

    _logout = new Logout(userId);

    return _logout;
  }
}
