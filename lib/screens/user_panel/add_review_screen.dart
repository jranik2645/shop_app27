import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shop_app27/models/order_model.dart';
import 'package:shop_app27/models/review_model.dart';
import 'package:shop_app27/utils/app_constant.dart';

class AddReviewScreen extends StatefulWidget {
  final OrderModel orderModel;
  const AddReviewScreen({super.key, required this.orderModel});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  TextEditingController feedbackController = TextEditingController();

  double productRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("Add Reviews"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Add your rating and review"),
            SizedBox(height: Get.height / 16),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) =>
                  Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                productRating = rating;
                print(rating);
                setState(() {});
              },
            ),
            SizedBox(height: Get.height / 16),
            Text("Feedback"),
            SizedBox(height: Get.height / 16),
            TextFormField(
              controller: feedbackController,
              decoration: InputDecoration(label: Text("Share your feedback")),
            ),
            SizedBox(height: Get.height / 16),
            ElevatedButton(
              onPressed: () async{
                EasyLoading.show(status: "Please Wait");
                String feedback = feedbackController.text.trim();
                User? user = FirebaseAuth.instance.currentUser;

                // print(productRating);

                ReviewModel reviewModel = ReviewModel(
                  customerName: widget.orderModel.customerName,
                  customerPhone: widget.orderModel.customerPhone,
                  customerDeviceToken: widget.orderModel.customerDeviceToken,
                  customerId: widget.orderModel.customerId,
                  feedback: feedback,
                  rating: productRating.toString(),
                  createdAt: widget.orderModel.createdAt,
                );

              await  FirebaseFirestore.instance
                    .collection('products')
                    .doc(widget.orderModel.productId)
                    .collection('review')
                    .doc(user!.uid)
                    .set(reviewModel.toMap());

               EasyLoading.dismiss();
              },
              child: Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}
