import 'dart:convert';
import 'configs/Url.dart';
import 'package:http/http.dart' as http;

class Elements {

  //Variables
  String _nomPlat;
  double _prixplat;
  String _nomComplement;
  double _prixComplement;
  String _nomBoisson;
  double _prixBoisson;
  String _numeroFacture;
  late Url _url = Url();

  //Constructeur
  Elements(this._nomPlat, this._prixplat,this._nomComplement, this._prixComplement, this._nomBoisson,
      this._prixBoisson, this._numeroFacture);

  //Fonction pour enregistrer une commande dans la base de données
  Future<http.Response> Enregistrer(String nomPlat, double prixPlat,String nomComplement, double prixComplement, String nomBoisson, double prixBoisson, String numeroFacture) async {
    _url.GetUrl();
    _url.GetPortCommande();
    http.Response response;
    var uri = Uri.parse("${_url.url}${_url.portServiceCommande}/API/Fournisseurs/inserer");
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map data = {
      'nomPlat':nomPlat,
      'prixPlat':prixPlat,
      'nomComplement':nomComplement,
      'prixComplement':prixComplement,
      'nomBoisson':nomBoisson,
      'prixBoisson':prixBoisson,
      'numeroFacture':numeroFacture,
    };
    var body = json.encode(data);
    response = await http.post(uri,headers: headers, body: body);
    return response;
  }

  //Récupération des données depuis un fichier json
  Elements.fromJson(Map<String, dynamic> json)
      : _nomPlat = json['nomPlat'],
        _prixplat = json['prixPlat'],
        _nomComplement = json['nomComplement'],
        _prixComplement = json['prixComplement'],
        _nomBoisson = json['nomBoisson'],
        _prixBoisson = json['prixBoisson'],
        _numeroFacture = json['numeroFacture'];

  //Convertion en json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> element = <String, dynamic>{};
    element["nomPlat"] = _nomPlat;
    element["prixPlat"] = _prixplat;
    element["nomComplement"] = _nomComplement;
    element["prixComplement"] = _prixComplement;
    element["nomBoisson"] = _nomBoisson;
    element["prixBoisson"] = _prixBoisson;
    element["numeroFacture"] = _numeroFacture;
    return element;
  }

  //Getters & Setters
  Url get url => _url;

  set url(Url value) {
    _url = value;
  }

  String get numeroFacture => _numeroFacture;

  set numeroFacture(String value) {
    _numeroFacture = value;
  }

  double get prixBoisson => _prixBoisson;

  set prixBoisson(double value) {
    _prixBoisson = value;
  }

  String get nomBoisson => _nomBoisson;

  set nomBoisson(String value) {
    _nomBoisson = value;
  }

  double get prixplat => _prixplat;

  set prixplat(double value) {
    _prixplat = value;
  }

  String get nomPlat => _nomPlat;

  set nomPlat(String value) {
    _nomPlat = value;
  }

  double get prixComplement => _prixComplement;

  set prixComplement(double value) {
    _prixComplement = value;
  }

  String get nomComplement => _nomComplement;

  set nomComplement(String value) {
    _nomComplement = value;
  }
}