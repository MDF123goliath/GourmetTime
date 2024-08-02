import 'dart:convert';
import 'configs/Url.dart';
import 'package:http/http.dart' as http;

class HistLivraison{

  //Variables
  String _fournisseur;//Variables affichant les dates
  int _quantite;
  late Url _url = Url();

  HistLivraison(this._fournisseur,
      this._quantite); //Variable d'instance de la classe des configurations

  //Constructeur


  //Fonction pour enregistrer un historique dans la base de données
  Future<http.Response> newHistorique(String caisses) async {
    _url.GetUrl();
    _url.GetPortFournisseur();
    http.Response response;
    var uri = Uri.parse("${_url.url}${_url.portServiceFournisseur}/API/Fournisseurs/enregistrer/$caisses");
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map data = {
      'fournisseur':caisses,
    };
    var body = json.encode(data);
    response = await http.put(uri,headers: headers, body: body);
    return response;
  }

  //Convertion en json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> admins = <String, dynamic>{};
    admins["fournisseur"] = _fournisseur;
    admins["quantite"] = _quantite;
    return admins;
  }

  Url get url => _url;

  set url(Url value) {
    _url = value;
  }

  int get quantite => _quantite;

  set quantite(int value) {
    _quantite = value;
  }

  String get fournisseur => _fournisseur;

  set fournisseur(String value) {
    _fournisseur = value;
  }
}