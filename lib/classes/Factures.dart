import 'dart:convert';
import 'configs/Url.dart';
import 'package:http/http.dart' as http;

class Factures{

  ///Variables
  int _nbrePlats;///variable de la colonne du nombre de plats de la commande
  int _nbreComplements;///variable de la colonne du nombre de compléments de la commande
  int _nbreBoissons;///variable de la colonne du nombre de boissons de la commande
  double _montant;///variable de la colonne du montant de la commande
  String _numero;///variable de la colonne du numéro de la commande
  String _caisses;///variable de la colonne de la caisse ayant effectuée la commande
  String _dates;///variable de la colonne de la date de la commande
  String _heure;///variable de la colonne des heures de la commande
  late Url _url = Url();

  Factures(this._nbrePlats, this._nbreComplements, this._nbreBoissons, this._montant, this._numero,
      this._caisses, this._dates, this._heure); //Constructeur


  ///Fonction pour enregistrer une commande dans la base de données
  Future<http.Response> Enregistrer(int plats, int complements, int boissons, double montant, String numero, String caisse, String dates, String heure) async {
    _url.GetUrl();
    _url.GetPortCommande();
    http.Response response;
    var uri = Uri.parse("${_url.url}${_url.portServiceCommande}/API/Commandes/insererCommande");
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map data = {
      'nbreplats':plats,
      'nbrecomplements':complements,
      'nbreboissons':boissons,
      'montant':montant,
      'numero':numero,
      'caisses':caisse,
      'dates':dates,
      'heures':heure,
    };
    var body = json.encode(data);
    response = await http.post(uri,headers: headers, body: body);
    return response;
  }

  //Récupération des données depuis un fichier json
  Factures.fromJson(Map<String, dynamic> json)
      : _nbrePlats = json['nbreplats'],
        _nbreComplements = json['nbrecomplements'],
        _nbreBoissons = json['nbreboissons'],
        _montant = json['montant'],
        _numero = json['numero'],
        _caisses = json['caisses'],
        _dates = json['dates'],
        _heure = json['heures'];

  //Convertion en json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> cmd = <String, dynamic>{};
    cmd["nbreplats"] = _nbrePlats;
    cmd["nbrecomplements"] = _nbreComplements;
    cmd["nbreboissons"] = _nbreBoissons;
    cmd["montant"] = _montant;
    cmd["numero"] = _numero;
    cmd["caisses"] = _caisses;
    cmd["dates"] = _dates;
    cmd["heures"] = _heure;
    return cmd;
  }

  //Getters & Setters
  Url get url => _url;

  set url(Url value) {
    _url = value;
  }

  String get dates => _dates;

  set dates(String value) {
    _dates = value;
  }

  String get caisses => _caisses;

  set caisses(String value) {
    _caisses = value;
  }

  String get numero => _numero;

  set numero(String value) {
    _numero = value;
  }

  double get montant => _montant;

  set montant(double value) {
    _montant = value;
  }

  int get nbreBoissons => _nbreBoissons;

  set nbreBoissons(int value) {
    _nbreBoissons = value;
  }

  int get nbrePlats => _nbrePlats;

  set nbrePlats(int value) {
    _nbrePlats = value;
  }

  String get heure => _heure;

  set heure(String value) {
    _heure = value;
  }

  int get nbreComplements => _nbreComplements;

  set nbreComplements(int value) {
    _nbreComplements = value;
  }
}