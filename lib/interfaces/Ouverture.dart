import 'dart:io';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gourmettime/classes/Caisses.dart';
import 'package:gourmettime/classes/Commandes.dart';
import 'package:gourmettime/interfaces/livraison/Livraisons.dart';
import 'package:http/http.dart' as http;

import 'menu/Menu.dart';


class Ouverture extends StatefulWidget {
  const Ouverture({super.key});

  @override
  State<Ouverture> createState() => _OuvertureState();
}

class _OuvertureState extends State<Ouverture> {

  ///Variables
  late final List<Caisses> _caisse = []; ///Liste contenant la caisse activée
  late Caisses caisses = Caisses(0, "", false);///Instance de la classe caisse
  late Commandes cmd = Commandes();///Instance de la classe commande
  ///************************************

  ///Fonction pour activer une caisse
  Future<List<Caisses>> _Activer (List<Caisses> _caisses) async{
    late final List<dynamic> Maps;
    caisses.url.GetUrl();
    caisses.url.GetPortCommande();
    var uri = Uri.parse("${caisses.url.url}${caisses.url.portServiceCommande}/API/Commandes/activer");
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http.get(uri,headers: headers);
    Maps = jsonDecode(response.body);
    setState(() {
      _caisses = Maps.map((caisse) => Caisses.fromJson(caisse)).toList();
      if(_caisses.isNotEmpty)
      {
        Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => Menu(caisses: _caisses.first, cmd: cmd,)));
      }
    });
    return _caisses;
  }
  ///******************************************************

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _ExitApp(context),
      child: Scaffold(
        backgroundColor: Colors.orangeAccent,
          body: ListView(
            children: [
              const Padding(padding: EdgeInsets.only(bottom: 50)),
              ///Caroussel
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 400,
                    aspectRatio: 16/9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: ["1.jpeg","2.jpg","3.jpg","4.jpg"].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 3.0),
                          decoration: const BoxDecoration(
                              color: Colors.white
                          ),
                          child: Image.asset("assets/$i"),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 50)),
              Container(
                alignment: Alignment.center,
                child: const Text("Gourmet Time", style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              IconButton(
                  onPressed: (){
                    try{
                      _Activer(_caisse);
                    }catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Une erreur est survenue",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.no_food_rounded,
                    color: Colors.white,
                    size: 62,
                  )
              )
            ],
          ),
        ///Icône pour accédre à la page d'enregistrement des livraisons
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: (){
            Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const Livraisons()));
          },
          child: const Icon(Icons.delivery_dining, color: Colors.white, size: 24),
        ),
      ),
    );
  }

  ///Code de fermeture de l'application
  Future<bool> _ExitApp(BuildContext context) async {
    bool? exitApp = await showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("Attention !"),
          content: const Text("Voulez-vous vraiment quitter l'application ?"),
          actions: <Widget>[
            TextButton(
                onPressed: () => {
                  Navigator.of(context).pop(false)
                },
                child: const Text("Non")
            ),
            TextButton(
                onPressed: () {
                  if(Platform.isAndroid){
                    SystemNavigator.pop();
                  }
                  else if(Platform.isIOS){
                    exit(0);
                  }
                },
                child: const Text("Oui")
            )
          ],
        );
      }
    );
    return exitApp ?? false;
  }
}
