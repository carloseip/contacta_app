import 'package:flutter/material.dart';
import 'package:qr_scanner_generator/models/tarjetapresentacion.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../blocs/card_list_bloc.dart';
//import '../widgets/card_chip.dart';
//import '../../models/card_model.dart';

class CardList extends StatelessWidget {

  final List<TarjetaPresentacion> tarjetas;

  const CardList({Key key, this.tarjetas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return FutureBuilder<List<TarjetaPresentacion>>(
      future: cardListBloc.getTarjetas(),
      builder: (context, snapshot) {
        return Column(
          children: <Widget>[
            !snapshot.hasData
                ? Container(
                    padding: EdgeInsets.only(top: 120.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Bienvenido...\nAcá aparecerán las tarjetas \nde tus contactos",
                          style: TextStyle(
                            color: Colors.purpleAccent,
                            fontSize: 25.0,
                          ),
                        )
                      ],
                    ),
                  )
                : SizedBox(
                    height: _screenSize.height * 0.8,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return TarjetaPresentacionModel(
                          cardModel: snapshot.data[index],
                        );
                      },
                      itemCount: snapshot.data.length,
                      itemWidth: _screenSize.width * 0.9,
                      itemHeight: _screenSize.height * 0.35,
                      layout: SwiperLayout.TINDER,
                      scrollDirection: Axis.vertical,
                    ))
          ],
        );
      },
    );
  }
}


class TarjetaPresentacionModel extends StatelessWidget {
  final TarjetaPresentacion cardModel;

  TarjetaPresentacionModel({this.cardModel});
  @override
  Widget build(BuildContext context) {

    final _cardLogo = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0, right: 35.0),
          child: Image(
            image: AssetImage('assets/visa_logo.png'),
            width: 78.0,
            height: 78.0,
          ),
        ),
      ],
    );

    final _cardUsuario = Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 27.0),
      child: Text(
        cardModel.usuario.toUpperCase(),
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );

    final _puesto = Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 27.0),
      child: Text(
        cardModel.cargo,
        style: TextStyle(color: Colors.white, fontSize: 16.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
      ),
    );

    final _especialidad = Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 27.0),
      child: Text(
        'Escecialidad: ${cardModel.especialidad}',
        style: TextStyle(color: Colors.white, fontSize: 14.0, fontStyle: FontStyle.italic),
      ),
    );

    final _telefono = Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 27.0),
      child: Text(
        '${cardModel.telefono}',
        style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );

    final _correo = Padding(
      padding: const EdgeInsets.only(top: 2.0, left: 27.0),
      child: Text(
        cardModel.correo,
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );

    final _direccion = Padding(
      padding: const EdgeInsets.only(top: 11.0, left: 120.0),
      child: Text(
        cardModel.direccion,
        style: TextStyle(color: Colors.white, fontSize: 14.0),
      ),
    );

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.black87,
        ),
        child: RotatedBox(
          quarterTurns: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _cardLogo,
              _cardUsuario,
              _puesto,
              _especialidad,
              _telefono,
              _correo,
              _direccion
            ],
          ),
        ));
  }

  // Widget _buildDots() {
  //   List<Widget> dotList = new List<Widget>();
  //   // var counter = 0;
  //   // for (var i = 0; i < 12; i++) {
  //   //   counter += 1;
  //   //   dotList.add(
  //   //     Padding(
  //   //       padding: const EdgeInsets.symmetric(horizontal: 2.0),
  //   //       child: Container(
  //   //         width: 6.0,
  //   //         height: 6.0,
  //   //         decoration: new BoxDecoration(
  //   //           color: Colors.white,
  //   //           shape: BoxShape.circle,
  //   //         ),
  //   //       ),
  //   //     ),
  //   //   );
  //   //   if (counter == 4) {
  //   //     counter = 0;
  //   //     dotList.add(SizedBox(width: 20.0));
  //   //   }
  //   // }
  //   dotList.add(_buildNumbers());
  //   return Row(children: dotList);
  // }

  // Widget _buildNumbers() {
  //   return Text(
  //     cardModel.telefono/*.substring(12)*/,
  //     style: TextStyle(color: Colors.white),
  //   );
  // }
}

