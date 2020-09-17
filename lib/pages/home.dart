import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:badges/badges.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparcotbtc/pages/category/top_offers_pages/women_wears.dart';

// My Own Import
import 'package:sparcotbtc/pages/home_page_component/drawer.dart';
import 'package:sparcotbtc/pages/home_page_component/category_grid.dart';
import 'package:sparcotbtc/pages/home_page_component/best_offer_grid.dart';
import 'package:sparcotbtc/pages/home_page_component/featured_brands.dart';
import 'package:sparcotbtc/pages/home_page_component/block_buster_deal.dart';
import 'package:sparcotbtc/pages/home_page_component/best_of_fashion.dart';
import 'package:sparcotbtc/pages/home_page_component/womens_collection.dart';
import 'package:sparcotbtc/pages/login.dart';
import 'package:sparcotbtc/pages/notifications.dart';
import 'package:sparcotbtc/Animation/slide_left_rout.dart';
import 'package:sparcotbtc/pages/cart.dart';
import 'package:sparcotbtc/pages/search.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sparcotbtc/utils/constants.dart';

class Home extends StatefulWidget {
  final objModuleSettings ;
  final objMasters ;
  final arrBabyCare ;
  final arrKicten ;
  final arrFoodCare ;
  Home(this.objModuleSettings, this.objMasters, this.arrBabyCare, this.arrKicten, this.arrFoodCare,);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
   super.initState();
//    this.getModuleSettings();
//    this.getBabyCare({
//      "intLimit": 4,
//      "intPageNo":0,
//      "arrCategory": ["BABY CARE"]
//    });
//    this.getKichen({
//      "intLimit": 4,
//      "intPageNo":0,
//      "arrCategory": ["KITCHEN COLLECTIONS"]
//    });
//    this.getFoodCare({
//      "intLimit": 4,
//      "intPageNo":0,
//      "arrCategory": ["CLEANING SOLUTIONS"]
//    });
//    this.getmasters();
    setState(() {});
  }
//
//  Future<dynamic> getBabyCare(objCinditions) async {
//    String url = baseUrl + strOpenPort + strProductListEndPoint;
//    var response = await http.post(Uri.encodeFull(url),
//        headers: {"Content-Type": "application/json", "strAppInfo": strAppInfo},
//        body: jsonEncode(<String, dynamic>{
//          ...objCinditions
//        })); //for accepting only json response
//    var convertDataToJson = await json.decode(response.body);
//    arrBabyCare = await convertDataToJson['arrList'];
//    setState(() {});
//  }
//
//  Future<dynamic> getmasters() async {
//    String url = baseUrl + strOpenPort + strGetMasterEndPoint;
//    var response = await http.post(Uri.encodeFull(url),
//        headers: {"Content-Type": "application/json", "strAppInfo": strAppInfo},
//        body: jsonEncode(<String, dynamic>{
//          "arrCollection": [
//            {"strCollection": "cln_category", "intLimit": 10},
//            {"strCollection": "cln_brand", "intLimit": 10}
//          ]
//        })); //for accepting only json response
//    objMasters = await json.decode(response.body);
//    setState(() {});
//    return "Set";
//  }
//
//  Future<dynamic> getKichen(objCinditions) async {
//    String url = baseUrl + strOpenPort + strProductListEndPoint;
//    var response = await http.post(Uri.encodeFull(url),
//        headers: {"Content-Type": "application/json", "strAppInfo": strAppInfo},
//        body: jsonEncode(<String, dynamic>{
//          ...objCinditions
//        })); //for accepting only json response
//    var convertDataToJson = await json.decode(response.body);
//    arrKicten = await convertDataToJson['arrList'];
//    return "Set";
//  }
//
//  Future<dynamic> getFoodCare(objCinditions) async {
//    String url = baseUrl + strOpenPort + strProductListEndPoint;
//    var response = await http.post(Uri.encodeFull(url),
//        headers: {"Content-Type": "application/json", "strAppInfo": strAppInfo},
//        body: jsonEncode(<String, dynamic>{
//          ...objCinditions
//        })); //for accepting only json response
//    var convertDataToJson = await json.decode(response.body);
//    arrFoodCare = await convertDataToJson['arrList'];
//    return "Set";
//  }
//
//  Future<String> getModuleSettings() async {
//    String url = baseUrl + strOpenPort + strModuleSettings;
//    var response = await http.post(Uri.encodeFull(url),
//        headers: {"Content-Type": "application/json", "strAppInfo": strAppInfo},
//        body: jsonEncode(<String, String>{
//          "strModule": "mdl_sparco_home"
//        })); //for accepting only json response
//    setState(() {
//      objModuleSettings = json.decode(response.body);
//      // var arrProductName=objModuleSettings["objFlashSale"]["arrProductName"];
//    });
//    return "Success";
//  }



  @override
  Widget build(BuildContext context) {

    var objModuleSettings = widget.objModuleSettings;
    var objMasters = widget.objMasters;
    var arrBabyCare = widget.arrBabyCare;
    var arrKicten = widget.arrKicten;
    var arrFoodCare = widget.arrFoodCare;
    var arrBannerImages = [];
    if (objModuleSettings != null) {
      if (objModuleSettings["arrBanners"] != null) {
        for (var i = 0; i < objModuleSettings["arrBanners"].length; i++) {
          arrBannerImages.add(
              NetworkImage(objModuleSettings["arrBanners"][i]["strImageUrl"]));
        }
      }
    }
    return    WillPopScope(
        onWillPop: _onBackPressed,
        child:Scaffold(
      backgroundColor: const Color(0xFFF1F3F6),
      appBar: AppBar(
        title: Text(
          'Sparcot',
//          style: TextStyle(
//            fontFamily: 'Pacifico',
//          ),
        ),
        titleSpacing: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
          ),
          IconButton(
            icon: Badge(
           //   badgeContent: Text('2'),
              badgeColor: Theme.of(context).primaryColorLight,
              child: Icon(
                Icons.notifications,
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
                return;
              }
              else{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notifications()),
                );
              }

            },
          ),
          IconButton(
            icon: Badge(
           //   badgeContent: Text('3'),
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

              }
              else{
                Navigator.push(context, SlideLeftRoute(page: CartPage()));
              }

            },
          ),
        ],
      ),

      // Drawer Code Start Here

      drawer: MainDrawer(),

      // Drawer Code End Here
      body: ListView(
        children: <Widget>[
          // Slider Code Start Here
          Container(
            child: SizedBox(
              height: 170.0,
              child: Carousel(
                images: arrBannerImages.length != 0
                    ? arrBannerImages
                    : [AssetImage("assets/slider/0mdlmaster1593662161552.webp")],
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotColor: Colors.lightGreenAccent,
                indicatorBgPadding: 5.0,
                dotBgColor: Colors.purple.withOpacity(0.0),
                boxFit: BoxFit.fill,
                animationCurve: Curves.fastOutSlowIn,
              ),
            ),
          ),
          // Slider Code End Here

          SizedBox(
            height: 5.0,
          ),

          // Category Grid Start Here
          objMasters != null
              ? CategoryGrid(objMasters["cln_category"])
              : Container(),

          // Category Grid End Here

          SizedBox(
            height: 5.0,
          ),

          Divider(
            height: 1.0,
          ),

          SizedBox(
            height: 4.0,
          ),

          // Promotion 1 Start Here
          InkWell(
            onTap: () {
              var objCondition = {
                "arrCategory":["SPARCO DAIRY"]
              };
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        WomensWear('SPARCO DAIRY', objCondition)),
              );
            },
            child: Image(
              image: (objModuleSettings != null &&
                      objModuleSettings["objPromotion"]["strImageUrl"] != null)
                  ? NetworkImage(
                      objModuleSettings["objPromotion"]["strImageUrl"])
                  : AssetImage('assets/promotion/0mdlmaster1594281965461.webp'),
              fit: BoxFit.cover,
            ),
          ),
          // Promotion 1 End Here

          SizedBox(
            height: 5.0,
          ),

          Divider(
            height: 1.0,
          ),

          SizedBox(
            height: 2.0,
          ),

          // Best Offer Grid Start Here

          BestOfferGrid(objModuleSettings!=null?objModuleSettings["arrBestOffer"]:[]),

          // Best Offer Grid End Here
          SizedBox(
            height: 4.0,
          ),
