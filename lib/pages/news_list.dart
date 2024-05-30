import 'package:flutter/material.dart';

import '../main.dart';
import 'coupon_detail.dart';
import 'news_detail.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  Future<List> getNews() async {
    // -- //1. lat, lng
    // -- get_coupons_and_news
    //
    //
    // -- //2. lat, lng, category
    // -- get_coupons_and_news_with_category
    //
    //
    // -- //3. lat, lng, gubun
    // -- get_coupons_and_news_with_gubun
    //
    //
    // -- //4. lat, lng, gubun, category
    // -- get_coupons_and_news_with_gubun_category

    final resp = await supabase.rpc('get_coupons_and_news',
        params: {'my_lat': 37.4839901, 'my_lng': 126.9014494});
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
                  future: getNews(),
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
                              if(item['gubun'] == 'news') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => NewsDetail(id: item['row_num'], item: item),
                                  ),
                                );
                              } else if(item['gubun'] == 'coupon') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => CouponDetail(id: item['row_num'], item: item),
                                  ),
                                );
                              }
                            },
                            child: Row(children: [
                              Text(item['store_name'].toString()),
                              Text(item['title'].toString()),
                              Text(item['address'].toString()),
                              Text(item['subcategory_name'].toString()),
                              Text(item['news_images'] != null ? item['news_images'].split(",")[0] : "")
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


