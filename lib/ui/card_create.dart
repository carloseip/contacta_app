import 'package:flutter/material.dart';
import '../ui/widgets/my_appbar.dart';
import '../ui/widgets/flip_card.dart';
import '../ui/widgets/card_front.dart';
import '../ui/widgets/card_back.dart';
import '../helpers/card_colors.dart';
import '../helpers/formatters.dart';
import '../blocs/card_bloc.dart';
import '../blocs/bloc_provider.dart';
import '../models/card_color_model.dart';
import '../ui/card_wallet.dart';

class CardCreate extends StatefulWidget{
  @override
  _CardCreate createState() => _CardCreate();
}

class _CardCreate extends State<CardCreate>{
  final GlobalKey<FlipCardState> animatedStateKey = GlobalKey<FlipCardState>();

  FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeListener);
    super.dispose();
  }

  Future<Null> _focusNodeListener() async {
    animatedStateKey.currentState.toggleCard();
  }

  @override
  Widget build(BuildContext context) {
    final CardBloc bloc = BlocProvider.of<CardBloc>(context);

    final _creditCard = Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Card(
        color: Colors.grey[100],
        elevation: 0.0,
        margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
        child: FlipCard(
          key: animatedStateKey,
          front: CardFront(rotatedTurnsValue: 0),
          back: CardBack(),
        ),
      ),
    );

    final _cardHolderName = StreamBuilder(
        stream: bloc.cardHolderName,
        builder: (context, snapshot) {
          return TextField(
            textCapitalization: TextCapitalization.characters,
            onChanged: bloc.changeCardHolderName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Dueño de tarjeta',
              errorText: snapshot.error,
            ),
          );
        });   

    final _cardPuesto = Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: StreamBuilder(
        stream: bloc.cardPuesto,
        builder: (context, snapshot) {
          return Container(
          width: 330.0,
          child: TextField(
            onChanged: bloc.changeCardPuesto,
            keyboardType: TextInputType.text,
            maxLength: 50,
            maxLengthEnforced: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Puesto',
              counterText: '',
              errorText: snapshot.error,
            ),
          ),
        );
      }),
    );

    final _cardPhoneNumber = Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: StreamBuilder(
          stream: bloc.cardPhoneNumber,
          builder: (context, snapshot) {
            return TextField(
              onChanged: bloc.changeCardPhoneNumber,
              keyboardType: TextInputType.number,
              maxLength: 9,
              maxLengthEnforced: true,
              inputFormatters: [
                MaskedTextInputFormatter(
                  mask: 'xxx xxx xxx',
                  separator: '',
                ),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                hintText: 'Número de Telefono',
                //counterText: '',
                errorText: snapshot.error,
              ),
            );
          }),
    );

    final _cardAddress = Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: StreamBuilder(
        stream: bloc.cardAddress,
        builder: (context, snapshot) {
          return Container(
          width: 330.0,
          child: TextField(
            onChanged: bloc.changeCardAddress,
            keyboardType: TextInputType.text,
            maxLength: 100,
            maxLengthEnforced: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Address',
              counterText: '',
              errorText: snapshot.error,
            ),
          ),
        );
      }),
    );

/*
    final _cardVerificationValue = StreamBuilder(
        stream: bloc.cardCvv,
        builder: (context, snapshot) {
          return Container(
            width: 70.0,
            child: TextField(
              focusNode: _focusNode,
              onChanged: bloc.changeCardCvv,
              keyboardType: TextInputType.number,
              maxLength: 3,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  counterText: '',
                  hintText: 'CVV',
                  errorText: snapshot.error),
            ),
          );
        });
*/
    final _saveCard = StreamBuilder(
      stream: bloc.savecardValid,
      builder: (context, snapshot) {
        return Container(
          width: MediaQuery.of(context).size.width - 40,
          child: RaisedButton(
            child: Text(
              'Guardar Tarjeta',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.lightBlue,
            onPressed: snapshot.hasData
                ? () {
                    var blocProviderCardWallet = BlocProvider(
                      bloc: bloc,
                      child: CardWallet(),
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => blocProviderCardWallet));
                  }
                : null,
          ),
        );
      },
    );

    return new Scaffold(
        appBar: MyAppBar(
          appBarTitle: 'Crear Tarjeta',
          leadingIcon: Icons.arrow_back,
          context: context,
        ),
        backgroundColor: Colors.grey[100],
        body: ListView(
          itemExtent: 750.0,
          padding: EdgeInsets.only(top:10.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: _creditCard,
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 2.0),
                        _cardHolderName,
                        _cardPuesto,
                        _cardPhoneNumber,
                        _cardAddress,
                        
                        SizedBox(height: 20.0),
                        cardColors(bloc),
                        SizedBox(height: 50.0),
                        _saveCard,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget cardColors(CardBloc bloc) {
    final dotSize = (MediaQuery.of(context).size.width - 120) / CardColor.baseColors.length;

    List<Widget> dotList = new List<Widget>();

    for (var i = 0; i < CardColor.baseColors.length; i++) {
      dotList.add(
        StreamBuilder<List<CardColorModel>>(
          stream: bloc.cardColorsList,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
              child: GestureDetector(
                onTap: () => bloc.selectCardColor(i),
                child: Container(
                  child: snapshot.hasData
                      ? snapshot.data[i].isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20.0,
                            )
                          : Container()
                      : Container(),
                  width: dotSize,
                  height: dotSize,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: CardColor.baseColors[i],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: dotList,
    );
}

}
