import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:shop_app27/controllers/cart_price_controller.dart';
import 'package:shop_app27/utils/app_constant.dart';
import '../../models/cart_model.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController = Get.put(
    ProductPriceController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("Cart Screen"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("cart")
            .doc(user!.uid)
            .collection('cartOrders')
            .snapshots(),
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
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final productsData = snapshot.data!.docs[index];
                  CartModel cartModel = CartModel(
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
                    productQuantity: productsData['productQuantity'],
                    productTotalPrice: productsData['productTotalPrice'],
                  );

                  ///calculate price
                  productPriceController.fetchProductPrice();
                  return SwipeActionCell(
                    key: ObjectKey(cartModel.productId),
                    trailingActions: [
                      SwipeAction(
                        title: "Delete",
                        forceAlignmentToBoundary: true,
                        performsFirstActionWithFullSwipe: true,
                        onTap: (CompletionHandler handler) async {
                          await FirebaseFirestore.instance
                              .collection('cart')
                              .doc(user!.uid)
                              .collection('cartOrders')
                              .doc(cartModel.productId)
                              .delete();
                        },
                      ),
                    ],
                    child: Card(
                      elevation: 0,
                      color: AppConstant.appMainColor,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppConstant.appMainColor,
                          backgroundImage: NetworkImage(
                            cartModel.productImages[0],
                          ),
                        ),
                        title: Text(cartModel.productName),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("2200"),
                            SizedBox(width: Get.width / 20.0),
                            GestureDetector(
                              onTap: () async {
                                if (cartModel.productQuantity > 1) {
                                  await FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc(user!.uid)
                                      .collection('cartOrders')
                                      .doc(cartModel.productId)
                                      .update({
                                        'productQuantity':
                                            cartModel.productQuantity - 1,
                                        'productTotalPrice': (
                                          double.parse(cartModel.fullPrice) *
                                              (cartModel.productQuantity - 1),
                                        ),
                                      });
                                }
                              },
                              child: GestureDetector(
                                onTap: () async {
                                  if (cartModel.productQuantity > 0) {
                                    await FirebaseFirestore.instance
                                        .collection('cart')
                                        .doc(user!.uid)
                                        .collection('cartOrders')
                                        .doc(cartModel.productId)
                                        .update({
                                          'productQuantity':
                                              cartModel.productQuantity + 1,
                                          'productTotalPrice': (
                                            double.parse(cartModel.fullPrice) +
                                                double.parse(
                                                      cartModel.fullPrice,
                                                    ) *
                                                    (cartModel.productQuantity),
                                          ),
                                        });
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 14.0,
                                  backgroundColor: AppConstant.appMainColor,
                                  child: Text("-"),
                                ),
                              ),
                            ),
                            SizedBox(width: Get.width / 20.0),
                            CircleAvatar(
                              radius: 14.0,
                              backgroundColor: AppConstant.appMainColor,
                              child: Text("+"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );

            //   GridView.builder(
            //   itemCount: snapshot.data!.docs.length,
            //   shrinkWrap: true,
            //   physics: BouncingScrollPhysics(),
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     mainAxisSpacing: 5,
            //     crossAxisSpacing: 5,
            //     childAspectRatio: 0.80,
            //   ),
            //   itemBuilder: (context, index) {
            //     final productsData = snapshot.data!.docs[index];
            //     CartModel cartModel = CartModel(
            //       productId: productsData['productId'],
            //       categoryId: productsData['categoryId'],
            //       productName: productsData['productName'],
            //       categoryName: productsData['categoryName'],
            //       salePrice: productsData['salePrice'],
            //       fullPrice: productsData['fullPrice'],
            //       productImages: productsData['productImages'],
            //       deliveryTime: productsData['deliveryTime'],
            //       isSale: productsData['isSale'],
            //       productDescription: productsData['productDescription'],
            //       createdAt: productsData['createdAt'],
            //       updatedAt: productsData['updatedAt'],
            //       productQuantity: productsData['productQuantity'],
            //       productTotalPrice: productsData['productTotalPrice'],
            //     );
            //
            //     return Row(
            //       children: [
            //         GestureDetector(
            //           // onTap: () => Get.to(
            //           //   () => ProductDeatilsScreen(productmodel: productModel),
            //           // ),
            //           child: Padding(
            //             padding: EdgeInsets.all(8.0),
            //             child: Container(
            //               child: FillImageCard(
            //                 borderRadius: 20,
            //                 width: Get.width / 2.3,
            //                 heightImage: Get.height / 6,
            //                 imageProvider: CachedNetworkImageProvider(
            //                   cartModel.productImages[0],
            //                 ),
            //                 title: Center(
            //                   child: Text(
            //                     cartModel.productName,
            //                     style: TextStyle(
            //                       fontSize: 12.0,
            //                       overflow: TextOverflow.ellipsis,
            //                     ),
            //                     maxLines: 1,
            //                   ),
            //                 ),
            //                 footer: Center(
            //                   child: Text("Price:${cartModel.fullPrice}"),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     );
            //   },
            // );
          }
          return Container();
        },
      ),

      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Text(
                "Total: ${productPriceController.totalPrice.value.toStringAsFixed(1)} TK",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: Container(
                  width: Get.width / 2.0,
                  height: Get.height / 18,
                  decoration: BoxDecoration(
                    color: AppConstant.appScendoryColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => CheckOutScreen());
                    },
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                        color: AppConstant.appTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
