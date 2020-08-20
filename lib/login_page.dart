import 'package:consultas_hsj/Scheduling_page.dart';
import 'package:consultas_hsj/register_patient_page.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final form = FormGroup({
    'email': FormControl(validators: [Validators.required, Validators.email]),
    'password': FormControl(validators: [
      Validators.required,
      Validators.minLength(8),
    ]),
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: this.form,
      child: Stack(
        children: <Widget>[
          Image.asset(
            "assets/medicos.png",
            fit: BoxFit.cover,
            height: 1000.0,
            color: Color.fromRGBO(255, 255, 255, 0.5),
            colorBlendMode: BlendMode.modulate,
          ),
          Container(
            padding: EdgeInsets.only(top: 60, left: 40, right: 40),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  width: 150.0,
                  height: 150.0,
                  child: Image.asset("assets/LogoHSJ.png"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ReactiveTextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    labelStyle: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                    suffixIcon: Icon(
                      Icons.mail,
                      color: Colors.black87,
                    ),
                  ),
                  style: TextStyle(fontSize: 20),
                  formControlName: 'email',
                  validationMessages: {
                    ValidationMessage.required:
                        'Digite seu e-mail cadastrado para entrar',
                    ValidationMessage.minLength:
                        'O e-mail digitado não é válido',
                  },
                ),
                ReactiveTextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.black87,
                    ),
                  ),
                  style: TextStyle(fontSize: 20),
                  formControlName: 'password',
                  obscureText: true,
                  validationMessages: {
                    ValidationMessage.required:
                        'Digite sua senha cadastrada para entrar',
                    ValidationMessage.minLength:
                        'A senha deve ter pelo menos 8 caracteres',
                  },
                ),
                Container(
                  height: 50,
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: Text("Esqueceu sua senha? Clique aqui!",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0)),
                    textColor: Colors.black,
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Scheduling(),
                      //   ),
                      // );
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.3, 1],
                      colors: [
                        Colors.red[700],
                        Colors.red[400],
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: SizedBox.expand(
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Entrar",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            child: SizedBox(
                              child: Icon(Icons.lock_open, color: Colors.white),
                              height: 28,
                              width: 28,
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Scheduling(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  child: FlatButton(
                    child: Text(
                      "Clique aqui para se cadastrar!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPatient(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
