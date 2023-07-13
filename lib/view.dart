import 'package:flutter/material.dart';
import 'package:sql_data/edit.dart';
import 'package:sql_data/main.dart';

class view extends StatefulWidget {
  const view({Key? key}) : super(key: key);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  List<Map> l = [];
  List<Map> l1 = [];

  bool t = false;
  bool search =false;

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    get_select();
  }

  get_select() async {
    String sql = "select * from book";
    l = await Home.database!.rawQuery(sql);
    l1=l;
    t = true;
    search=true;
    setState(() {

    });
  //  print(sql);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:(search)?TextField(onChanged: (value) {
        l=l1.where((element) => (element.toString()).contains(value)).toList();
        setState(() {

        });
      },
        autofocus: true,cursorColor: Colors.white,): Text("view"),
      actions: [
        IconButton(onPressed: () {
          search=!search;

          setState(() {

          });
        }, icon: (search)?Icon(Icons.close):Icon(Icons.search)),
      ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Home();
          },));
        },
        child: Icon(Icons.home, color: Colors.white, size: 29,),
        backgroundColor: Colors.black,
        tooltip: 'Home',
        elevation: 5,
        splashColor: Colors.grey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: (t) ? ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
        return Card(color: Colors.grey,margin: EdgeInsets.all(10),
          child:

          ListTile(trailing: Wrap(children: [

            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return edit(l[index]);
              }));


            }, icon: Icon(Icons.edit)),
            IconButton(onPressed: () {
              String sqy ="delete from book WHERE id=${l[index]['id']}";
              Home.database!.rawDelete(sqy);
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return view();
              }));

            }, icon: Icon(Icons.delete))
          ],),

            title: Text("${l[index]['name']}"),
            subtitle: Text("${l[index]['contact']}"),
          ),);
      },
      )
          : Text("Load DATA"),
    );
  }
}
