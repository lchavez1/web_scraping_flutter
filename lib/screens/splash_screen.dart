import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home_page.dart';
import '../widgets/rounded_input_field.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
                padding: const EdgeInsets.all(8),
                child: Image.network('https://www.antevenio.com/wp-content/uploads/2019/03/web.jpeg', width: MediaQuery.of(context).size.width * 0.6,)
            ),
            Column(
              children: [
                Text('Web Scraping', style: Theme
                    .of(context)
                    .textTheme
                    .headline1,),
                Text('Mercado Libre', style: Theme
                    .of(context)
                    .textTheme
                    .headline2,),
              ],
            ),
            TextField(
              controller: controller,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Keyword',
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage(keyword: controller.text,)));
              },
              elevation: 10,
              minWidth: 170,
              height: 50,
              color: Theme
                  .of(context)
                  .primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('Get started', style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}