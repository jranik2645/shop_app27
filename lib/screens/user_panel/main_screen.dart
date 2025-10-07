import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shop_app27/screens/user_panel/all_categories_screen.dart';
import 'package:shop_app27/screens/user_panel/all_product_screen.dart';
import 'package:shop_app27/screens/user_panel/cart_screen.dart';
import 'package:shop_app27/services/fcm_services.dart';
import 'package:shop_app27/services/notification_service.dart';
import 'package:shop_app27/services/send_notification_service.dart';
import 'package:shop_app27/utils/app_constant.dart';
import 'package:shop_app27/widgets/banner_widget.dart';
import 'package:shop_app27/widgets/custom_drawer.dart';

import '../../widgets/all_product_widget.dart';
import '../../widgets/category_widget.dart';
import '../../widgets/flash_sale_widget.dart';
import '../../widgets/heading_widget.dart';
import 'all_flash_sale_product.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  NotificationService notificationService = NotificationService();
  @override
  void initState() {
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.getDeviceToken();
    FcmService.firebaseInit();
    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppConstant.appScendoryColor,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          AppConstant.appMainName,
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            // onTap: () => Get.to(() => CartScreen()),
              onTap: ()
              async{
                SendNotificationService.sendNotificationUsingApi(
                    token: '',
                    title: '',
                    body: '',
                    data: {}

                );
              },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: DrawerWidget(),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: Get.height / 90.0),

              ///banner section
              BannerWidget(),

              ///heading
              HeadingWidget(
                headingTitle: 'Categories',
                headingSubTitle: 'According to your budget',
                onTap: () => Get.to(() => AllCategoriesScreen()),
                buttonText: 'See More >',
              ),

              CategoryWidget(),

              ///heading
              HeadingWidget(
                headingTitle: 'Flash Sale',
                headingSubTitle: 'According to your budget',
                onTap: () => Get.to(() => AllFlashSaleProduct()),
                buttonText: 'See More >',
              ),

              FlashSaleWidget(),
              HeadingWidget(
                headingTitle: 'All Products',
                headingSubTitle: 'According to your budget',
                onTap: () => Get.to(() => AllProductScreen()),
                buttonText: 'See More >',
              ),

              AllProductWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
