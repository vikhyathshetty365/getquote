import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
void main()
{
  runApp(myapp());
}

class myapp extends StatelessWidget
{
@override
  Widget build(BuildContext context)
{
  return MaterialApp
    (
    home: homepage(),
  );

  }



}
class homepage  extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      appBar: AppBar(title: Text("quote scrapper"),
      backgroundColor: Colors.blue,
      ),
      body: mainscreen(),
    );
  }
}
class mainscreen extends StatefulWidget
{
State<StatefulWidget> createState()
{
  return _mainscreen();
}
}

class _mainscreen extends State<mainscreen>
{

  String _Query;
  int count=0;
var jsonresponse;

int length;
  Future<void>getquote(query) async
  {
String url="http://10.0.2.2:5000/vi/scr/?query=$query";
http.Response response= await http.get(url);
if(response.statusCode==200)
  {
    setState(() {
      jsonresponse=convert.jsonDecode(response.body);
      count=jsonresponse.length;
    });


  }
else
{
  print("error is:${response.statusCode}");
}




  }








   @override

  Widget build(BuildContext context)
   {

     return Center
       (
     child: SingleChildScrollView
       (
       child: Column
         (

         children: <Widget>
         [
           new Container
             (
             height: count==0?50:500,

             child: count==0?Text("loading.."):ListView.builder(



                 itemBuilder: (context,index)
              {
                   return new Container
                      (
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        border: Border.all(
                          color: Colors.black,
                          width: 8,



                        ),


                      ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>
                      [
                        Text(
                          jsonresponse[index]["quote"],
                          style: TextStyle(color: Colors.white),




                        ),

                        Text(
                          jsonresponse[index]["author"],
                          style: TextStyle(color: Colors.white,fontSize: 18),
                        )



                      ],


                    ),

                    );


              },
               itemCount:count,


             ),



           ),
           Container(
             padding: EdgeInsets.symmetric(horizontal: 20),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 TextField(
                   style: TextStyle(color: Colors.white),
                   decoration: InputDecoration(
                       hintText: "search quote here",
                       contentPadding:
                       EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                       enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.white)),
                       focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.white)),
                       border: OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.white))),
                   onChanged: (value) {
                     _Query = value;
                     print(value);
                   },
                 ),
                 ButtonTheme(
                   minWidth: 100,
                   child: RaisedButton(
                     child: Text(
                       "get quotes",
                       style: TextStyle(color: Colors.white),
                     ),
                     color: Colors.black87,
                     onPressed: () {
                       getquote(_Query);
                       setState(() {
                         count = 0;
                       });
                     },
                   ),
                 )
               ],
             ),
           ),






         ],

       ),
     ),

     );
}
}