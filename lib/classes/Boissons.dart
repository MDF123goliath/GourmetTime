import 'configs/Url.dart';

class Boissons{

  //Variables
  String _nom;//Variable du nom de la boisson
  String _image;//Variable de l'image de la boisson
  bool _disponible;//Variable de la disponibilité de la boisson
  double _prix;//Variable du prix de la boisson
  String _categorie;//Variable de la categorie de la boisson
  late Url url = Url();

  //Constructeur
  Boissons(this._nom, this._image, this._prix, this._categorie, this._disponible);

  //Récupération des données depuis un fichier json
  Boissons.fromJson(Map<String, dynamic> json)
      :_nom = json['nom'],
        _categorie = json['categorie'],
        _prix = json['prix'],
        _image = json['image'],
        _disponible = json['disponible'];

  //Getters & Setters
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