import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../classes/Aliments.dart';
import '../../classes/Fournisseurs.dart';
import '../../classes/HistLivraison.dart';
import '../../classes/Livraison.dart';

class Livraisons extends StatefulWidget {
  const Livraisons({super.key});

  @override
  State<Livraisons> createState() => _LivraisonsState();
}

class _LivraisonsState extends State<Livraisons> {

  ///Variables
  late Fournisseurs fournisseur = Fournisseurs("", "", "", "", true);///Variable d'instance de la classe Fournisseur
  late Livraison livraison = Livraison(0, 0.0, 0.0,"", "", "", "");///Variable d'instance de la classe Livraison
  late Aliments aliments = Aliments("", 0, 0.0);///Variable d'instance de la classe Aliments
  late List<Fournisseurs> _list =[];///Variable pour la liste des fournisseurs
  final _formkey = GlobalKey<FormState>();///Variable pour le contrôle du formulaire
  late String _produit="";///Variable pour le produit livré
  late int _quantite = 0;///Variable pour la quantité du produit
  late double _poids = 0.0;///Variable pour le poids du produit
  late double _prix = 0.0;///Variable  pour le prix de la livraison
  late final String _date = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
  late final String _heure = "${DateTime.now().hour}:${DateTime.now().minute}";
  late String _fournisseurs = "";///Variable pour le nom du fournisseur
  ///*************************************************************************

  ///Fonction pour afficher la liste des fournisseurs
  Future<List<Fournisseurs>> _fournisseur() async{
    fournisseur.url.GetUrl();
    fournisseur.url.GetPortFournisseur();
    final List<dynamic> maps;
    var uri = Uri.parse("${fournisseur.url.url}${fournisseur.url.portServiceFournisseur}/API/Fournisseurs/afficherFournisseur");
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http.get(uri,headers: headers);
    maps = jsonDecode(response.body);
    setState(() {
      _list =maps.map((plats) => Fournisseurs.fromJson(plats)).toList();
    });
    return _list;
  }
  ///************************************************************************

  @override
  Widget build(BuildContext context) {
    _fournisseur();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: FittedBox(
            child: Text("Gourmet Time : Livraison", style: TextStyle(fontSize: MediaQuery.of(context).size.width/15, fontWeight: FontWeight.bold, color: Colors.white)),
          )
        ),
        body: ListView(
          children: [
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Produit',
                          hintText: 'Nom du produit',
                          border: OutlineInputBorder()
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty )
                        {
                          return "Veuillez remplir ce champ.";
                        }
                        else{
                          _produit = value.toString();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Quantité',
                          hintText: 'Quantité du produit (facultatif)',
                          border: OutlineInputBorder()
                      ),
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          _quantite = 0;
                        }
                        else{
                          _quantite = int.parse(value.toString());
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Poids',
                          hintText: 'Poids du produit en Kg',
                          border: OutlineInputBorder()
                      ),
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Veuillez remplir ce champ.";
                        }
                        else{
                          _poids = double.parse(value.toString());
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Prix',
                          hintText: 'Prix de a livraison',
                          border: OutlineInputBorder()
                      ),
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Veuillez remplir ce champ.";
                        }
                        else{
                          _prix = double.parse(value.toString());
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24.0),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: DropdownButtonFormField(
                          items: [
                            for(int i = 0; i < _list.length; i++)
                            DropdownMenuItem(value: _list[i].name, child: Text(utf8.decode(_list[i].name.runes.toList()))),
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          value: "Express",
                          onChanged: (value){
                            _fournisseurs = value.toString();
                          }),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        /// Vérifiez les informations de connexion ici
                        FocusScope.of(context).requestFocus(FocusNode());
                        if(_formkey.currentState!.validate())
                        {
                          try{
                            HistLivraison("", 0).newHistorique(_fournisseurs);
                            livraison.Enregistrer(_produit, _quantite, _prix,_poids,_date, _heure, _fournisseurs);
                            aliments.Enregistrer(_produit, _quantite, _poids);
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Livraisons()), (route) => true);
                          }catch(e){
                            const AlertDialog(title: Text("Une erreur est survenue"));
                          }
                        }
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange),
                      ),
                      child: Text('Enregistrer', style: TextStyle(fontSize: MediaQuery.of(context).size.width/20, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      );
  }
}