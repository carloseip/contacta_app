import 'package:flare_flutter/flare_actor.dart';
import 'package:qr_scanner_generator/scan.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:qr_scanner_generator/ui/app.dart';
import '../ui/card_type.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacta',
      theme: new ThemeData(
        // Add the 3 lines from here...
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  Widget imageCarousel = Container(
    height: 200.0,
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/01.jpg'),
          AssetImage('assets/02.jpg'),
          AssetImage('assets/03.jpg'),
        ],
        autoplay: true,
        //animationCurve: Curves.fastOutSlowIn,
        //animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        dotColor: Colors.amber,
        indicatorBgPadding: 2.0,
      ),
    ),
  );

  Widget _widgetDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 24.0),
        // Important: Remove any padding from the ListView.
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'Carlos Inga',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            accountEmail: Text(
              'DNI: 72103514',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black,
              child: Image.asset('assets/usuario.png'),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/pol-background.jpg'))),
          ),
          InkWell(
            onTap: () {
              build(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
            child: ListTile(
              leading: Icon(Icons.star, color: Colors.redAccent),
              title: Text(
                'Inicio',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ),
          Divider(
            color: Colors.redAccent,
          ),
          InkWell(
            onTap: () {
              bottomTarjetas();
            },
            child: ListTile(
              leading: Icon(Icons.group, color: Colors.redAccent),
              title: Text(
                'Tarjetas',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ),
          Divider(
            color: Colors.redAccent,
          ),
          InkWell(
            onTap: () {
              _bottomRespuestas();
            },
            child: ListTile(
              leading: Icon(Icons.shopping_cart, color: Colors.redAccent),
              title: Text(
                'Compras',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ),
          Divider(
            color: Colors.redAccent,
          ),
          InkWell(
            onTap: () {
              _bottomPreguntas();
            },
            child: ListTile(
              leading: Icon(Icons.help_outline, color: Colors.redAccent),
              title: Text(
                'Acerca de',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ),
          Divider(
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _widgetDrawer(),
      appBar: AppBar(
        title: Image.asset('assets/logo_pay.png', height: 50.0),
        /*actions: <Widget>[
          // Add 3 lines from here...
          new IconButton(icon: const Icon(Icons.list)),
        ],*/
      ),
      body: ListView(
        children: <Widget>[
          imageCarousel,
          Padding(
            padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 20.0),
            child: RaisedButton(
                color: Colors.redAccent,
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScanScreen()),
                  );
                },
                child: const Text('Escanea tus Productos')),
          ),
          Container(
            height: 500,
            child: FlareActor('assets/flutter_developer.flr',
            animation: "idle",)
          )
        ],
      ),
    );
  }

  void bottomTarjetas() {
    Navigator.pop(context);
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new Scaffold(
            drawer: _widgetDrawer(),
            appBar: new AppBar(
              title: const Text('Tarjetas'),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.search), onPressed: null)
              ],
            ),
            body: App(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.amberAccent,
              onPressed: _metodo,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          );
        },
      ), // ... to here.
    );
  }

  void _metodo() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new Scaffold(
            body: CardType(),
          );
        },
      ),
    );
  }


  void _bottomRespuestas() {
    Navigator.pop(context);
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new Scaffold(
            drawer: _widgetDrawer(),
            appBar: new AppBar(
              title: const Text('Compras'),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.search), onPressed: null)
              ],
            ),
            body: Nuevo(),
          );
        },
      ),
    );
  }

  void _bottomPreguntas() {
    Navigator.pop(context);
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new Scaffold(
            drawer: _widgetDrawer(),
            appBar: new AppBar(
              title: const Text('Preguntas'),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.search), onPressed: null)
              ],
            ),
            body: Center(child: Text('Preguntas')),
          );
        },
      ), // ... to here.
    );
  }

}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
