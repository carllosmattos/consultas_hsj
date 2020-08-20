import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:brasil_fields/brasil_fields.dart';

class RegisterPatient extends StatefulWidget {
  @override
  _RegisterPatientState createState() => _RegisterPatientState();
}

class _RegisterPatientState extends State<RegisterPatient> {
  final _formKey = GlobalKey<FormState>();

  List<String> _locations = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
  ];

  List<String> gender = [];
  // Controllers//
  final form = FormGroup({
    'name':
        FormControl(validators: [Validators.required, Validators.minLength(5)]),
    'nameMother':
        FormControl(validators: [Validators.required, Validators.minLength(5)]),
    'nameFather':
        FormControl(validators: [Validators.required, Validators.minLength(5)]),
    'socialName': FormControl(),
    'rg': FormControl(validators: [
      Validators.required,
      Validators.minLength(7),
      Validators.maxLength(13)
    ]),
    'cpf': FormControl(
      validators: [
        Validators.required,
        Validators.minLength(14),
      ],
    ),
    'sexo': FormControl(validators: [Validators.required]),
    'dateBirth': FormControl(validators: [Validators.required]),
    'cardSUS': FormControl(validators: [
      Validators.required,
      Validators.minLength(15),
      Validators.maxLength(15)
    ]),
    'adress': FormControl(validators: [Validators.required]),
    'numberLocation': FormControl(validators: [Validators.required]),
    'zip': FormControl(
        validators: [Validators.required, Validators.minLength(10)]),
    'phone': FormControl(
        validators: [Validators.required, Validators.minLength(15)]),
    'email': FormControl(
        validators: [Validators.required, Validators.email],
        asyncValidators: [_uniqueEmail]),
    'password': FormControl(validators: [
      Validators.required,
      Validators.minLength(8),
    ]),
    'passwordConfirmation': FormControl(),
    'numberChild': FormControl(validators: [Validators.required]),
    'education': FormControl(validators: [Validators.required]),
    'belief': FormControl(),
    'breed': FormControl(validators: [Validators.required]),
    'coupleName': FormControl(),
    'comments': FormControl(validators: [Validators.required]),
  }, validators: [
    Validators.mustMatch('password', 'passwordConfirmation')
  ]);

  //Step Properties
  int currentStep = 0;
  bool complete = false;

  next() {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  //Build Step
  List<Step> steps = [
    Step(
      title: const Text('Identificação'),
      isActive: true,
      state: StepState.complete,
      content: Column(
        children: <Widget>[
          ReactiveTextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: "Nome Completo",
                labelStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                suffixIcon: Icon(
                  Icons.person_outline,
                  color: Colors.black87,
                )),
            style: TextStyle(
              fontSize: 20,
            ),
            formControlName: "name",
            validationMessages: {
              ValidationMessage.required: 'Digite seu nome completo',
              ValidationMessage.minLength: 'Campo requer nome e sobrenome',
            },
          ),
          ReactiveTextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: "Nome da mãe?",
                labelStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                suffixIcon: Image.asset("assets/001-woman.png")),
            style: TextStyle(
              fontSize: 20,
            ),
            formControlName: "nameMother",
            validationMessages: {
              ValidationMessage.required: 'Digite o nome da sua mãe',
              ValidationMessage.minLength: 'Campo requer nome e sobrenome',
            },
          ),
          ReactiveTextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "RG",
                labelStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                suffixIcon: Image.asset("assets/id-card.png")),
            style: TextStyle(
              fontSize: 20,
            ),
            formControlName: "rg",
            validationMessages: {
              ValidationMessage.required: 'Digite o número do seu RG',
              ValidationMessage.minLength:
                  'O número do RG precisa ter nomínimo 7 dígitos',
              ValidationMessage.maxLength:
                  'O número do RG precisa ter até 13 dígitos'
            },
          ),
          ReactiveTextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "CPF",
                labelStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                suffixIcon: Image.asset("assets/id-card.png")),
            style: TextStyle(
              fontSize: 20,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ],
            formControlName: "cpf",
            validationMessages: {
              ValidationMessage.required: 'Digite o número do seu CPF',
              ValidationMessage.minLength:
                  'O CPF não pode ser menor que 11 dígitos',
            },
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
                labelText: 'Sexo',
                labelStyle: TextStyle(color: Colors.black87),
                suffixIcon: Image.asset("assets/003-transgender.png")),
            items: <String>[
              "Masculino",
              "Feminino",
              "Homem transgênero",
              "Mulher Transgênero",
              "Homem Transexual",
              "Mulher Transexual",
              "Cisgênero",
              "Não sei responder",
              "Prefiro não responder",
              "Outros"
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                child: Text(value),
                value: value,
              );
            }).toList(),
            onChanged: (value) {
              Future<void> setState(param0) async => setState(() {});
            },
          ),
          ReactiveTextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Data de nascimento",
                labelStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                suffixIcon: Icon(Icons.date_range, color: Colors.black87)),
            style: TextStyle(
              fontSize: 20,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              DataInputFormatter(),
            ],
            formControlName: "dateBirth",
            validationMessages: {
              ValidationMessage.required: 'Digite sua data de nascimento',
            },
          ),
          ReactiveTextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Número do cartão do SUS",
                labelStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                suffixIcon: Icon(Icons.credit_card, color: Colors.black87)),
            style: TextStyle(
              fontSize: 20,
            ),
            formControlName: "cardSUS",
            validationMessages: {
              ValidationMessage.required: 'Digite o número do cartão do SUS',
              ValidationMessage.minLength: 'O número precisa ter 15 dígitos',
              ValidationMessage.maxLength: 'O número precisa ter 15 dígitos'
            },
          ),
        ],
      ),
    ),
    Step(
      isActive: false,
      state: StepState.editing,
      title: const Text('Endereço'),
      content: Column(
        children: <Widget>[
          ReactiveTextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "CEP",
                labelStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                suffixIcon: Icon(
                  Icons.location_on,
                  color: Colors.black87,
                )),
            style: TextStyle(
              fontSize: 20,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            formControlName: "zip",
            validationMessages: {
              ValidationMessage.required: 'Digite seu CEP',
              ValidationMessage.minLength: 'O CEP precisa ter 8 dígitos'
            },
          ),
          ReactiveTextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: "Endereço",
                labelStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                suffixIcon: Icon(Icons.map, color: Colors.black87)),
            style: TextStyle(
              fontSize: 20,
            ),
            formControlName: "adress",
            validationMessages: {
              ValidationMessage.required: 'Digite seu endereço',
            },
          ),
          ReactiveTextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Número",
                labelStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                suffixIcon: Image.asset("assets/005-numbers.png")),
            style: TextStyle(
              fontSize: 20,
            ),
            formControlName: "numberLocation",
            validationMessages: {
              ValidationMessage.required: 'Informe o número. Ex.: "123"',
            },
          ),
        ],
      ),
    ),
    Step(
      isActive: false,
      state: StepState.editing,
      title: const Text('Informações de conta'),
      content: Column(
        children: <Widget>[
          ReactiveTextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Telefone",
                labelStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                suffixIcon: Icon(
                  Icons.phone,
                  color: Colors.black87,
                )),
            style: TextStyle(
              fontSize: 20,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TelefoneInputFormatter(),
            ],
            formControlName: "phone",
            validationMessages: {
              ValidationMessage.required: 'Digite seu número do seu telefone',
              ValidationMessage.minLength: 'O telefone precisa ter 11 dígitos'
            },
          ),
          ReactiveTextField(
            formControlName: "email",
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'E-mail',
              labelStyle: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
              suffixIcon: ReactiveStatusListenableBuilder(
                formControlName: 'email',
                builder: (context, control, child) {
                  return control.isNull
                      ? Icon(Icons.mail, color: Colors.black87)
                      : control.pending
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Container(width: 0);
                },
              ),
            ),
            validationMessages: {
              ValidationMessage.required: 'Digite seu e-mail',
              ValidationMessage.email: 'Digite um e-mail válido',
              'unique': 'Esse email já está em uso',
            },
            textInputAction: TextInputAction.next,
          ),
          ReactiveTextField(
            formControlName: 'password',
            decoration: InputDecoration(
                labelText: 'Digite sua senha',
                labelStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                suffixIcon: Icon(
                  Icons.remove_red_eye,
                  color: Colors.black87,
                )),
            obscureText: true,
            validationMessages: {
              ValidationMessage.required: 'Digite sua senha',
              ValidationMessage.minLength: 'A senha precisa ter 8 dígitos'
            },
          ),
          ReactiveTextField(
            formControlName: 'passwordConfirmation',
            decoration: InputDecoration(
                labelText: 'Confirme sua senha',
                labelStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                suffixIcon: Icon(
                  Icons.remove_red_eye,
                  color: Colors.black87,
                )),
            obscureText: true,
            validationMessages: {
              ValidationMessage.mustMatch: 'Senhas não correspondem',
            },
          ),
        ],
      ),
    ),
    Step(
      isActive: false,
      state: StepState.editing,
      title: const Text('Informações adicionais'),
      content: Column(
        children: <Widget>[
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
                labelText: 'Filhos',
                labelStyle: TextStyle(color: Colors.black87),
                suffixIcon: Image.asset("assets/006-pacifier.png")),
            items: <String>[
              "0",
              "1",
              "2",
              "3",
              "4",
              "5",
              "6",
              "7",
              "8",
              "9",
              "10",
              "11",
              "12",
              "13",
              "14",
              "15",
              "16",
              "17",
              "18",
              "19",
              "20",
              "Mais de 20"
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                child: Text(value),
                value: value,
              );
            }).toList(),
            onChanged: (value) {
              Future<void> setState(param0) async => setState(() {});
            },
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
                labelText: 'Escolaridade',
                labelStyle: TextStyle(color: Colors.black87),
                suffixIcon: Image.asset("assets/007-mortarboard.png")),
            items: <String>[
              "Analfabeto",
              "E. Fundamental completo",
              "E. Fundamental incompleto",
              "E. médio completo",
              "E. médio incompleto",
              "Superior completo",
              "Pós-Graduação",
              "Mestrado",
              "Doutorado",
              "Pós-Doutorado"
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                child: Text(value),
                value: value,
              );
            }).toList(),
            onChanged: (value) {
              Future<void> setState(param0) async => setState(() {});
            },
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
                labelText: 'Cor',
                labelStyle: TextStyle(color: Colors.black87),
                suffixIcon: Image.asset("assets/007-mortarboard.png")),
            items: <String>["Branco", "Pardo", "Negro", "Indígena", "Amarelo"]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                child: Text(value),
                value: value,
              );
            }).toList(),
            onChanged: (value) {
              Future<void> setState(param0) async => setState(() {});
            },
          ),
          ReactiveTextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: "Nome do pai",
                labelStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                suffixIcon: Image.asset("assets/002-man.png")),
            style: TextStyle(
              fontSize: 20,
            ),
            formControlName: "nameFather",
            validationMessages: {
              ValidationMessage.required: 'Digite seu nome completo',
              ValidationMessage.minLength: 'Campo requer nome e sobrenome',
            },
          ),
        ],
      ),
    ),
    Step(
      isActive: false,
      state: StepState.editing,
      title: const Text('Informações opcionais'),
      content: Column(
        children: <Widget>[
          ReactiveTextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: "Nome Social",
                labelStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                suffixIcon: Image.asset("assets/003-transgender.png")),
            style: TextStyle(
              fontSize: 20,
            ),
            formControlName: "socialName",
          ),
          ReactiveTextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: "Nome do(a) companheiro(a)",
                labelStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                suffixIcon: Image.asset("assets/009-users.png")),
            style: TextStyle(
              fontSize: 20,
            ),
            formControlName: "coupleName",
          ),
          ReactiveTextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: "Qual sua Religião",
                labelStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                suffixIcon: Image.asset("assets/church.png")),
            style: TextStyle(
              fontSize: 20,
            ),
            formControlName: "belief",
          ),
          ReactiveTextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                labelText: "Observações",
                labelStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                suffixIcon: Icon(
                  Icons.comment,
                  color: Colors.black87,
                )),
            style: TextStyle(
              fontSize: 20,
            ),
            formControlName: "comments",
            validationMessages: {
              ValidationMessage.required:
                  'Por favor digite alguma observação \nEx.: Alergias, doenças crônicas...',
            },
          ),
        ],
      ),
    ),
    Step(
      state: StepState.error,
      title: const Text('Avatar'),
      subtitle: const Text("Error!"),
      content: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.red,
          )
        ],
      ),
    ),
  ];

  FormControl get password => this.form.control('password');

  FormControl get passwordConfirmation =>
      this.form.control('passwordConfirmation');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: Colors.blue),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Cadastre-se'),
          ),
          body: Column(
            children: <Widget>[
              complete
                  ? Expanded(
                      child: Center(
                        child: AlertDialog(
                          title: new Text("Profile Created"),
                          content: new Text(
                            "Tada!",
                          ),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text("Close"),
                              onPressed: () {
                                setState(() => complete = false);
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: ReactiveForm(
                        key: _formKey,
                        formGroup: this.form,
                        child: Stepper(
                          steps: steps,
                          currentStep: currentStep,
                          onStepContinue: next,
                          onStepTapped: (step) => goTo(step),
                          onStepCancel: cancel,
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }
}

/// Async validator in use emails example
const inUseEmails = ['johndoe@email.com', 'john@email.com'];

/// Async validator example that simulates a request to a server
/// to validate if the email of the user is unique.
Future<Map<String, dynamic>> _uniqueEmail(AbstractControl control) async {
  final error = {'unique': false};

  final emailAlreadyUsed = await Future.delayed(
    Duration(seconds: 5), // a delay to simulate a time consuming operation
    () => inUseEmails.contains(control.value),
  );

  if (emailAlreadyUsed) {
    control.touch();
    return error;
  }

  return null;
}
