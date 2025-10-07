import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class bannersController extends GetxController {
  RxList<String> bannerUrls = RxList<String>([]);

  @override
  void onInit() {
    super.onInit();
    fetchBannersUrls();
  }

  ///fetch banners

  Future<void> fetchBannersUrls() async {
    try {
      QuerySnapshot bannerSnapshot = await FirebaseFirestore.instance
          .collection('banners')
          .get();

      if (bannerSnapshot.docs.isNotEmpty) {
        bannerUrls.value = bannerSnapshot.docs
            .map((doc) => doc['imageurl'] as String)
            .toList();
      }
    } catch (e) {
      print('error $e');
    }
  }
}
