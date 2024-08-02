import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gourmettime/classes/Commandes.dart';
import 'package:gourmettime/classes/Complements.dart';
import 'package:http/http.dart' as http;
import '../../classes/Caisses.dart';
import '../../classes/Plats.dart';
import '../../classes/Boissons.dart';
import '../Ouverture.dart';
import 'description/Description.dart';
import 'facture/Facture.dart';

class Menu extends StatefulWidget {
  const Menu({super.key, required this.cmd, required this.caisses});

  final Commandes cmd;
  final Caisses caisses;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  ///Variables
  late final Plats _plats = Plats("", "", 0.0, "","",true);
  late final Boissons boissons = Boissons("", "", 0.0, "",true);
  late final Complements complements = Complements("","", 0.0,true);
  late List<Plats> plat = [];///Variable pour la liste des plats
  late String _categoriePlats = "";///Variable pour afficher la catégorie de plat sélectionnée
  late List<String> _donneesPlats = [];///Variable contenant l'ensemble des catégories des plats
  late List<Boissons> _boisson =[];///Variable pour la liste des boissons
  late String _categorieBoissons = "";///Variable pour afficher la catégories de boissons sélectionnées
  late List<String> _donneesBoissons = [];///Variable contenant l'ensemble des catégories des boissons
  late List<Complements> _listComplement = [];///Variable pour la liste des compléments
  ///******************************************************************************///

  ///Fonctions
  ///Fonction qui récupère les catégories des plats depuis un fichier texte
  Future<List<String>> _LireDonneesPlats() async {
    _plats.url.GetUrl();
    _plats.url.GetPortAliment();
    final response = await http.get(Uri.parse('${_plats.url.url}${_plats.url.portServiceAliment}/API/Aliments/lirePlats'));
    if (response.statusCode == 200) {
      setState(() {
        _donneesPlats = json.decode(response.body).cast<String>();
      });
      return _donneesPlats.toList();
    } else {
      throw Exception('Impossible de récupérer les données du serveur');
    }
  }
  ///Fonction qui affiche les plats selon la catégoreis
  Future<List<Plats>> ListePlats(String categorie) async{
    _plats.url.GetUrl();
    _plats.url.GetPortAliment();
    final List<dynamic> maps;
    var uri = Uri.parse("${_plats.url.url}${_plats.url.portServiceAliment}/API/Aliments/afficherPlats3/$categorie");
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response =  await http.get(uri,headers: headers);
    maps = jsonDecode(response.body);
    setState(() {
      _LireDonneesPlats();
      plat =maps.map((plats) => Plats.fromJson(plats)).toList();
      _categoriePlats = utf8.decode(_donneesPlats.first.runes.toList());
    });
    return plat;
  }
  ///Fonction qui récupère les catégories des boissons depuis un fichier texte
  Future<List<String>> _LireDonneesBoissons() async {
    boissons.url.GetUrl();
    boissons.url.GetPortAliment();
    final response = await http.get(Uri.parse('${boissons.url.url}${boissons.url.portServiceAliment}/API/Aliments/lireBoissons'));
    if (response.statusCode == 200) {
      setState(() {
        _donneesBoissons = json.decode(response.body).cast<String>();
      });
      return _donneesBoissons.toList();
    } else {
      throw Exception('Impossible de récupérer les données du serveur');
    }
  }
  ///Fonction qui affiche les boissons selon la catégoreis
  Future<List<Boissons>> _CategorieBoissons(String categorie) async{
    final List<dynamic> maps;
    var uri = Uri.parse("${boissons.url.url}${boissons.url.portServiceAliment}/API/Aliments/afficherBoissons3/$categorie");
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http.get(uri,headers: headers);
    maps = jsonDecode(response.body);
    setState(() {
      _LireDonneesBoissons();
      _boisson =maps.map((boisson) => Boissons.fromJson(boisson)).toList();
      _categorieBoissons = utf8.decode(_donneesBoissons.first.runes.toList());
    });
    return _boisson;
  }
  ///Fonction qui affiche les compléments
  Future<List<Complements>> _GetComplement() async{
    final List<dynamic> maps;
    complements.url.GetUrl();
    complements.url.GetPortAliment();
    var uri = Uri.parse("${complements.url.url}${complements.url.portServiceAliment}/API/Aliments/afficherComplements2");
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http.get(uri,headers: headers);
    maps = jsonDecode(response.body);
    setState(() {
      _listComplement =maps.map((complement) => Complements.fromJson(complement)).toList();
    });
    return _listComplement;
  }
  ///***************************************************************************************///

