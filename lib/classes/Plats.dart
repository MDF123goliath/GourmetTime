import 'configs/Url.dart';

class Plats{

  //Variables
  String _nom;//Variable du nom du plat
  String _image;//Variable de l'image du plat
  bool _disponible;//Variable de la disponibilité du plat
  double _prix;//Variable du prix du plat
  String _categorie;//Variable de la categorie du plat
  String _description;//Variable de la description du plat
  late Url url = Url();

  //Constructeur
  Plats(this._nom, this._image, this._prix, this._categorie, this._description, this._disponible);

  //Récupération des données depuis un fichier json
  Plats.fromJson(Map<String, dynamic> json)
       :_nom = json['nom'],
        _categorie = json['categorie'],
        _description = json['description'],
        _prix = json['prix'],
        _image = json['image'],
        _disponible = json['disponible'];

  //Getters & Setters
  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get categorie => _categorie;

  set categorie(String value) {
    _categorie = value;
  }

  double get prix => _prix;

  set prix(double value) {
    _prix = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get nom => _nom;

  set nom(String value) {
    _nom = value;
  }

  bool get disponible => _disponible;

  set disponible(bool value) {
    _disponible = value;
  }
}