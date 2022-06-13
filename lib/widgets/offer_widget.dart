import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_scraping_flutter/models/offer.dart';

class OfferWidget extends StatelessWidget{

  Offer offer;
  OfferWidget(this.offer);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => launch(offer.url),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(offer.image, width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.2,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(offer.title, style: Theme.of(context).textTheme.headline3,),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

}