// class CardFrontList extends StatelessWidget {
//   final CardResults cardModel;
//   CardFrontList({this.cardModel});

//   @override
//   Widget build(BuildContext context) {

//     final _cardLogo = Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(top: 5.0, right: 1.0),
//           child: Image(
//             image: AssetImage('assets/visa_logo.png'),
//             width: 170.0,
//             height: 120.0,
//           ),
//         ),
//       ],
//     );

    
/*
    final _cardLastNumber = Padding(
      padding: const EdgeInsets.only(top: 1.0, left: 55.0),
      child: Text(
        cardModel.cardPhoneNumber,
        //cardModel.cardNumber.substring(12),
        style: TextStyle(color: Colors.white, fontSize: 8.0),
      ),
    );*/

    /*final _cardValidThru = Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Válido',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                Text(
                  'hasta',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ],
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              '${cardModel.cardPuesto}',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            Text(
              '${cardModel.cardAddress.substring(100)}',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ],
        ));*/

        //_______________________

    //   final _cardOwner = Padding(
    //   padding: const EdgeInsets.only(top: 5.0, left: 20.0),
    //   child: Text(
    //     cardModel.cardHolderName,
    //     style: TextStyle(color: Colors.white, fontSize: 16.0),
    //   ),
    // );

    // final _cardPuesto = Padding(
    //   padding: const EdgeInsets.only(top: 4.0, left: 20.0),
    //   child: Text(
    //     cardModel.cardPuesto,
    //     style: TextStyle(color: Colors.white, fontSize: 16.0),
    //   ),
    // );

    // final _cardPhoneNumber = Padding(
    //   padding: const EdgeInsets.only(top: 2.0, left: 20.0),
    //   child: Text(
    //     cardModel.cardPhoneNumber,
    //     style: TextStyle(color: Colors.white, fontSize: 16.0),
    //   ),
    // );

    // final _cardAddress= Padding(
    //   padding: const EdgeInsets.only(top: 20.0, left: 20.0),
    //   child: Text(
    //     cardModel.cardAddress,
    //     style: TextStyle(color: Colors.white, fontSize: 16.0),
    //   ),
    // );

    
/*
    final _telefono = Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 50.0),
      child: Text(
        cardModel.cardPhoneNumber,
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );

    final _puesto = Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 50.0),
      child: Text(
        cardModel.cardType,
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );*/

  //   return Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(15.0),
  //         color: cardModel.cardColor,
  //       ),
  //       child: RotatedBox(
  //         quarterTurns: 0,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: <Widget>[
  //             _cardLogo,
  //             _cardOwner,
  //             _cardPuesto,              
  //             _cardPhoneNumber,
  //             _cardAddress,
  //           ],
  //         ),
  //       ));
  // }

  // Widget _buildDots() {
  //   List<Widget> dotList = new List<Widget>();
  //    var counter = 0;
  //    for (var i = 0; i < 12; i++) {
  //      counter += 1;
  //      dotList.add(
  //        Padding(
  //          padding: const EdgeInsets.symmetric(horizontal: 2.0),
  //          child: Container(
  //            width: 6.0,
  //            height: 6.0,
  //            decoration: new BoxDecoration(
  //              color: Colors.white,
  //              shape: BoxShape.circle,
  //            ),
  //          ),
  //        ),
  //      );
  //      if (counter == 2) {
  //        counter = 0;
  //        dotList.add(SizedBox(width: 20.0));
  //      }
  //    }
  //   dotList.add(_buildNumbers());
  //   return Row(children: dotList);
  // }

  // Widget _buildNumbers() {
  //   return Text(
  //     cardModel.cardPhoneNumber.substring(9),
  //     style: TextStyle(color: Colors.white),
  //   );
  // }
// }
