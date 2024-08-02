class Url {
  ///Variables
  late String _url ="";///variable pour l'adresse ip du serveur
  late String _portServiceCommande ="";///variable du port du service de commande
  late String _portServiceAliment ="";///variable du port du service des aliments
  late String _portServiceFournisseur ="";///variable du port du service des fournisseurs

  ///Fonction pour retourner l'adresse ip du serveur
  String GetUrl(){
    _url = "http://10.0.2.2";
    return _url;
  }

  ///Fonction pour retourner le port du service des aliments
  String GetPortAliment(){
    _portServiceAliment = ":8082";
    return _portServiceAliment;
  }

  ///Fonction pour retourner le port du service de commande
  String GetPortCommande(){
    _portServiceCommande = ":8083";
    return _portServiceCommande;
  }

  ///Fonction pour retourner le port du service de commande
  String GetPortFournisseur(){
    _portServiceFournisseur = ":8084";
    return _portServiceFournisseur;
  }

  ///Getters & Setters
  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get portServiceAliment => _portServiceAliment;

  set portServiceAliment(String value) {
    _portServiceAliment = value;
  }

  String get portServiceCommande => _portServiceCommande;

  set portServiceCommande(String value) {
    _portServiceCommande = value;
  }

  String get portServiceFournisseur => _portServiceFournisseur;

  set portServiceFournisseur(String value) {
    _portServiceFournisseur = value;
  }
}