import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/card_color_model.dart';
import '../helpers/card_colors.dart';
import '../models/card_model.dart';
import './validators.dart';
import '../blocs/bloc_provider.dart';
import '../blocs/card_list_bloc.dart';

class CardBloc with Validators implements BlocBase {
  //DATOS QUE APARECERAN EN LA TARJETA --USUARIO PUEDE EDITAR
  BehaviorSubject<String> _cardHolderName = BehaviorSubject<String>();
  BehaviorSubject<String> _cardPhoneNumber = BehaviorSubject<String>();
  BehaviorSubject<String> _cardPuesto = BehaviorSubject<String>();
  BehaviorSubject<String> _cardAddress = BehaviorSubject<String>();
  //BehaviorSubject<String> _cardCvv = BehaviorSubject<String>();
  BehaviorSubject<String> _cardType = BehaviorSubject<String>();
  BehaviorSubject<int> _cardColorIndexSelected = BehaviorSubject<int>(seedValue: 0);

  final _cardsColors =  BehaviorSubject<List<CardColorModel>>();

  //Add data stream
  Function(String) get changeCardHolderName => _cardHolderName.sink.add;
  Function(String) get changeCardPhoneNumber => _cardPhoneNumber.sink.add;
  Function(String) get changeCardPuesto => _cardPuesto .sink.add;
  Function(String) get changeCardAddress => _cardAddress.sink.add;
  //Function(String) get changeCardCvv => _cardCvv.sink.add;
  Function(String) get selectCardType => _cardType.sink.add;

  //Retrieve data from stream
  Stream<String> get cardHolderName => _cardHolderName.stream.transform(validateCardHolderName);
  Stream<String> get cardPhoneNumber => _cardPhoneNumber.stream.transform(validateCardPhoneNumber);
  Stream<String> get cardPuesto => _cardPuesto ;//.stream.transform(validateCardMonth);
  Stream<String> get cardAddress => _cardAddress;//.stream.transform(validateCardYear);
  //Stream<String> get cardCvv => _cardCvv;//.stream.transform(validateCardVerificationValue);
  Stream<String> get cardType => _cardType.stream;
  Stream<int> get cardColorIndexSelected => _cardColorIndexSelected.stream;
  Stream<List<CardColorModel>> get cardColorsList => _cardsColors.stream;
  Stream<bool> get savecardValid => Observable.combineLatest4(cardHolderName,
      cardPhoneNumber, cardPuesto, cardAddress, (ch, cn, cm, cy) => true);

  void saveCard() {
    final newCard = CardResults(
        cardHolderName: _cardHolderName.value,
        cardPhoneNumber: _cardPhoneNumber.value.replaceAll(RegExp(r''), ''),
        cardPuesto: _cardPuesto.value,
        cardAddress: _cardAddress.value,
        //cardCvv: _cardCvv.value,
        cardColor: CardColor.baseColors[_cardColorIndexSelected.value],
        cardType: _cardType.value
        );
    cardListBloc.addCardToList(newCard);
  }

  void selectCardColor(int colorIndex){
    CardColor.cardColors.forEach((element) => element.isSelected = false);
    CardColor.cardColors[colorIndex].isSelected = true;
    _cardsColors.sink.add(CardColor.cardColors);
    _cardColorIndexSelected.sink.add(colorIndex);
  }

  void dispose(){
    _cardHolderName.close();
    _cardPhoneNumber.close();
    _cardPuesto.close();
    _cardAddress.close();
    //_cardCvv.close();
    _cardsColors.close();
    _cardColorIndexSelected.close();
    _cardType.close();
  }

}