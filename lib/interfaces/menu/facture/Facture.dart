import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gourmettime/classes/Caisses.dart';
import '../../../classes/Boissons.dart';
import '../../../classes/Commandes.dart';
import '../../../classes/Complements.dart';
import '../../../classes/Elements.dart';
import '../../../classes/Factures.dart';
import '../../../classes/Historiques.dart';
import '../../../classes/Plats.dart';
import '../Menu.dart';

class Facture extends StatefulWidget {
  const Facture({super.key, required this.cmd, required this.caisses});

  final Commandes cmd;
  final Caisses caisses;

  @override
  State<Facture> createState() => _FactureState();
}

class _FactureState extends State<Facture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Facture", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width/15, color: Colors.white)),
      ),
      backgroundColor: Colors.white70,
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
                boxShadow: [BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(1.0),
                    offset: const Offset(10,10)
                )]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Gourmet Time", style: TextStyle(fontSize: MediaQuery.of(context).size.width/10,fontWeight: FontWeight.bold, color: Colors.orange)),
                const Text("-------------------------------------------------------------------------"),
                const Padding(padding: EdgeInsets.all(5)),
                DataTable(
                    columns: [
                      DataColumn(label: Text("Plats", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: MediaQuery.of(context).size.width/20))),
                      DataColumn(label: Text("Prix", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: MediaQuery.of(context).size.width/20))),
                    ],
                  rows: widget.cmd.plats.map((Plat) {
                    return DataRow(cells: [
                      DataCell(Text(utf8.decode(Plat.nom.runes.toList()),style: TextStyle(fontSize: 4*(MediaQuery.of(context).size.width)/100))),
                      DataCell(Text("${Plat.prix} XAF",style: TextStyle(fontSize: 4*(MediaQuery.of(context).size.width)/100))),
                    ]);
                  }).toList(),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                Text("Total plats : ${widget.cmd.totalplat} XAF", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: MediaQuery.of(context).size.width/20)),
                const Padding(padding: EdgeInsets.all(10)),
                DataTable(
                    columns: [
                      DataColumn(label: Text("Compléments", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: MediaQuery.of(context).size.width/20))),
                      DataColumn(label: Text("Prix", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: MediaQuery.of(context).size.width/20))),
                    ],
                  rows: widget.cmd.complements.map((Complement) {
                    return DataRow(cells: [
                      DataCell(Text(utf8.decode(Complement.nom.runes.toList()),style: TextStyle(fontSize: 4*(MediaQuery.of(context).size.width)/100))),
                      DataCell(Text("${Complement.prix} XAF",style: TextStyle(fontSize: 4*(MediaQuery.of(context).size.width)/100))),
                    ]);
                  }).toList(),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                Text("Total complément : ${widget.cmd.totalcomplement} XAF", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: MediaQuery.of(context).size.width/20)),
                const Padding(padding: EdgeInsets.all(10)),
                DataTable(
                    columns: [
                      DataColumn(label: Text("Boissons", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: MediaQuery.of(context).size.width/20))),
                      DataColumn(label: Text("Prix", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: MediaQuery.of(context).size.width/20))),
                    ],
                  rows: widget.cmd.boissons.map((Boisson) {
                    return DataRow(cells: [
                      DataCell(Text(utf8.decode(Boisson.nom.runes.toList()),style: TextStyle(fontSize: 4*(MediaQuery.of(context).size.width)/100))),
                      DataCell(Text("${Boisson.prix} XAF",style: TextStyle(fontSize: 4*(MediaQuery.of(context).size.width)/100))),
                    ]);
                  }).toList(),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                Text("Total boissons : ${widget.cmd.totalboisson} XAF", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: MediaQuery.of(context).size.width/20)),
                const Padding(padding: EdgeInsets.all(15)),
                Text("Total : ${widget.cmd.total} XAF", style: TextStyle(fontSize: MediaQuery.of(context).size.width/17, fontWeight: FontWeight.bold, color: Colors.black)),
                const Padding(padding: EdgeInsets.all(15)),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                          onPressed: (){
                            widget.cmd.plats.clear();
                            widget.cmd.boissons.clear();
                            widget.cmd.complements.clear();
                            widget.cmd.listeplat.clear();
                            widget.cmd.listeboisson.clear();
                            widget.cmd.listecomplement.clear();
                            widget.cmd.totalplat = 0.0;
                            widget.cmd.totalboisson = 0.0;
                            widget.cmd.totalcomplement = 0.0;
                            widget.cmd.total = 0.0;
                            Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => Menu(cmd: widget.cmd, caisses: widget.caisses,)));
                          },
                          child: const Text("Annuler", style: TextStyle(fontWeight: FontWeight.bold,)),
                        )
                    ),
                    const Expanded(
                        child: Text(" ")
                    ),
                    Expanded(
                        child: ElevatedButton(
                          onPressed: (){
                            var numero = "${DateTime.now()}";
                            var tailleplat = widget.cmd.plats.length;
                            var tailleboisson = widget.cmd.boissons.length;
                            var taillecomplement = widget.cmd.complements.length;
                            try
                            {
                              ///S'il y a moins de boissons que de plats
                              if(widget.cmd.plats.length > widget.cmd.boissons.length)
                              {
                                for(int i = 0; i < widget.cmd.plats.length; i++)
                                {
                                  widget.cmd.boissons.add(Boissons("","",0.0,"",true));
                                }
                              }
                              ///S'il y a moins de plats que de boissons
                              if(widget.cmd.plats.length < widget.cmd.boissons.length)
                              {
                                for(int i = 0; i < widget.cmd.boissons.length; i++)
                                {
                                  widget.cmd.plats.add(Plats("","",0.0,"","",true));
                                }
                              }
                              ///S'il y a moins de compléments que de plats
                              if(widget.cmd.plats.length > widget.cmd.complements.length || widget.cmd.boissons.length > widget.cmd.complements.length)
                              {
                                for(int i = 0; i < widget.cmd.plats.length; i++)
                                {
                                  widget.cmd.complements.add(Complements("","",0.0, true));
                                }
                              }
                              for(int i = 0; i < widget.cmd.plats.length; i++)
                              {
                                Elements("", 0.0,"",0.0, "", 0.0, "").Enregistrer(utf8.decode(widget.cmd.plats[i].nom.runes.toList()), widget.cmd.plats[i].prix,utf8.decode(widget.cmd.complements[i].nom.runes.toList()), widget.cmd.complements[i].prix, utf8.decode(widget.cmd.boissons[i].nom.runes.toList()), widget.cmd.boissons[i].prix, numero);
                              }
                              Factures(0,0,0,0.0,"","","","").Enregistrer(tailleplat, taillecomplement, tailleboisson, widget.cmd.total, numero, widget.caisses.nom, "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}", "${DateTime.now().hour}:${DateTime.now().minute}");
                              Historiques("",0).newHistorique(widget.caisses.nom);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("La commande a été effectuée.",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              widget.cmd.plats.clear();
                              widget.cmd.boissons.clear();
                              widget.cmd.complements.clear();
                              widget.cmd.listeplat.clear();
                              widget.cmd.listeboisson.clear();
                              widget.cmd.listecomplement.clear();
                              widget.cmd.totalplat = 0.0;
                              widget.cmd.totalboisson = 0.0;
                              widget.cmd.totalcomplement = 0.0;
                              widget.cmd.total = 0.0;
                              Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => Menu(caisses: widget.caisses, cmd: widget.cmd,)));
                            }on Exception {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Une erreur est survenu.",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                          child: const Text("Payer", style: TextStyle(fontWeight: FontWeight.bold,)),
                        )
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}