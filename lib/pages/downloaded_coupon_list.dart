import 'package:flutter/material.dart';

import '../main.dart';
import 'coupon_detail.dart';
import 'news_detail.dart';

class DownloadedCouponList extends StatelessWidget {
  const DownloadedCouponList({super.key});

  Future<List> getDownloadedCouponList() async {
    final userId = supabase.auth.currentUser!.id;
    final resp =
        await supabase.rpc('get_downloaded_coupons', params: {'my_id': userId});
    print(resp);

    return resp;
  }

  @override
  Widget build(BuildContext context) {
    late String userInfo = supabase.auth.currentUser.toString();
    final userId = supabase.auth.currentUser!.id;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // news
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder<List>(
                  future: getDownloadedCouponList(),
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        final item = snapshot.data![index];
                        // final pItem = RestaurantModel.fromJson(json: item);

                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CouponDetail(
                                      id: item['row_num'], item: item),
                                ),
                              );
                            },
                            child: Row(children: [
                              Text(item['store_name'].toString()),
                              Text(item['title'].toString()),
                              Text(item['detail'].toString()),
                              Text(item['subcategory_name'].toString()),
                              //Text(item['news_images'] != null ? item['news_images'].split(",")[0] : "")
                            ]));
                      },
                      separatorBuilder: (_, index) {
                        return SizedBox(
                          height: 16,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
