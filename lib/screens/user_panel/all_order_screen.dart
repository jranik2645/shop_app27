import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app27/controllers/cart_price_controller.dart';
import 'package:shop_app27/utils/app_constant.dart';
import '../../models/order_model.dart';
import 'add_review_screen.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({super.key});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  final ProductPriceController productPriceController = Get.put(
    ProductPriceController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("All Order"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .doc(user!.uid)
            .collection('confirmOrder')
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
                  OrderModel orderModel = OrderModel(
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
                    customerId: productsData['customerId'],
                    status: productsData['status'],
                    customerName: productsData['customerId'],
                    customerPhone: productsData['customerPhone'],
                    customerAddress: productsData['customerAddress'],
                    customerDeviceToken: productsData['customerDeviceToken'],
                  );

                  ///calculate price
                  productPriceController.fetchProductPrice();
                  return Card(
                    elevation: 0,
                    color: AppConstant.appMainColor,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppConstant.appMainColor,
                        backgroundImage: NetworkImage(
                          orderModel.productImages[0],
                        ),
                      ),
                      title: Text(orderModel.productName),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(orderModel.productTotalPrice.toString()),

                          SizedBox(width: 10),

                          orderModel.status != true
                              ? Text(
                                  "Pending",
                                  style: TextStyle(color: Colors.green),
                                )
                              : Text(
                                  "Delivered",
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                        ],
                      ),
                      trailing: orderModel.status == true
                          ? ElevatedButton(
                              onPressed: () => Get.to(() => AddReviewScreen(
                                orderModel:orderModel,
                              )),
                              child: Text("Review"),
                            )
                          : SizedBox.shrink(),
                    ),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
