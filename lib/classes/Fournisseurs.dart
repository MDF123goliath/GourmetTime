import 'configs/Url.dart';

class Fournisseurs{

  String _name;
  String _agence;
  String _addressmail;
  String _telephone;
  bool _actif;
  Url _url = Url();

  Fournisseurs(this._name, this._agence, this._addressmail, this._telephone,
      this._actif);

  //Récupération des données depuis un fichier json
  Fournisseurs.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _agence = json['agence'],
        _addressmail = json['addressmail'],
        _telephone = json['telephone'],
        _actif = json['actif'];

  //Getters & Setters
  bool get actif => _actif;

  set actif(bool value) {
    _actif = value;
  }

  String get telephone => _telephone;

  set telephone(String value) {
    _telephone = value;
  }

  String get addressmail => _addressmail;

  set addressmail(String value) {
    _addressmail = value;
  }

  String get agence => _agence;

  set agence(String value) {
    _agence = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  Url get url => _url;

  set url(Url value) {
    _url = value;
  }
}