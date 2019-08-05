import 'package:flutter/material.dart';

class CardModel{
  List<CardResults> results;

  CardModel({this.results});

  CardModel.fromJson(Map<String, dynamic> json) {
    if (json['cardResults'] != null) {
      results = new List<CardResults>();
      json['cardResults'].forEach((v) {
        results.add(new CardResults.fromJson(v));
      });
    }
  }
}

class CardResults{
  String cardHolderName;
  String cardPhoneNumber;
  String cardPuesto;
  String cardAddress;
  //String cardCvv;
  Color cardColor;
  String cardType;

  CardResults(
      {this.cardHolderName,
      this.cardPhoneNumber,
      this.cardPuesto,
      this.cardAddress,
      //this.cardCvv,
      this.cardColor,
      this.cardType});

  CardResults.fromJson(Map<String, dynamic> json) {
    cardHolderName = json['cardHolderName'];
    cardPhoneNumber = json['cardPhoneNumber'];
    cardPuesto = json['cardPuesto'];
    cardAddress = json['cardAddress'];
    //cardCvv = json['cardCvv']; //Card Verification Number
    cardColor = json['cardColor'];
    cardType = json['cardType'];
  }
}