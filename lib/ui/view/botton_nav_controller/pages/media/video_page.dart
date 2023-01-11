import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/ui/route/route.dart';
import 'package:fitness/ui/view/botton_nav_controller/pages/view_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../details/video_details_page.dart';

class MediaVideoPage extends StatefulWidget {
  const MediaVideoPage({Key? key}) : super(key: key);

  @override
  State<MediaVideoPage> createState() => _MediaVideoPageState();
}

class _MediaVideoPageState extends State<MediaVideoPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10.h),
          SizedBox(
            height: 650.h,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('all_products')
                  .orderBy('media_videos', descending: true)
                  .snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;
                  return GridView.builder(
                      itemCount: 3,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (_, i) {
                         final data = docs[i].data();
                        return InkWell(
                          onTap: () {
                                      Get.to(VideoDetailsPage(data));
                                    },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.h, horizontal: 10.w),
                            margin: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 10.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage((data['img'])),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(bottom: 48.h, left: 16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(data['title'],
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Text(data['subtitle'],
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
