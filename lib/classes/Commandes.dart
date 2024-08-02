import 'Boissons.dart';
import 'Complements.dart';
import 'Plats.dart';

class Commandes{

  ///Variables
  late List<Plats>_plats = [];///Liste des plats sélectionnés pour la commande
  late List<Complements>_complements = [];///Liste des compléments sélectionnés pour la commande
  late List<Boissons>_boissons = [];///Liste des boissons sélectionnées pour la commande
  late double _totalplat = 0.0;///Prix total des plats
  late double _totalcomplement = 0.0;///Prix total des compléments
  late double _totalboisson = 0.0;///Prix total des boissons
  late double _total = 0.0;///Prix total de la commande
  late List<String> _listeplat = [];///Liste des noms des plats sélectionnés pour la commande
  late List<String> _listeboisson = [];///Liste des noms des boissons sélectionnées pour la commande
  late List<String> _listecomplement = [];///Liste des noms des compléments sélectionnées pour la commande
  ///********************************************************************

  ///Fonctions
  ///Fonction retournant le prix total des plats
  totalprixplats(Plats){
    _totalplat = 0.0;
    for(int i = 0; i < _plats.length; i++){
      _totalplat = _totalplat + _plats[i].prix;
    }
    _total = _totalcomplement + _totalboisson + _totalplat;
    return _total;
  }

  ///Fonction retournant le prix total des plats
  totalprixcomplements(Complements){
    _totalcomplement = 0.0;
    for(int i = 0; i < _complements.length; i++){
      _totalcomplement = _totalcomplement + _complements[i].prix;
    }
    _total = _totalcomplement + _totalboisson + _totalplat;
    return _total;
  }

  ///Fonction retournant le prix total des boissons
  totalprixboissons(Boissons){
    _totalboisson = 0.0;
    for(int i = 0; i < _boissons.length; i++){
      _totalboisson = _totalboisson + _boissons[i].prix;
    }
    _total = _totalplat + _totalboisson + _totalcomplement;
    return _total;
  }
  ///**************************************************************************

  ///Getters & Setters
  List<String> get listeboisson => _listeboisson;

  set listeboisson(List<String> value) {
    _listeboisson = value;
  }

  List<String> get listeplat => _listeplat;

  set listeplat(List<String> value) {
    _listeplat = value;
  }

  double get total => _total;

  set total(double value) {
    _total = value;
  }

  double get totalboisson => _totalboisson;

  set totalboisson(double value) {
    _totalboisson = value;
  }

  double get totalplat => _totalplat;

  set totalplat(double value) {
    _totalplat = value;
  }

  List<Boissons> get boissons => _boissons;

  set boissons(List<Boissons> value) {
    _boissons = value;
  }

  List<Plats> get plats => _plats;

  set plats(List<Plats> value) {
    _plats = value;
  }

  List<String> get listecomplement => _listecomplement;

  set listecomplement(List<String> value) {
    _listecomplement = value;
  }

  List<Complements> get complements => _complements;

  set complements(List<Complements> value) {
    _complements = value;
  }

  double get totalcomplement => _totalcomplement;

  set totalcomplement(double value) {
    _totalcomplement = value;
  }
  ///**************************************************************************
}