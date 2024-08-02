import 'configs/Url.dart';
import 'package:http/http.dart' as http;

class Caisses{

  //Variables
  int _id;//Variable pour l'identifiant de la caisse
  String _nom;//Variable pour le nom de la caisse
  bool _etat;//Variable pour l'état de la caisse
  late Url url = Url();

  //Constructeur
  Caisses(this._id, this._nom, this._etat);

  //Fonction pour convertir les données d'un fichier Json en texte
  Caisses.fromJson(Map<String, dynamic> json)
      :_id = json['id'],
        _nom = json['nom'],
        _etat = json['etat'];

  //Fonction pour convertir les données d'un fichier texte en Json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> caisses = <String, dynamic>{};
    caisses["id"] = _id;
    caisses["nom"] = _nom;
    caisses["etat"] = _etat;
    return caisses;
  }

  //Fonction pour désactiver la caisse
  Future <http.Response> desactiver (int id) async{
    url.GetUrl();
    url.GetPortCommande();
    var _uri = Uri.parse("${url.url}${url.portServiceCommande}/API/Commandes/desactiver/$id");
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http.put(_uri,headers: headers);
    return response;
  }

  //Getters & Setters
  bool get etat => _etat;

  set etat(bool value) {
    _etat = value;
  }

  String get nom => _nom;

  set nom(String value) {
    _nom = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}