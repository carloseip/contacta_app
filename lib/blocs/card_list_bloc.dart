import 'dart:async';
import 'package:qr_scanner_generator/models/tarjetapresentacion.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/card_model.dart';
import 'dart:convert';
import '../helpers/card_colors.dart';
import 'package:http/http.dart' as http;

class CardListBloc{
  BehaviorSubject<List<CardResults>> _cardsCollection = BehaviorSubject<List<CardResults>>();

  List<CardResults> _cardResults;

  //Retrieve data from Stream
  Stream<List<CardResults>> get cardList => _cardsCollection.stream;

  void initialData() async {
    var initialData = await rootBundle.loadString('data/initialData.json');
    var decodedJson = jsonDecode(initialData);
    _cardResults = CardModel.fromJson(decodedJson).results;
    for (var i = 0; i < _cardResults.length; i++) {
      _cardResults[i].cardColor = CardColor.baseColors[i];
    }
    _cardsCollection.sink.add(_cardResults);
  }

  Future<List<TarjetaPresentacion>> getTarjetas() async{
    final response = await http.get("https://contacta.azurewebsites.net/api/tarjetaspresentacion");
    if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    if (mapResponse["mensaje"] == "correcto") {
      final tasks = mapResponse["value"].cast<Map<String, dynamic>>();
      return tasks.map<TarjetaPresentacion>((json){
        return TarjetaPresentacion.fromJson(json);
      }).toList();
    } else {
      return [];
    }
  } else {
    throw Exception('Error al cargar tarjetas');
  }
  }

  CardListBloc(){
    initialData();
  }

  void addCardToList(CardResults newCard){
    _cardResults.add(newCard);
    _cardsCollection.sink.add(_cardResults);
  }

  void dispose() {
    _cardsCollection.close();
  }
}

final cardListBloc = CardListBloc();