//
//          Divider(
//            height: 1.0,
//          ),
//
//          SizedBox(
//            height: 4.2,
//          ),

          // Top Seller Grid Start Here
          //TopSeller(),
          // Top Seller Grid End Here

//          SizedBox(
//            height: 3.8,
//          ),
//
//          Divider(
//            height: 1.0,
//          ),
//
//          SizedBox(
//            height: 4.0,
//          ),

          // Best Deal Grid Start Here
          //BestDealGrid(),
          // Best Deal Grid End Here

          SizedBox(
            height: 3.8,
          ),

          Divider(
            height: 1.0,
          ),

          SizedBox(
            height: 8.0,
          ),

          // Featured Brand Slider Start Here
          objMasters != null
              ? FeaturedBrandSlider(objMasters["cln_brand"])
              : Container(),
          // Featured Brand Slider End Here

          SizedBox(
            height: 6.0,
          ),

          Divider(
            height: 1.0,
          ),

          SizedBox(
            height: 6.0,
          ),

          // Block Buster Deals Start Here
          arrKicten != null ? BlockBusterDeals(arrKicten) : Container(),
          // Block Buster Deals End Here

          SizedBox(
            height: 6.0,
          ),

          Divider(
            height: 1.0,
          ),

          SizedBox(
            height: 0.0,
          ),

          //Best of Fashion Start Here
          arrBabyCare != null ? BestOfFashion(arrBabyCare) : Container(),
          //Best of Fashion End Here

          SizedBox(
            height: 6.0,
          ),

          Divider(
            height: 1.0,
          ),

          SizedBox(
            height: 0.0,
          ),

          // Womens Collection Start Here
          arrFoodCare != null ? WomensCollection(arrFoodCare) : Container(),
          // Womens Collection End Here

          SizedBox(height: 20.0),
        ],
      ),
    ));
  }
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () =>    SystemNavigator.pop(),
            child: Text("YES"),
          ),
        ],
      ),
    ) ??
        false;
  }
}
