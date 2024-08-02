import 'dart:convert';
import 'configs/Url.dart';
import 'package:http/http.dart' as http;

class Historiques{

  //Variables
  String _caisses;//Variables affichant les dates
  int _quantite;
  late Url _url = Url();//Variable d'instance de la classe des configurations

  //Constructeur
  Historiques(this._caisses,this._quantite);

  //Fonction pour enregistrer un historique dans la base de données
  Future<http.Response> newHistorique(String caisses) async {
    _url.GetUrl();
    _url.GetPortCommande();
    http.Response response;
    var uri = Uri.parse("${_url.url}${_url.portServiceCommande}/API/Historiques/enregistrer/$caisses");
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map data = {
      'caisses':caisses,
    };
    var body = json.encode(data);
    response = await http.put(uri,headers: headers, body: body);
    return response;
  }

  //Récupération des données depuis un fichier json
  Historiques.fromJson(Map<String, dynamic> json)
    : _caisses = json['caisses'],
      _quantite = json['quantite'];

  //Convertion en json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> admins = <String, dynamic>{};
    admins["caisses"] = _caisses;
    admins["quantite"] = _quantite;
    return admins;
  }

  //Getters & Setters
  Url get url => _url;

  set url(Url value) {
    _url = value;
  }

  int get quantite => _quantite;

  set quantite(int value) {
    _quantite = value;
  }

  String get caisses => _caisses;

  set caisses(String value) {
    _caisses = value;
  }
}