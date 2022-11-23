import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_notes/Activitys/home_screen.dart';
import 'package:my_notes/Database/dbhelper.dart';
import 'package:my_notes/Model/notem.dart';

class createnotes extends StatefulWidget {
  const createnotes({Key? key}) : super(key: key);

  @override
  State<createnotes> createState() => _createnotesState();
}

class _createnotesState extends State<createnotes> {
  var title = TextEditingController();
  var description = TextEditingController();
  late Future<List<Notes>> notelist;
  DBHelper? dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create notes"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: title,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: "Enter Title",
                                hintStyle: TextStyle(fontSize: 19),
                                suffixStyle: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            controller: description,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Enter Description",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 190, left: 170),
                  child: Container(
                    width: 90,
                    child: ElevatedButton(
                      onPressed: () {
                        dbHelper!
                            .insert(Notes(
                                title: title.text.toString(),
                                description: description.text.toString()))
                            .then((value) {
                          Fluttertoast.showToast(
                              msg: "Data inserted Successfully",
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.cyan);
                        }).onError((error, stackTrace) {
                          print("data not inserted");
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => homescreen(),
                            ));
                      },
                      child: Text("Save"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
