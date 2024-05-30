import 'package:flutter/material.dart';
import 'package:login_localmarket/pages/coupon_detail.dart';
import 'package:login_localmarket/pages/downloaded_coupon_list.dart';
import 'package:login_localmarket/pages/news_detail.dart';
import 'package:login_localmarket/pages/news_list.dart';
import 'package:login_localmarket/pages/store_detail.dart';
import 'package:login_localmarket/pages/store_list.dart';
import 'package:login_localmarket/pages/story_list.dart';

import '../main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<List> getNews() async {
    // 거리순, 최신순 동네소식5
    final resp = await supabase.rpc('select_recent_news',
        params: {'my_lat': 37.4839901, 'my_lng': 126.9014494});
    print(resp);
    return resp;
  }

  Future<List> getCoupons() async {
    final user_id = await supabase.auth.currentUser!.id;
    // 거리순, 최신순 쿠폰5
    // TODO:: 기준 좌표(내위치)가 없으면 null을 사용
    final resp = await supabase.rpc('select_recent_coupons', params: {
      'my_lat': 37.4839901,
      'my_lng': 126.9014494,
      'my_id': user_id
    });
    print(resp);
    return resp;
  }

  Future<List> getStores() async {
    final user_id = await supabase.auth.currentUser!.id;
    // 거리순, 최신순 상점5
    // TODO:: 기준 좌표(내위치)가 없으면 null을 사용
    final resp = await supabase.rpc('select_recent_stores', params: {
      'my_lat': 37.4839901,
      'my_lng': 126.9014494,
      'my_id': user_id
    });
    print(resp);
    return resp;
  }

  @override
  Widget build(BuildContext context) {
    late String userInfo = supabase.auth.currentUser.toString();
    final userId = supabase.auth.currentUser!.id;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // page moving
              Row(
                children: [
                  ElevatedButton(onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => NewsList(),
                      ),
                    );
                  }, child: Text('news')),
                  ElevatedButton(onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => StoreList(),
                      ),
                    );
                  }, child: Text('store')),
                  ElevatedButton(onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => StoryList(),
                      ),
                    );
                  }, child: Text('story')),
                  ElevatedButton(onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DownloadedCouponList(),
                      ),
                    );
                  }, child: Text('downloaded Coupons'))
                ],
              ),
      
              // news
              Text('뉴스목록'),
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => NewsDetail(id: item['news_id'], item: item),
                                  ),
                                );
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
      
              // coupons
              Text('쿠폰목록'),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder<List>(
                    future: getCoupons(),
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
                                    builder: (_) => CouponDetail(id: item['coupon_id'], item: item,),
                                  ),
                                );
                              },
                              child: Row(
      
                                  children: [
                                Text(item['title'].toString()),
                                Text(item['remain_quantity'].toString()),
                                Text(item['start_dt'].toString()),
                                Text(item['end_dt'].toString()),
                                Text(item['store_name'])
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
      
              // stores
              Text('상점목록'),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder<List>(
                    future: getStores(),
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
                                    builder: (_) => StoreDetail(id: item['store_id'], item: item),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(item['store_name'].toString()),
                                  Text(item['is_picked'].toString()),
                                  // Text(item['address'].toString()),
                                  // Text(item['note'].toString()),
                                  Text(item['subcategory_name'].toString()),
                                  Text(item['pick_count'].toString()),
                                  Text(item['news_count'].toString()),
                                  Text(item['coupon_count'].toString()),
                                  ElevatedButton(onPressed: () async {
                                    if(item['is_picked'].toString() == 'false') {
                                      // pick 안된 상태
                                      await supabase.from('picks').upsert({
                                        'user_id': userId,
                                        'store_id' : item['store_id'],
                                        'pick_yn' : true
                                      });
                                    } else if(item['is_picked'].toString() == 'true') {
                                      // pick 된 상태
                                      await supabase.from('picks').update({
                                        'pick_yn' : false}).eq('user_id', userId).eq('store_id', item['store_id']);
                                    }
      
                                    // TODO:: data reload
      
                                  }, child: Text('pick'))
                                ],
                              ));
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
          )),
    );
  }
}
