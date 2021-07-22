import 'package:flutter/material.dart';
import 'dart:io';
//Relative Package
import '../picker/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);
  final void Function(String email, String password, String username,
      bool isLogin, File image, BuildContext context) submitFn;
  final bool isLoading;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail;
  String _userName;
  String _userPsw;
  var _isLogin = true;
  File _pickedImage;
  void _imagePicker(File image) {
    _pickedImage = image;
  }

  void _tryLogin() {
    final valid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_pickedImage == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Pick An Image.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (valid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPsw.trim(), _userName, _isLogin,
          _pickedImage, context);
    }
  }

  @override
  void dispose() {
    _formKey.currentState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(_imagePicker),
                  TextFormField(
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    key: ValueKey('email'),
                    onSaved: (vale) {
                      _userEmail = vale;
                    },
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Enter a Valid Email Address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(
                        gapPadding: 5,
                        borderSide: BorderSide(style: BorderStyle.solid),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (!_isLogin)
                    TextFormField(
                      textCapitalization: TextCapitalization.words,
                      autocorrect: true,
                      key: ValueKey('username'),
                      onSaved: (vale) {
                        _userName = vale;
                      },
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Enter the valid Username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'User Name',
                        hintText: 'Username should be more than 4 characters',
                        border: OutlineInputBorder(
                          gapPadding: 5,
                          borderSide: BorderSide(style: BorderStyle.solid),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    key: ValueKey('userpassword'),
                    onSaved: (vale) {
                      _userPsw = vale;
                    },
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Enter a Valid Password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Password should be more than 7 characters',
                      border: OutlineInputBorder(
                        gapPadding: 5,
                        borderSide: BorderSide(style: BorderStyle.solid),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  widget.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            RaisedButton(
                              onPressed: _tryLogin,
                              child: Text(_isLogin ? 'Login' : 'Signup'),
                            ),
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(_isLogin
                                  ? 'Create New Account'
                                  : 'I Already have an account'),
                              textColor: Theme.of(context).primaryColor,
                            ),
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
