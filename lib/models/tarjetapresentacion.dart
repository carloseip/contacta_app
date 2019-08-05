import 'package:flutter/material.dart';

class TarjetaModel{
  List<TarjetaPresentacion> results;

  TarjetaModel({this.results});

  TarjetaModel.fromJson(Map<String, dynamic> json) {
    if (json['value'] != null) {
      results = new List<TarjetaPresentacion>();
      json['value'].forEach((v) {
        results.add(new TarjetaPresentacion.fromJson(v));
      });
    }
  }
}

class TarjetaPresentacion{
  int idTarjeta;
  String usuario;
  String cargo;
  String especialidad;
  String telefono;
  String correo;
  String direccion;
  Color tarjetaColor;

  TarjetaPresentacion(
      {this.idTarjeta,
      this.usuario,
      this.cargo,
      this.especialidad,
      this.telefono,
      this.correo,
      this.direccion,
      this.tarjetaColor});

  factory TarjetaPresentacion.fromJson(Map<String, dynamic> json) {
    return TarjetaPresentacion(
    idTarjeta : json['idtarjeta'],
    usuario : json['usuario'],
    cargo : json['cargo'],
    especialidad : json['especialidad'],
    telefono : json['telefono'],
    correo : json['correo'],
    direccion : json['direccion'],
    tarjetaColor : json['imagen']
    );
  }
}