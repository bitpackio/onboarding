// @dart=2.9
//
// Copyright (C) 2021 bitpack.io <hello@bitpack.io>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License at <http://www.gnu.org/licenses/> for
// more details.
//
// See LICENSE.txt for detailed license information.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyFormPage(title: 'Onboarding Frontend'),
    );
  }
}

Future<http.Response> savePeople(People people) {
  print('sending json: ' + people.toJSON);
  return http.post(
    Uri.http('127.0.0.1:8080', '/v1/people'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: people.toJSON,
  );
}

class MyFormPage extends StatefulWidget {
  MyFormPage({Key key, this.title = "title"}) : super(key: key);

  final String title;

  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  Future _futureForm;
  People people = new People();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Boat identifier',
                      border: OutlineInputBorder(),
                    ),
                    validator: boatIdValidator,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(3),
                      WhitelistingTextInputFormatter(RegExp("[0-9]")),
                      BlacklistingTextInputFormatter.singleLineFormatter,
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                    ),
                    validator: genderValidator,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(1),
                      WhitelistingTextInputFormatter(RegExp("[fm]")),
                      BlacklistingTextInputFormatter.singleLineFormatter,
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Scabies',
                      border: OutlineInputBorder(),
                    ),
                    validator: scabiesValidator,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(1),
                      WhitelistingTextInputFormatter.digitsOnly,
                      WhitelistingTextInputFormatter(RegExp("[01]")),
                      BlacklistingTextInputFormatter.singleLineFormatter,
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Needs protection',
                      border: OutlineInputBorder(),
                    ),
                    validator: needsProtectionValidator,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(1),
                      WhitelistingTextInputFormatter.digitsOnly,
                      WhitelistingTextInputFormatter(RegExp("[01]")),
                      BlacklistingTextInputFormatter.singleLineFormatter,
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Medical case',
                      border: OutlineInputBorder(),
                    ),
                    validator: medicalCaseValidator,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(1),
                      WhitelistingTextInputFormatter.digitsOnly,
                      WhitelistingTextInputFormatter(RegExp("[01]")),
                      BlacklistingTextInputFormatter.singleLineFormatter,
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Nationality',
                      border: OutlineInputBorder(),
                    ),
                    validator: nationalityValidator,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(2),
                      WhitelistingTextInputFormatter(RegExp("[a-z]")),
                      BlacklistingTextInputFormatter.singleLineFormatter,
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                    ),
                    validator: ageValidator,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(2),
                      WhitelistingTextInputFormatter.digitsOnly,
                      WhitelistingTextInputFormatter(RegExp("[1-9]")),
                      BlacklistingTextInputFormatter.singleLineFormatter,
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Alone traveling woman',
                      border: OutlineInputBorder(),
                    ),
                    validator: aloneTravelingWomanValidator,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(1),
                      WhitelistingTextInputFormatter.digitsOnly,
                      WhitelistingTextInputFormatter(RegExp("[01]")),
                      BlacklistingTextInputFormatter.singleLineFormatter,
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Unaccompanied minor',
                      border: OutlineInputBorder(),
                    ),
                    validator: unaccompaniedMinorValidator,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(1),
                      WhitelistingTextInputFormatter.digitsOnly,
                      WhitelistingTextInputFormatter(RegExp("[01]")),
                      BlacklistingTextInputFormatter.singleLineFormatter,
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Pregnant woman',
                      border: OutlineInputBorder(),
                    ),
                    validator: pregnantWomanValidator,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(1),
                      WhitelistingTextInputFormatter.digitsOnly,
                      WhitelistingTextInputFormatter(RegExp("[01]")),
                      BlacklistingTextInputFormatter.singleLineFormatter,
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Temperature',
                      border: OutlineInputBorder(),
                    ),
                    validator: temperatureValidator,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(2),
                      WhitelistingTextInputFormatter.digitsOnly,
                      WhitelistingTextInputFormatter(RegExp("[1-37]")),
                      BlacklistingTextInputFormatter.singleLineFormatter,
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.grey,
                        textColor: Colors.white,
                        onPressed: () {
                          _formKey.currentState.reset();
                        },
                        child: Text('Reset'),
                      ),
                      SizedBox(width: 25),
                      RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            print("Form is valid and can be processed");
                            _futureForm = savePeople(people);
                          } else {
                            print("Form is not valid");
                          }
                        },
                        child: Text('Save'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  String boatIdValidator(value) {
    if (value.isEmpty) {
      return 'Please enter the boat id.';
    }
    people.boatID = int.parse(value);
    print("setting boat id: " + people.boatID.toString());
    return null;
  }

  String genderValidator(value) {
    if (value.isEmpty) {
      return 'Please enter the gender of the person.';
    }
    people.gender = value;
    print("setting gender: " + people.gender);
    return null;
  }

  String scabiesValidator(value) {
    if (value.isEmpty) {
      return 'Please enter whether the person has scabies.';
    }
    people.scabies = int.parse(value);
    print("setting scabies: " + people.scabies.toString());
    return null;
  }

  String needsProtectionValidator(value) {
    if (value.isEmpty) {
      return 'Please enter if the person needs help.';
    }
    people.needsProtection = int.parse(value);
    print("setting needs protection: " + people.needsProtection.toString());
    return null;
  }

  String medicalCaseValidator(value) {
    if (value.isEmpty) {
      return 'Please enter whether the person is a medical case.';
    }
    people.medicalCase = int.parse(value);
    print("setting medical case: " + people.medicalCase.toString());
    return null;
  }

  String ageValidator(value) {
    if (value.isEmpty) {
      return 'Please enter the age of the person.';
    }
    people.age = int.parse(value);
    print("setting age: " + people.age.toString());
    return null;
  }

  String aloneTravelingWomanValidator(value) {
    if (value.isEmpty) {
      return 'Please enter whether the person is a woman traveling alone.';
    }
    people.aloneTravelingWoman = int.parse(value);
    print("setting alone traveling woman: " + people.aloneTravelingWoman.toString());
    return null;
  }

  String nationalityValidator(value) {
    if (value.isEmpty) {
      return 'Please enter the nationality of the person.';
    }
    people.nationality = value;
    print("setting nationality: " + people.nationality);
    return null;
  }

  String unaccompaniedMinorValidator(value) {
    if (value.isEmpty) {
      return 'Please enter whether the person is an unaccompanied minor.';
    }
    people.unaccompaniedMinor = int.parse(value);
    print("setting unaccompanied minor: " + people.unaccompaniedMinor.toString());
    return null;
  }

  String pregnantWomanValidator(value) {
    if (value.isEmpty) {
      return 'Please enter whether the person is a pregnant woman.';
    }
    people.pregnantWoman = int.parse(value);
    print("setting pregnant woman: " + people.pregnantWoman.toString());
    return null;
  }

  String temperatureValidator(value) {
    if (value.isEmpty) {
      return 'Please enter the person\'s temperature.';
    }
    people.temperature = int.parse(value);
    print("setting temperature: " + people.temperature.toString());
    return null;
  }
}

class People { 

  String gender, nationality;
  int id, boatID, needsProtection, medicalCase, aloneTravelingWoman;
  int age, scabies, unaccompaniedMinor, pregnantWoman, temperature;

  String get toJSON {
    return "{" +
      "\"boatid\":" + boatID.toString() + "," +   
      "\"gender\":" + "\"" + gender + "\"" +  "," +  
      "\"scabies\":" + scabies.toString() + "," + 
      "\"needs_protection\":" + needsProtection.toString() + "," + 
      "\"medical_case\":" + medicalCase.toString() + "," + 
      "\"nationality\":" + "\"" + nationality + "\"" + "," + 
      "\"age\":" + age.toString() + "," + 
      "\"alone_traveling_woman\":" + aloneTravelingWoman.toString() + "," + 
      "\"unaccompanied_minor\":" + unaccompaniedMinor.toString() + "," + 
      "\"pregnant_woman\":" + pregnantWoman.toString() + "," + 
      "\"temperature\":" + temperature.toString() + 
    "}";
  }
}  
