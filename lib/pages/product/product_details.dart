import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// My Own Imports
import 'package:sparcotbtc/pages/product/rating_row.dart';
import 'package:sparcotbtc/pages/product/product_size.dart';
import 'package:sparcotbtc/pages/product/get_similar_products.dart';
import 'dart:convert';

class ProductDetails extends StatefulWidget {
  final data;

  ProductDetails({Key key, this.data}) : super(key: key);
  var obj_ProductDetailsState = _ProductDetailsState();

  Future<dynamic> getColorAndSize() {
    return obj_ProductDetailsState.getSizeAndColor();
  }

  @override
  _ProductDetailsState createState() => obj_ProductDetailsState;
}

class _ProductDetailsState extends State<ProductDetails> {
  bool favourite = false;
  Color color = Colors.grey;
  var objProductSizeAndColor = null;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var arrImages = [];
    if (widget.data["arrImageUrl"] != null) {
      var arrImageUrl = widget.data["arrImageUrl"];
      for (var i = 0; i < arrImageUrl.length; i++) {
        arrImages.add(NetworkImage(arrImageUrl[i]));
      }
    }

    objProductSizeAndColor = ProductSize(
        widget.data["arrSizeStock"] != null ? widget.data["arrSizeStock"] : [],
        widget.data["arrColorStock"] != null
            ? widget.data["arrColorStock"]
            : []);
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        // Slider and Add to Wishlist Code Starts Here
        Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 8.0),
              color: Colors.white,
              child: Hero(
                tag: '${widget.data != null ? widget.data["strName"] : ""}',
                child: SizedBox(
                  height: (height / 2.0),
                  child: Carousel(
                    images: arrImages.length != 0
                        ? arrImages
                        : [AssetImage("assets/promotion/promotion1.jpg")],
                    dotSize: 5.0,
                    dotSpacing: 15.0,
                    dotColor: Colors.grey,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.purple.withOpacity(0.0),
                    boxFit: BoxFit.fitWidth,
                    animationCurve: Curves.decelerate,
                    dotIncreasedColor: Colors.blue,
                    overlayShadow: true,
                    overlayShadowColors: Colors.white,
                    overlayShadowSize: 0.7,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20.0,
              right: 20.0,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                elevation: 3.0,
                onPressed: () {
                  setState(() {
                    if (!favourite) {
                      favourite = true;
                      color = Colors.red;

                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("Added to Wishlist")));
                    } else {
                      favourite = false;
                      color = Colors.grey;
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("Remove from Wishlist")));
                    }
                  });
                },
                child: Icon(
                  (!favourite)
                      ? FontAwesomeIcons.heart
                      : FontAwesomeIcons.solidHeart,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        // Slider and Add to Wishlist Code Ends Here
        Container(
            color: Colors.white,
            child: SizedBox(
              height: 8.0,
            )),
        Divider(
          height: 1.0,
        ),

        Container(
          color: Colors.white,
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Product Title Start Here
              Text(
                '${widget.data != null ? widget.data["strName"] : ""}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              // Product Title End Here

              // Special Price badge Start Here
              Container(
                margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: widget.data["dblTotalStock"] != null
                    ? Text(
                        int.parse(widget.data["dblTotalStock"].toString()) < 20
                            ? widget.data["dblTotalStock"].toString() +
                                " items lefts"
                            : "",
                        style:
                            TextStyle(color: Colors.red[800], fontSize: 12.0),
                      )
                    : Container(),
              ),
              // Special Price badge Ends Here.

              // Price & Offer Row Starts Here
              Container(
                margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '₹${widget.data != null ? widget.data["dblSellingPrice"].toString() : ""}',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      '₹${widget.data != null ? widget.data["dblMRP"].toString() : ""}',
                      style: TextStyle(
                          fontSize: 14.0,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      '₹${(int.parse(widget.data["dblMRP"].toString()) - int.parse(widget.data["dblSellingPrice"].toString())).toString()}',
                      style: TextStyle(fontSize: 14.0, color: Colors.red[700]),
                    ),
                  ],
                ),
              ),
              // Price & Offer Row Ends Here

              // Rating Row Starts Here
              //RatingRow(),
              // Rating Row Ends Here
            ],
          ),
        ),

        // Product Size & Color Start Here
        objProductSizeAndColor,
        // Product Size & Color End Here

        // Product Details Start Here
        Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Product Details',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Product ID',
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          'Category',
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          'Brand',
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          'Gender Type',
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.data != null
                              ? widget.data["strProductId"].toString()
                              : "",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          widget.data != null
                              ? widget.data["strCategoryId"].toString()
                              : "",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          widget.data != null
                              ? widget.data["strBrandId"].toString()
                              : "",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          widget.data != null
                              ? widget.data["strGenderCategory"].toString()
                              : "",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Product Details Ends Here

        // Product Description Start Here
        Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.only(top: 5.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Product Description',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                '${widget.data != null ? widget.data["strDescription"].toString() : ""}',
                style: TextStyle(fontSize: 14.0, height: 1.45),
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 5.0),
              Divider(
                height: 1.0,
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'View More',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  _productDescriptionModalBottomSheet(context);
                },
              ),
              Divider(
                height: 1.0,
              ),
            ],
          ),
        ),
        // Product Description Ends Here

        // Similar Product Starts Here
        Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Similar Products',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8.0,
              ),
              SimilarProductsGridView({
                'intLimit': 10 ,
                'intPageNo':0,
                //"arrBrands":["SPARCO"],
                "arrCategory": [widget.data["strCategoryId"]]
              }),
            ],
          ),
        ),
        // Similar Product Ends Here
      ],
    );
  }

  // Bottom Sheet for Product Description Starts Here
  void _productDescriptionModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Container(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Product Description',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Divider(
                          height: 1.0,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          '${widget.data != null ? widget.data["strDescription"].toString() : ""}',
                          style: TextStyle(fontSize: 14.0, height: 1.45),
                          // overflow: TextOverflow.ellipsis,
                          // maxLines: 5,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  getSizeAndColor() async {
    var objColor = await objProductSizeAndColor != null
        ? objProductSizeAndColor.objColor
        : null;
    var objSize = await objProductSizeAndColor != null
        ? objProductSizeAndColor.objSize
        : null;
    return jsonEncode(
        <String, dynamic>{"objColor": objColor, "objSize": objSize});
  }
// Bottom Sheet for Product Description Ends Here
}
