import 'package:flutter/material.dart';
import 'package:my_notes/Activitys/createnotes.dart';
import 'package:my_notes/Database/dbhelper.dart';
import 'package:my_notes/Model/notem.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  // DBhelper? meaning null  safety hota hai to

  DBHelper? dbHelper;
  late Future<List<Notes>> notelist;
  var title = TextEditingController();
  var description = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    loaddata();
  }

  loaddata() async {
    notelist = dbHelper!.getCartListWithUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My notes"),
        actions: [
          IconButton(onPressed: (){

          }, icon:Icon(Icons.add)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 10),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: notelist,
                  builder: (context, AsyncSnapshot<List<Notes>> snapshot) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => createnotes(),
                                  ));
                            },
                            child: Card(
                              child: ListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text(snapshot.data![index].title),
                                subtitle:
                                    Text(snapshot.data![index].description),
                              ),
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => createnotes(),
                ));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
