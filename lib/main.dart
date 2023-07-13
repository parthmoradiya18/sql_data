import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sql_data/view.dart';

void main()
{
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: Home(),));
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static Database ?database;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  initState() {
    super.initState();
    // Add listeners to this class
    get_database();
  }

  get_database()
  async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Ram.db');

    Home.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE book (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,contact TEXT)');
        });

  }

  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Book"),),
      body: SingleChildScrollView(
        child: Column(children: [

          Card(color: Colors.grey,margin: EdgeInsets.all(10),child: TextField(controller: t1,decoration: InputDecoration(hintText: "Enter Name",labelText: "Enter name"),)),
          Card(color: Colors.grey,margin: EdgeInsets.all(10),child: TextField(controller: t2,decoration: InputDecoration(hintText: "Enter contact",labelText: "Enter contact"),)),
          ElevatedButton(onPressed: () {
            String name=t1.text;
            String contact=t2.text;
            String sql="insert into book values(null,'$name','$contact')";
            Home.database!.rawInsert(sql);
            print(sql);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return view();
            },));
            }, child: Text("submit")),
          ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return view();
              },));
          }, child: Text("view")),

        ],),
      ),

    );
  }
}
