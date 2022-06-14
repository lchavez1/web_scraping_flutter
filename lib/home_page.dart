import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:web_scraping_flutter/models/offer.dart';
import 'package:web_scraping_flutter/widgets/offer_widget.dart';

class HomePage extends StatefulWidget{

  //Esta keyword sera la que se buscara en el sitio.
  final String keyword;
  HomePage({this.keyword = 'electronico'});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //En esta lista guardaremos cada una de las ofertas encontradas.
  List<Offer> offers = [];

  @override
  void initState() {
    super.initState();
    getWebsiteInfo();
  }

  //Metodo para hacer web scraping
  Future getWebsiteInfo() async {

    //Definimos url y hacemos una peticion a ella.
    final url = Uri.parse("https://listado.mercadolibre.com.mx/${widget.keyword}");
    final response = await http.get(url);

    //Generamos un html con la respuesta que obtuvimos.
    dom.Document html = dom.Document.html(response.body);

    //Guardamos en modo de lista los titulos que encontramos en este html.
    final titleList = html.
        querySelectorAll('a > h2')
        .map((e) => e.innerHtml.trim())
        .toList();

    //Guardamos en modo de lista las imagenes que encontramos en este html.
    final imageList = html.
    querySelectorAll('div > img')
        .map((e) => e.attributes['data-src'])
        .toList();

    //Guardamos en modo de lista los url que encontramos en este html.
    final urlList = html.
    querySelectorAll('div > div > section > ol > li > div > div > div > div > a')
        .map((e) => e.attributes['href'])
        .toList();

    //Generamos las instancias de nuestro modelo Offer con los datos obtenidos.
    setState(() {
      offers = List.generate(titleList.length, (index) => Offer(titleList[index],imageList[index].toString(), urlList[index].toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Web Scraping - Mercado Libre'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          return OfferWidget(offer);
        },
      ),
    );
  }
}

