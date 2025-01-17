import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About App'),
        titleSpacing: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Sparcot Ecommerce ',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text('Sparcot is a Company registered in Hong Kong and Established in India with over of 2000 products Under its Six Brands',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text('StackaTech Team',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text('Thanks for Installing our App',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black
                    ),
                  ),
                ),

                Divider(height: 1.0,),

                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text('stackateck.com',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.blue
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}