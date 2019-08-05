import 'package:flutter/material.dart';
import '../../helpers/card_colors.dart';
//import '../widgets/card_chip.dart';
import '../../blocs/card_bloc.dart';
import '../../blocs/bloc_provider.dart';

class CardFront extends StatelessWidget{
  final int rotatedTurnsValue;
  CardFront({this.rotatedTurnsValue});

  @override
  Widget build(BuildContext context) {
    final CardBloc bloc = BlocProvider.of<CardBloc>(context);

    
/*
    final _cardLastNumber = Padding(
        padding: const EdgeInsets.only(top: 1.0, left: 55.0),
        child: StreamBuilder<String>(
          stream: bloc.cardPhoneNumber,
          builder: (context, snapshot) {
            return Text(
              snapshot.hasData && snapshot.data.length >= 15
                  ? snapshot.data
                      .replaceAll(RegExp(r''), '')
                      .substring(9)
                  : '000',
              style: TextStyle(color: Colors.white, fontSize: 8.0),
            );
          },
        ));*/
/*
    final _cardValidThru = Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'Válido',
                style: TextStyle(color: Colors.white, fontSize: 8.0),
              ),
              Text(
                'hasta',
                style: TextStyle(color: Colors.white, fontSize: 8.0),
              )
            ],
          ),
          SizedBox(
            width: 5.0,
          ),
          StreamBuilder(
            stream: bloc.cardPuesto,
            builder: (context, snapshot) {
              return Text(
                snapshot.hasData ? snapshot.data : '00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              );
            },
          ),
          StreamBuilder<String>(
              stream: bloc.cardAddress,
              builder: (context, snapshot) {
                return Text(
                  snapshot.hasData && snapshot.data.length > 2
                      ? '/${snapshot.data.substring(2)}'
                      : '/00',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                );
              })
        ],
      ),
    );*/



    final _cardLogo = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5.0, right: 5.0),
          child: Image(
            image: AssetImage('assets/visa_logo.png'),
            width: 170.0,
            height: 120.0,
          ),
        ),
        /*Padding(
          padding: const EdgeInsets.only(right: 45.0),
          child: StreamBuilder(
              stream: bloc.cardType,
              builder: (context, snapshot) {
                return Text(
                  snapshot.hasData ? snapshot.data : '',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                );
              }),
        ),*/
      ],
    );

  final _cardOwner = Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 20.0),
      child: StreamBuilder(
        stream: bloc.cardHolderName,
        builder: (context, snapshot) => Text(
              snapshot?.data ?? 'DUEÑO DE LA TARJETA',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
      ),
    );

    
    //________________
    final _cardPuesto= Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 20.0),
      child: StreamBuilder(        
      stream: bloc.cardPuesto,
        builder: (context, snapshot) => Text(
              snapshot?.data ?? 'Puesto',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
      ),
    );

    final _cardPhoneNumber = Padding(
      padding: const EdgeInsets.only(top: 2.0, right: 183.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          StreamBuilder<String>(
            stream: bloc.cardPhoneNumber,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? _formatCardPhoneNumber(snapshot.data)
                  : _formatCardPhoneNumber('000000000');
            },
          ),
        ],
      ),
    );
    final _cardAddress= Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
      child: StreamBuilder(        
      stream: bloc.cardAddress,
        builder: (context, snapshot) => Text(
              snapshot?.data ?? 'Dirección',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
      ),
    );
//_____________________________________________

  

    return StreamBuilder<int>(
        stream: bloc.cardColorIndexSelected,
        initialData: 0,
        builder: (context, snapshopt) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: CardColor.baseColors[snapshopt.data]),
            child: RotatedBox(
              quarterTurns: rotatedTurnsValue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _cardLogo,
                  _cardOwner,
                  _cardPuesto,
                  _cardPhoneNumber,
                  _cardAddress,                  
                ],
              ),
            ),
          );
        });
  }

  Widget _formatCardPhoneNumber(String cardPhoneNumber) {
    cardPhoneNumber = cardPhoneNumber.replaceAll(RegExp(r''), '');
    List<Widget> numberList = new List<Widget>();
    var counter = 0;
    for (var i = 0; i < cardPhoneNumber.length; i++) {
      counter += 1;
      numberList.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.5),
          child: Text(
            cardPhoneNumber[i],
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      );
      if (counter == 3) {
        counter = 0;
        numberList.add(SizedBox(width: 5.0));
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numberList,
    );
  }

}
