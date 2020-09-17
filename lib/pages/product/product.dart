import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:sparcotbtc/pages/login.dart';

// My Own Imports
import 'package:sparcotbtc/pages/product/product_details.dart';
import 'package:sparcotbtc/pages/order_payment/delivery_address.dart';
import 'package:sparcotbtc/Animation/slide_left_rout.dart';
import 'package:sparcotbtc/pages/cart.dart';
import 'package:sparcotbtc/pages/wishlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sparcotbtc/utils/constants.dart';

class ProductPage extends StatefulWidget {
  final String strDocId;

  ProductPage({Key key, this.strDocId}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool favourite = false;
  int cartItem = 3;
  var objProductDetails = null;
  var objOrder = {};
  var objUserDetails = null;

  @override
  void initState() {
    setState(() {});
    super.initState();
    this.getProductList();
  }

  Future<String> getProductList() async {
    String url = baseUrl + strOpenPort + strProductDetailsEndPoint;
    var response = await http.post(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json", "strAppInfo": strAppInfo},
        body: jsonEncode(<String, String>{
          'strProductId': widget.strDocId
        })); //for accepting only json response
    setState(() {
      objProductDetails = json.decode(response.body);
    });
    return "Success";
  }

  Future<String> getUserDetails() async {
    //get token from shared prefrence
    var prefs = await SharedPreferences.getInstance();
    var strToken = prefs.getString('userToken') ?? "";
    var strDocId = prefs.getString('userId') ?? "";
    String url = baseUrl + strCommonPort + strGetUserDetails;
    var response = await http.post(Uri.encodeFull(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": strToken
        },
        body: jsonEncode(<String, String>{
          'strDocId': strDocId,
          "strType": strType,
          "strTargetType": "COMMON"
        }));
    var objResponse = await json.decode(response.body);
    print("buuuuuuuuuuuuuuuuy");
    print(objResponse);
    if (objResponse["blnAPIStatus"].toString() == "true" && objResponse["arrList"].length>0) {
      objUserDetails = await objResponse["arrList"][0];

      print(objUserDetails);
      setState(() {});
    }

    //for accepting only json response
    return "success";
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var objClsProductDetails = objProductDetails != null
        ? ProductDetails(data: objProductDetails)
        : null;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${objProductDetails != null ? objProductDetails["strName"] : ""}'),
        titleSpacing: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
//          IconButton(
//            icon: Icon(
//              Icons.favorite,
//              color: Colors.white,
//            ),
//            onPressed: () {
//              //Navigator.push(context, SlideLeftRoute(page: WishlistPage()));
//            },
//          ),
          IconButton(
            icon: Badge(
              // badgeContent: Text('$cartItem'),
              badgeColor: Theme.of(context).primaryColorLight,
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            onPressed: ()async {
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

//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => ),
//              );
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF1F3F6),
      body: objClsProductDetails != null ? objClsProductDetails : Container(),
      bottomNavigationBar: Material(
        elevation: 5.0,
        child: Container(
          color: Colors.white,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme(
                minWidth: ((width) / 2),
                height: 50.0,
                child: RaisedButton(
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                  ),
                  onPressed: () async {
                    SharedPreferences prefs;
                    prefs = await SharedPreferences.getInstance();
                    if (prefs.getString("userToken") == null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),


                      );
                      return ;
                    }
                    ////
                    var objSizeAndColorJson =
                        await objClsProductDetails.getColorAndSize();
                    var objSizeAndColor = jsonDecode(objSizeAndColorJson);
                    var blnAPIstatus = await this.createCart(
                        objProductDetails["_id"],
                        objSizeAndColor["objSize"] != null
                            ? objSizeAndColor["objSize"]["strName"].toString()
                            : null,
                        objSizeAndColor["objColor"] != null
                            ? objSizeAndColor["objColor"]["strName"].toString()
                            : null,
                        objSizeAndColor["objColor"] != null
                            ? objSizeAndColor["objColor"]["strColorCode"]
                                .toString()
                            : null);
                    if (blnAPIstatus != null && blnAPIstatus == true) {
                      //cartItem++;
//                      Scaffold.of(context).showSnackBar(
//                          SnackBar(content: Text('Product Added')));
                    } else {
                      _showDialog("Fail", "Add Cart Failed");
//                      Scaffold.of(context)
//                          .showSnackBar(SnackBar(content: Text('Failed')));
                    }
                    _showDialog("Added",
                        objProductDetails["strName"] + "  Added to Your Cart");
                    setState(() {});
                  },
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              ButtonTheme(
                // minWidth: ((width - 60.0) / 2),
                minWidth: ((width) / 2),
                height: 50.0,
                child: RaisedButton(
                  child: Text(
                    'Buy Now',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                  onPressed: () async {
                    SharedPreferences prefs;
                    prefs = await SharedPreferences.getInstance();
                    if (prefs.getString("userToken") == null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );

                      return ;
                    } else {
                      print('true');
                      if (int.parse(
                          objProductDetails["dblTotalStock"].toString()) >
                          0) {
                        objOrder = await {
                          "arrProducts": [{
                              "strName": objProductDetails["strName"],
                              "strImageUrl": objProductDetails["strImageUrl"],
                              "strProductId": objProductDetails["_id"],
                              "dblQty": 1,
                              "dblSellingPrice": objProductDetails["dblSellingPrice"],
                              "strCreatedTime": new DateTime.now().toString()
                            }],
                          "dblTotalOrderAmount":
                          objProductDetails["dblSellingPrice"]
                        };
                        await this.getUserDetails();
                        Navigator.push(
                            context,
                            SlideLeftRoute(
                                page: Delivery(objOrder, objUserDetails)));
                      } else {
                        _showDialog("Out of stock", "Product stoc cleared");
                      }
                    }

                  },
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> createCart(strProductId, strSize, strColor, strColorCode) async {
    String url = baseUrl + strCommonPort + strCreateCart;
    //get token from shared prefrence
    var prefs = await SharedPreferences.getInstance();
    var strToken = prefs.getString('userToken') ?? "";
    var response = await http.post(Uri.encodeFull(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": strToken
        },
        body: jsonEncode(<String, dynamic>{
          'strProductId': strProductId,
          "dblQty": 1,
          "objExtras": {
            "strSize": strSize,
            "strColor": strColor,
            "strColorCode": strColorCode
          },
        })); //for accepting only json response
    var convertDataToJson = json.decode(response.body);
    if (convertDataToJson["blnAPIStatus"].toString() == "true") {
      return true;
    } else {
      return false;
    }
  }

  // user defined function for Logout Dialogue
  void _showDialog(strMessage, strDiscription) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Container(
            height: 250.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Theme.of(context).primaryColor,
                    border: Border.all(
                        color: Theme.of(context).primaryColorLight, width: 5.0),
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  strMessage,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  strDiscription,
                  style: TextStyle(fontSize: 18.0, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        Navigator.pop(context);
      });
    });
  }
}
