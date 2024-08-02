import 'dart:convert';
import 'configs/Url.dart';
import 'package:http/http.dart' as http;

class Aliments{

  //Variables
  String _nom;
  int _quantite;
  double _poids;
  late Url _url = Url();

  Aliments(this._nom, this._quantite, this._poids);

  //Fonction pour enregistrer une commande dans la base de données
  Future<http.Response> Enregistrer(String nom, int quantite, double poids) async {
    _url.GetUrl();
    _url.GetPortAliment();
    http.Response response;
    var uri = Uri.parse("${_url.url}${_url.portServiceAliment}/API/Aliments/ajouter");
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map data = {
      'nom':nom,
      'quantite':quantite,
      'poids':poids,
    };
    var body = json.encode(data);
    response = await http.post(uri,headers: headers, body: body);
    return response;
  }

  //Convertion en json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> aliment = <String, dynamic>{};
    aliment["nom"] = _nom;
    aliment["quantite"] = _quantite;
    aliment["poids"] = _poids;
    return aliment;
  }

  double get poids => _poids;

  set poids(double value) {
    _poids = value;
  }

  int get quantite => _quantite;

  set quantite(int value) {
    _quantite = value;
  }

  String get nom => _nom;

  set nom(String value) {
    _nom = value;
  }

  Url get url => _url;

  set url(Url value) {
    _url = value;
  }
}