class Acceso {
  final String correo;
  final String contrasenia;
 
  Acceso({this.correo, this.contrasenia});
 
  factory Acceso.fromJson(Map<String, dynamic> json) {
    return Acceso(
      correo: json['correo'],
      contrasenia: json['contrasenia']
    );
  }
 
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["correo"] = correo;
    map["contrasenia"] = contrasenia; 
    return map;
  }
}