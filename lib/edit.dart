import 'package:flutter/material.dart';
import 'package:sql_data/main.dart';
import 'package:sql_data/view.dart';

class edit extends StatefulWidget {
Map l;
edit(this.l);

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      t1.text=widget.l['name'];
      t2.text=widget.l['contact'];

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("UPDATE"),),
      body: SingleChildScrollView(child:

        Column(children: [
          Card(color: Colors.grey,margin: EdgeInsets.all(10),child: TextField(controller: t1,decoration: InputDecoration(hintText: "Enter Name",labelText: "Enter name"),)),
          Card(color: Colors.grey,margin: EdgeInsets.all(10),child: TextField(controller: t2,decoration: InputDecoration(hintText: "Enter contact",labelText: "Enter contact"),)),
          ElevatedButton(onPressed: () {
            String name=t1.text;
            String contact = t2.text;
            if(name!=null)
            {
              String sql="update book set name='$name',contact = '$contact'where id = ${widget.l['id']}";
              Home.database!.rawUpdate(sql);
            }
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return view();
            },));
          }, child: Text("submit")),
        ],),),
    );
  }
}
