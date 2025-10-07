import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:shop_app27/models/product_model.dart';
import 'package:shop_app27/screens/user_panel/products_deatils_screen.dart';
import '../../models/categories_model.dart';
import '../../utils/app_constant.dart';

class SingleCategoryProducts extends StatefulWidget {
  String categoryId;
  SingleCategoryProducts({super.key, required this.categoryId});

  @override
  State<SingleCategoryProducts> createState() => _SingleCategoryProductsState();
}

class _SingleCategoryProductsState extends State<SingleCategoryProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('products'),
      ),

      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("products")
            .where('categoryId', isEqualTo: widget.categoryId)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 5,
              child: Center(child: CupertinoActivityIndicator()),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No category found"));
          }
          if (snapshot.data != null) {
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                childAspectRatio: 1.19,
              ),
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                ProductModel productModel = ProductModel(
                  productId: productData['productId'],
                  categoryId: productData['categoryId'],
                  productName: productData['productName'],
                  categoryName: productData['categoryName'],
                  salePrice: productData['salePrice'],
                  fullPrice: productData['fullPrice'],
                  productImages: productData['productImages'],
                  deliveryTime: productData['deliveryTime'],
                  isSale: productData['isSale'],
                  productDescription: productData['productDescription'],
                  createdAt: productData['createdAt'],
                  updatedAt: productData['updatedAt'],
                );
                // CategoriesModel categoriesModel = CategoriesModel(
                //   categoryId: snapshot.data!.docs[index]["CategoryId:"],
                //   categoryImg: snapshot.data!.docs[index]["categoryImg:"],
                //   categoryName: snapshot.data!.docs[index]["categoroyName:"],
                //   createdAt: snapshot.data!.docs[index]["createAt"],
                //   updatedAt: snapshot.data!.docs[index]["updatedAt"],
                //);
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(
                        () => ProductDetailsScreen(productModel: productModel,),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          child: FillImageCard(
                            borderRadius: 20,
                            width: Get.width / 2.3,
                            heightImage: Get.height / 12,
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
                              ),
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
