import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_scanner_generator/ui/app.dart';
import 'package:qr_scanner_generator/ui/card_type.dart';
import 'package:qr_scanner_generator/ui/navigation.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";
  String a = "";

  var prod;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Págalo Toditito'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.redAccent,
                    textColor: Colors.white,
                    splashColor: Colors.white,
                    onPressed: scan,
                    child: const Text('ESCANEA')),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: _widgetUno(),
              ),
            ],
          ),
        ));
  }

  _widgetUno() {
    try {
      if (barcode == null) {
        return Text('');
      } else {
        return new CupertinoAlertDialog(
          actions: <Widget>[
            new Container(
              color: Colors.red[200],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<Producto>(
                  future: _getProducto(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                        "Producto: ${snapshot.data.nombre}\n" +
                                            "Precio: S/.${snapshot.data.precio}.00\n" +
                                            "Fecha de \nVencimiento: ${snapshot.data.fechaCaducidad}",
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            height: 1.0)),
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Nuevo()));
                                    },
                                    child: new Text(
                                      "Añadir al Carrito",
                                      style: new TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: Colors.brown,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Image.network(
                                'https://image.flaticon.com/icons/png/512/43/43777.png',
                                width: 55,
                                height: 55,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (!snapshot.hasData) {
                      return Text("No hay productos");
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Text('Escanee sus productos');
                  },
                ),
              ),
            ),
          ],
        );
      }
    } on PlatformException catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  Future<Producto> _getProducto() async {
    var data = await http.get(
        "https://pagalotoditito.mybluemix.net/prodController/prodBuscar/$barcode");
    if ((data.statusCode == 200) && (data.body != "")) {
      var datos = json.decode(data.body);
      var prod = Producto.fromJson(datos);

      setState(() => this.prod = prod);
      return prod;
    } else {
      return null;
    }
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();

      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}

class Producto {
  final int idProducto;
  final String nombre;
  final int precio;
  final int stock;
  var fechaIngreso;
  final String fechaCaducidad;
  final bool estado;
  final Categoria categoria;
  final Proveedor proveedor;

  Producto(
      {this.idProducto,
      this.nombre,
      this.precio,
      this.stock,
      this.fechaIngreso,
      this.fechaCaducidad,
      this.estado,
      this.categoria,
      this.proveedor});

  factory Producto.fromJson(Map<String, dynamic> pjson) {
    return Producto(
        idProducto: pjson['idProducto'],
        nombre: pjson['nombre'],
        precio: pjson['precio'],
        stock: pjson['stock'],
        fechaIngreso: pjson['fechaIngreso'],
        fechaCaducidad: pjson['fechaCaducidad'],
        estado: pjson['estado'],
        categoria: Categoria.fromJson(pjson['categoria']),
        proveedor: Proveedor.fromJson(pjson['proveedor']));
  }
}

class Proveedor {
  int idProveedor;
  String nombre;

  Proveedor({this.idProveedor, this.nombre});

  factory Proveedor.fromJson(Map<String, dynamic> pjson) {
    return Proveedor(
        idProveedor: pjson['idProveedor'], nombre: pjson['nombre']);
  }
}

class Categoria {
  var idCategoria;
  String descripcion;

  Categoria({this.idCategoria, this.descripcion});

  factory Categoria.fromJson(Map<String, dynamic> pjson) {
    return Categoria(
        idCategoria: pjson['idCategoria'], descripcion: pjson['descripcion']);
  }
}

class Nuevo extends StatefulWidget {
  @override
  _NuevoState createState() => _NuevoState();
}

class _NuevoState extends State<Nuevo> {
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
            appBar: AppBar(
              title: Image.asset('assets/logo_pay.png', height: 50.0),
            ),
            body: Center(child: Text('Preguntas')),
          );
        },
      ), // ... to here.
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pagalo Toditito',
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        body: new Center(child: new Text("Hola")),
      ),
    );
  }
}
