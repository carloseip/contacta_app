import 'package:flutter/material.dart';
import 'package:qr_scanner_generator/ui/widgets/card_list.dart';

import 'card_type.dart';
//import '../ui/card_type.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/logo_pay.png', height: 50.0),
        // leading: IconButton(
        //   icon: Icon(Icons.menu,
        //   color: Colors.black),
        //   onPressed: (){},
        // ),
        // actions: <Widget>[
        //   // IconButton(
        //   //   icon: Icon(Icons.add,
        //   //   color: Colors.black),
        //   //   onPressed: (){
        //   //     Navigator.push(context, MaterialPageRoute(builder: (context) => CardType()));
        //   //   },
        //   // )
        // ]
      ),
      body: CardList(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.amberAccent,
              onPressed: () {
                Navigator.of(context).push(
                  new MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return new Scaffold(
                        body: CardType(),
                      );
                    },
                  ),
                );
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
    );
    //return  CardList();
  }
  
    void _metodo() {

  }
}