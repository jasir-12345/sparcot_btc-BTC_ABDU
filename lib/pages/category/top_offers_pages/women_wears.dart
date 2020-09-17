import 'dart:async';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparcotbtc/pages/home.dart';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

// My Own Imports
import 'package:sparcotbtc/pages/category/top_offers_pages/get_products.dart';
import 'package:sparcotbtc/Animation/slide_left_rout.dart';
import 'package:sparcotbtc/pages/cart.dart';
import 'package:sparcotbtc/pages/wishlist.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sparcotbtc/utils/constants.dart';

import '../../login.dart';

class WomensWear extends StatefulWidget {
  final title;
  final objCondition;
  bool progress = true;
  WomensWear(this.title, this.objCondition);

  @override
  _WomensWearState createState() => _WomensWearState();
}

class _WomensWearState extends State<WomensWear> {
  bool progress = true;

  var arrProductLists = [];

  @override
  void initState() {
    super.initState();
    this.getProductList(widget.objCondition);
  }

  Future<String> getProductList(objCondition) async {
    String url = baseUrl + strOpenPort + strProductListEndPoint;
    var response = await http.post(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json", "strAppInfo": strAppInfo},
        body: jsonEncode(<String, dynamic>{...objCondition}));
    var convertDataToJson = await json.decode(response.body);
    setState(() {
      arrProductLists = convertDataToJson['arrList'];
      progress = false;
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    var arrSelectedBrands = widget.objCondition["arrBrands"] != null
            ? widget.objCondition["arrBrands"]
            : [],
        arrSelectedCategory = widget.objCondition["arrCategory"] != null
            ? widget.objCondition["arrCategory"]
            : [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.title),
        titleSpacing: 0.0,
        actions: <Widget>[
//          IconButton(
//            icon: Icon(
//              Icons.favorite,
//              color: Colors.white,
//            ),
//            onPressed: () {
//              Navigator.push(context, SlideLeftRoute(page: WishlistPage()));
//            },
//          ),
          IconButton(
            icon: Badge(
             // badgeContent: Text('3'),
              badgeColor: Theme.of(context).primaryColorLight,
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              SharedPreferences prefs;
              prefs = await SharedPreferences.getInstance();
              if (prefs.getString("userToken") == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              } else {
                print('true');

                Navigator.push(context, SlideLeftRoute(page: CartPage()));
              }

            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF1F3F6),
      body: (progress)
          ? Center(
              child: SpinKitFoldingCube(
                color: Theme.of(context).primaryColor,
                size: 35.0,
              ),
            )
          : (arrProductLists.length != 0
              ? GetProducts(
                  arrProductLists, arrSelectedBrands, arrSelectedCategory)
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.shoppingBasket,
                        color: Colors.grey,
                        size: 60.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'No Products Founds',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      FlatButton(
                        child: Text(
                          'Go Back',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                )),
    );
  }
}
