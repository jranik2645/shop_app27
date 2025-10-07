import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_card/image_card.dart';
import 'package:shop_app27/screens/user_panel/products_deatils_screen.dart';
import 'package:shop_app27/utils/app_constant.dart';

import '../../models/product_model.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppConstant.appTextColor,
        ),
        backgroundColor: AppConstant.appMainColor,
        title: Text("All  Products",
         style: TextStyle(
           color: AppConstant.appTextColor,
         ),
        ),
        centerTitle: true,
      ),

      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("products")
            .where('isSale', isEqualTo: false)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 4.5,
              child: Center(child: CupertinoActivityIndicator()),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Products found"));
          }
          if (snapshot.data != null) {
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 0.80,
              ),
              itemBuilder: (context, index) {
                final productsData = snapshot.data!.docs[index];
                ProductModel productModel = ProductModel(
                  productId: productsData['productId'],
                  categoryId: productsData['categoryId'],
                  productName: productsData['productName'],
                  categoryName: productsData['categoryName'],
                  salePrice: productsData['salePrice'],
                  fullPrice: productsData['fullPrice'],
                  productImages: productsData['productImages'],
                  deliveryTime: productsData['deliveryTime'],
                  isSale: productsData['isSale'],
                  productDescription: productsData['productDescription'],
                  createdAt: productsData['createdAt'],
                  updatedAt: productsData['updatedAt'],
                );

                // CategoriesModel categoriesModel = CategoriesModel(
                //   categoryId: snapshot.data!.docs[index]["CategoryId:"],
                //   categoryImg: snapshot.data!.docs[index]["categoryImg:"],
                //   categoryName: snapshot.data!.docs[index]["categoroyName:"],
                //   createdAt: snapshot.data!.docs[index]["createAt"],
                //   updatedAt: snapshot.data!.docs[index]["updatedAt"],
                // );
                return Row(
                  children: [
                    GestureDetector(
                      onTap: ()=>Get.to(()=>ProductDetailsScreen(
                          productModel: productModel

                      )),

                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          child: FillImageCard(
                            borderRadius: 20,
                            width: Get.width / 2.3,
                            heightImage: Get.height / 6,
                            imageProvider: CachedNetworkImageProvider(
                              productModel.productImages[0],
                            ),
                            title: Center(
                              child: Text(
                                productModel.productName,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            footer: Center(
                              child: Text("Price:${productModel.fullPrice}"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