  @override
  Widget build(BuildContext context) {
    ///Activation des fonctions
    if(_donneesPlats.isEmpty)
    {
      _LireDonneesPlats();
      ListePlats(_categoriePlats);
    }
    if(_donneesBoissons.isEmpty)
    {
      _LireDonneesBoissons();
      _CategorieBoissons(_categorieBoissons);
    }
    _GetComplement();
    ///********************************
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: FittedBox(
          child: Text("Gourmet Time : ${widget.caisses.nom}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width/12, color: Colors.white)),
        ),
        actions: <Widget>[
        FittedBox(
            child : Stack(
              children: <Widget>[
                IconButton(
                    onPressed: (){
                      _ShowDialog();
                    },
                    icon: Icon(Icons.shopping_cart_rounded, size: MediaQuery.of(context).size.width/12, color: Colors.white)),
                Positioned(
                    right: 1,
                    child: FittedBox(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width/30,
                          minWidth: MediaQuery.of(context).size.width/40,
                          maxHeight: MediaQuery.of(context).size.height/40,
                          minHeight: MediaQuery.of(context).size.height/50,
                        ),
                        child: Text("${widget.cmd.plats.length + widget.cmd.boissons.length +widget.cmd.complements.length}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    )
                )
              ],
            )
        )
        ],
      ),
      backgroundColor: Colors.white70,
      body: ListView(
        children: [
          ///Partie concernant les plats
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.5),
                    offset: const Offset(10,10)
                )]
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/4,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/1.jpeg"), fit: BoxFit.cover)
                  ),
                  child: Text("Plats", style: TextStyle(fontSize: MediaQuery.of(context).size.width/7, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                ///Catégorie des plats
                const Text("Catégories", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.orange)),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for(int i = 0; i < _donneesPlats.length; i++)
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.orange
                            ),
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(15),
                            child: TextButton(
                                onPressed: (){
                                  _LireDonneesPlats();
                                  _categoriePlats = utf8.decode(_donneesPlats[i].runes.toList());
                                  ListePlats(utf8.decode(_donneesPlats[i].runes.toList()));
                                },
                                child: Text( utf8.decode(_donneesPlats[i].runes.toList()), style: TextStyle(fontSize: MediaQuery.of(context).size.width/20, fontWeight: FontWeight.bold, color: Colors.white),)),
                          ),
                      ],
                    ),
                  )
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                ///Affichage des plats
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for(int i = 0; i < plat.length; i++)
                        Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [Colors.orange.shade200, Colors.orangeAccent]),
                            ),
                            child: FittedBox(
                              child: Column(
                                children: [
                                  IconButton(
                                      onPressed: () => {
                                      Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => Description(plats: plat[i])))
                                      },
                                      icon: const Icon(Icons.remove_red_eye_rounded, color: Colors.white,)
                                  ),
                                  Image.network("${_plats.url.url}${_plats.url.portServiceAliment}/images/${plat[i].image}", height: 100, width: 170),
                                  Text(utf8.decode(plat[i].nom.runes.toList()), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                  Text("${plat[i].prix} XAF", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                  ElevatedButton(
                                      onPressed: (){
                                        widget.cmd.plats.add(plat[i]);
                                        widget.cmd.totalprixplats(widget.cmd.plats);
                                      },
                                      child: const Icon(Icons.add_circle, color: Colors.orange,)
                                  )
                                ],
                              ),
                            )
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 75)),
          ///Partie concernant les boissons
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
                boxShadow: [BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.5),
                    offset: const Offset(10,10)
                )]
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/4,
                  decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/jus.jpeg"), fit: BoxFit.cover)
                  ),
                  child: Text("Boissons", style: TextStyle(fontSize: MediaQuery.of(context).size.width/7, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                ///Catégorie des boissons
                const Text("Catégories", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.orange)),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for(int j = 0; j < _donneesBoissons.length; j++)
                          Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    _LireDonneesBoissons();
                                    _categorieBoissons = utf8.decode(_donneesBoissons[j].runes.toList());
                                    _CategorieBoissons(utf8.decode(_donneesBoissons[j].runes.toList()));
                                  },
                                  child: Text( utf8.decode(_donneesBoissons[j].runes.toList()), style: TextStyle(fontSize: 5*(MediaQuery.of(context).size.width)/100, fontWeight: FontWeight.bold, color: Colors.white),))
                          ),
                      ],
                    ),
                  )
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                ///Affichage des boissons
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for(int y = 0; y < _boisson.length; y++)
                        Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [Colors.orange.shade200, Colors.orangeAccent]),
                            ),
                            child: FittedBox(
                              child: Column(
                                children: [
                                  Image.network('${boissons.url.url}${boissons.url.portServiceAliment}/images/${_boisson[y].image}', height: 100, width: 170),
                                  Text(utf8.decode(_boisson[y].nom.runes.toList()), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                  Text("${_boisson[y].prix} XAF", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                  ElevatedButton(
                                      onPressed: (){
                                        widget.cmd.boissons.add(_boisson[y]);
                                        widget.cmd.totalprixboissons(widget.cmd.boissons);
                                      },
                                      child: const Icon(Icons.add_circle, color: Colors.orange,)
                                  )
                                ],
                              ),
                            )
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 75)),
          ///Partie concernant les compléments
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.5),
                offset: const Offset(10,10)
              )]
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/4,
                  decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/complement.jpg"), fit: BoxFit.cover)
                  ),
                  child: Text("Compléments", style: TextStyle(fontSize: MediaQuery.of(context).size.width/7, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                ///Affichage des Compléments
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for(int x = 0; x < _listComplement.length; x++)
                        Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [Colors.orange.shade200, Colors.orangeAccent]),
                            ),
                            child: FittedBox(
                              child: Column(
                                children: [
                                  Image.network('${complements.url.url}${complements.url.portServiceAliment}/images/${_listComplement[x].image}', height: 100, width: 170),
                                  Text(utf8.decode(_listComplement[x].nom.runes.toList()), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                  Text("${_listComplement[x].prix} XAF", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                  ElevatedButton(
                                      onPressed: (){
                                        widget.cmd.complements.add(_listComplement[x]);
                                        widget.cmd.totalprixcomplements(widget.cmd.complements);
                                      },
                                      child: const Icon(Icons.add_circle, color: Colors.orange,)
                                  )
                                ],
                              ),
                            )
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: FittedBox(
          child: Icon(Icons.power_settings_new_rounded, size: MediaQuery.of(context).size.width/10, color: Colors.white),
        ),
        onPressed: (){
          try{
            widget.caisses.desactiver(widget.caisses.id);
            Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const Ouverture()));
          }catch(e){}
        },
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.all(15.0),
          color: Colors.orange,
          child:  Row(
            children: <Widget>[
              Expanded(child: Text("Prix : ${widget.cmd.total} XAF", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width/20, color: Colors.white))),
              Expanded(
                  child: ElevatedButton(
                    onPressed: () => {
                      Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => Facture(cmd: widget.cmd, caisses: widget.caisses,))),
                    },
                    child: Text("Terminer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width/20, color: Colors.orangeAccent)),
                  )
              ),
            ],
          ),
        )
    );
  }

  ///Voir et modifier son menu
  Future<void> _ShowDialog() async {
    int taille = 0;
    int taille1 = 0;
    int taille2 = 0;
    if(widget.cmd.plats.isNotEmpty){
      taille = widget.cmd.plats.length;
    }
    if(widget.cmd.boissons.isNotEmpty){
      taille1 = widget.cmd.boissons.length;
    }
    if(widget.cmd.complements.isNotEmpty){
      taille2 = widget.cmd.complements.length;
    }
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Votre commande :", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  ///Plats choisis
                  for(int z =0; z < taille; z++)
                    Card(
                      child: ListTile(
                        leading: FittedBox(child: Image.network("${_plats.url.url}${_plats.url.portServiceAliment}/images/${widget.cmd.plats[z].image}", width: 75, height: 75)),
                        title: Text(utf8.decode(widget.cmd.plats[z].nom.runes.toList()), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        subtitle: FittedBox(child: Text("${widget.cmd.plats[z].prix} XAF")),
                        trailing: IconButton(
                            onPressed: (){
                              widget.cmd.total = widget.cmd.total - widget.cmd.plats[z].prix;
                              widget.cmd.totalplat = widget.cmd.totalplat - widget.cmd.plats[z].prix;
                              widget.cmd.plats.remove(widget.cmd.plats[z]);
                            },
                            icon: const Icon(Icons.remove_circle), color: Colors.orange),
                      ),
                    ),
                  ///Boissons choisies
                  for(int z =0; z < taille1; z++)
                    Card(
                      child: ListTile(
                        leading: FittedBox(child: Image.network("${boissons.url.url}${boissons.url.portServiceAliment}/images/${widget.cmd.boissons[z].image}", width: 75, height: 75)),
                        title: Text(utf8.decode(widget.cmd.boissons[z].nom.runes.toList()), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        subtitle: FittedBox(child: Text("${widget.cmd.boissons[z].prix} XAF")),
                        trailing: IconButton(
                            onPressed: (){
                              widget.cmd.total = widget.cmd.total - widget.cmd.boissons[z].prix;
                              widget.cmd.totalboisson = widget.cmd.totalboisson - widget.cmd.boissons[z].prix;
                              widget.cmd.boissons.remove(widget.cmd.boissons[z]);
                            },
                            icon: const Icon(Icons.remove_circle), color: Colors.orange),
                      ),
                    ),
                  ///Compléments choisis
                  for(int z =0; z < taille2; z++)
                    Card(
                      child: ListTile(
                        leading: FittedBox(child: Image.network("${complements.url.url}${complements.url.portServiceAliment}/images/${widget.cmd.complements[z].image}", width: 75, height: 75)),
                        title: Text(utf8.decode(widget.cmd.complements[z].nom.runes.toList()), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        subtitle: FittedBox(child: Text("${widget.cmd.complements[z].prix} XAF")),
                        trailing: IconButton(
                            onPressed: (){
                              widget.cmd.total = widget.cmd.total - widget.cmd.complements[z].prix;
                              widget.cmd.totalcomplement = widget.cmd.totalcomplement - widget.cmd.complements[z].prix;
                              widget.cmd.complements.remove(widget.cmd.complements[z]);
                            },
                            icon: const Icon(Icons.remove_circle), color: Colors.orange),
                      ),
                    ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ok")
              )
            ],
          );
        }
    );
  }
  ///**************************************************************************
}