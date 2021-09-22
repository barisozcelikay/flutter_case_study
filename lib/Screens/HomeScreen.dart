import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_case_study_project/Models/ticketCards_model.dart';
import 'package:flutter_case_study_project/Models/ticketInfo_model.dart';
import 'package:flutter_case_study_project/Models/userModel.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_case_study_project/constansts.dart';

import '../Models/departureDatas.dart';

Future<TicketInfoModel> fetchAlbum() async {
  final response = await http.get(Uri.parse(
      'https://anybwnk52i.execute-api.eu-central-1.amazonaws.com/test/departureTimes'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var result = TicketInfoModel.fromJson(jsonDecode(response.body));
    return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load tickets');
  }
}

Future<UserModel?> createUser(String email, String password) async {
  final String apiUrl =
      "https://anybwnk52i.execute-api.eu-central-1.amazonaws.com/test/login";

  final response = await http.post(Uri.parse(apiUrl),
      body: {email: "myapp@test.com", password: "123456"});

  if (response.statusCode == 200) {
    final String responseString = response.body;

    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<TicketInfoModel> futureAlbum;
  Color home = kselected_color;
  Color ticket = knotselected_color;
  late UserModel _user;
  bool ispressed = false;

  final TextEditingController email_controller = TextEditingController();
  final TextEditingController password_controller = TextEditingController();

  @override
  void initState() {
    futureAlbum = fetchAlbum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Icon(
            Icons.directions_bus,
            size: 27,
          ),
          backgroundColor: Color(0xffFE5301),
          toolbarHeight: 100, // 116,
          title: Text(
            "TEST APP",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18), //
          ),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Stack(alignment: Alignment.bottomLeft, children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Image.network(
                    "https://images.unsplash.com/photo-1528728329032-2972f65dfb3f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=80"),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, bottom: 16),
                child: Text(
                  "Explore out destinations",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
              )
            ]),
          ),
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "Departure Times",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          Flexible(
            child: Container(
              height: 403,
              color: Color.fromRGBO(246, 246, 246, 1),
              child: FutureBuilder<TicketInfoModel>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DepartureDatas(datas: snapshot.data);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
          )
        ]),
        bottomNavigationBar: Container(
          height: 67,
          child: Padding(
            padding: EdgeInsets.only(left: 55), // 75
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      home = kselected_color;
                      ticket = knotselected_color;
                    });
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                            child: Icon(
                          Icons.home,
                          color: home,
                        )),
                        Padding(
                            padding: EdgeInsets.only(
                              left: 14,
                            ),
                            child: Text(
                              "Homescreen",
                              style: TextStyle(
                                  color: home,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      ticket = kselected_color;
                      home = knotselected_color;
                    });
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => Container(
                        width: double.infinity,
                        height: 400,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          title: Center(child: Text('Welcome Back !')),
                          content: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: email_controller,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email',
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TextField(
                                  controller: password_controller,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                  ),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                RaisedButton(
                                  onPressed: () async {
                                    final String email = email_controller.text;
                                    final String password =
                                        password_controller.text;

                                    final UserModel? user =
                                        await createUser(email, password);

                                    setState(() {
                                      ispressed = true;
                                      _user = user!;
                                    });
                                  },
                                  color: kselected_color,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.red)),
                                  child: Text(
                                    "LOG IN",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                //ispressed ? Container() : Text(_user.message)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 51),
                            child: Icon(
                              Icons.text_snippet,
                              color: ticket,
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                            ),
                            child: Text(
                              "Tickets",
                              style: TextStyle(
                                  color: ticket,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
