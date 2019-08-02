import 'dart:async';

class Validators{
  final validateCardHolderName = StreamTransformer<String, String>.fromHandlers(
      handleData: (cardHolderName, sink) {
    RegExp('[a-zA-Z]').hasMatch(cardHolderName)
        ? sink.add(cardHolderName)
        : sink.addError('Ingrese un nombre Válido');
  });

  final validateCardNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (cardNumber, sink) {
    //1st Regular Expression to Validate Credit Card Number
    RegExp(r'^(?:4[0-9]{12}(?:[0-9]{3})?|[25][1-7][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$')
            //2nd Regular Expression to remove white spaces
            .hasMatch(cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), ''))
        ? sink.add(cardNumber)
        : sink.addError('Ingrese un número de tarjeta válido');
  });

  final validateCardMonth = StreamTransformer<String, String>.fromHandlers(
      handleData: (cardMonth, sink) {
    if (cardMonth.isNotEmpty &&
        int.parse(cardMonth) > 0 &&
        int.parse(cardMonth) < 13) {
      sink.add(cardMonth);
    } else {
      sink.addError('Mes no válido');
    }
  });

  final validateCardYear = StreamTransformer<String, String>.fromHandlers(
      handleData: (cardYear, sink) {
    if (cardYear.isNotEmpty &&
        int.parse(cardYear) > 2000 &&
        int.parse(cardYear) < 2028) {
      sink.add(cardYear);
    } else {
      sink.addError('Año no válido');
    }
  });

  final validateCardVerificationValue =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (cardCvv, sink) {
    if (cardCvv.length > 2) {
      sink.add(cardCvv);
    } else {
      sink.addError('CVV No válido');
    }
  });


}