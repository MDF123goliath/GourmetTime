import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gourmettime/classes/Plats.dart';

class Description extends StatefulWidget {
  const Description({super.key, required this.plats});

  final Plats plats;

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {

  late final Plats plat = Plats("","",0.0,"","",true);

  @override
  Widget build(BuildContext context) {
    plat.url.GetUrl();
    plat.url.GetPortAliment();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Description : ${utf8.decode(widget.plats.nom.runes.toList())}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width/15, color: Colors.white)),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/2.5,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage("${plat.url.url}${plat.url.portServiceAliment}/images/${widget.plats.image}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height/2.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orange,
                boxShadow: [BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(1.0),
                    offset: const Offset(10,10)
                )]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(utf8.decode(widget.plats.nom.runes.toList()), style: TextStyle(fontSize: MediaQuery.of(context).size.width/12, fontWeight: FontWeight.bold, color: Colors.white)),
                const Padding(padding: EdgeInsets.all(5)),
                Text(utf8.decode(widget.plats.description.runes.toList()), style: TextStyle(fontSize: MediaQuery.of(context).size.width/20, color: Colors.white)),
                const Padding(padding: EdgeInsets.all(5)),
                Text("Prix : ${widget.plats.prix} XAF", style: TextStyle(fontSize: MediaQuery.of(context).size.width/15, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
