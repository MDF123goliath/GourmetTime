import 'dart:convert';
import 'configs/Url.dart';
import 'package:http/http.dart' as http;

class Livraison{

  //Variables
  int _quantite;//variable de la colonne du nombre de plats de la commande
  double _prix;
  double _poids;//variable de la colonne du montant de la commande
  String _produit;//variable de la colonne du numéro de la commande
  String _fournisseur;//variable de la colonne de la caisse ayant effectuée la commande
  String _dates;//variable de la colonne de la date de la commande
  String _heure;//variable de la colonne des heures de la commande

  late Url _url = Url();

  Livraison(this._quantite, this._prix, this._poids, this._produit, this._fournisseur,
      this._dates, this._heure);

  //Fonction pour enregistrer une commande dans la base de données
  Future<http.Response> Enregistrer(String produit, int quantite, double prix, double poids, String date, String heure, String fournisseur) async {
    _url.GetUrl();
    _url.GetPortFournisseur();
    http.Response response;
    var uri = Uri.parse("${_url.url}${_url.portServiceFournisseur}/API/Livraison/ajouter");
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map data = {
      'produit':produit,
      'quantite':quantite,
      'prix':prix,
      'poids':poids,
      'date':date,
      'heure':heure,
      'fournisseur':fournisseur,
    };
    var body = json.encode(data);
    response = await http.post(uri,headers: headers, body: body);
    return response;
  }

  //Convertion en json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> cmd = <String, dynamic>{};
    cmd["produit"] = _produit;
    cmd["quantite"] = _quantite;
    cmd["prix"] = _prix;
    cmd["poids"] = _poids;
    cmd["date"] = _dates;
    cmd["heure"] = _heure;
    cmd["fournisseur"] = _fournisseur;
    return cmd;
  }

  //Getters&Setters
  Url get url => _url;

  set url(Url value) {
    _url = value;
  }

  String get heure => _heure;

  set heure(String value) {
    _heure = value;
  }

  String get dates => _dates;

  set dates(String value) {
    _dates = value;
  }

  String get fournisseur => _fournisseur;

  set fournisseur(String value) {
    _fournisseur = value;
  }

  double get prix => _prix;

  set prix(double value) {
    _prix = value;
  }

  String get produit => _produit;

  set produit(String value) {
    _produit = value;
  }

  double get poids => _poids;

  set poids(double value) {
    _poids = value;
  }

  int get quantite => _quantite;

  set quantite(int value) {
    _quantite = value;
  }

}