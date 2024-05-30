import 'package:flutter/material.dart';
import 'package:login_localmarket/pages/store_detail.dart';

import '../main.dart';

class StoreList extends StatelessWidget {
  const StoreList({super.key});

  Future<List> getStores() async {
    final userId = supabase.auth.currentUser!.id;
    // lat, lng, uuid
    // get_stores
    final resp = await supabase.rpc('get_stores',
        params: {'my_lat': 37.4839901, 'my_lng': 126.9014494, 'my_id': userId});
    print(resp);
    return resp;
  }

  Future<List> getStoresWithCategory() async {
    final userId = supabase.auth.currentUser!.id;
    // lat, lng, uuid, category(category_id)
    // get_stores_with_category
    final resp = await supabase.rpc('get_stores_with_category',
        params: {'my_lat': 37.4839901, 'my_lng': 126.9014494, 'my_id': userId, 'my_category': '00900000'});
    print(resp);
    return resp;
  }

  Future<List> getStoresWithNote() async {
    final userId = supabase.auth.currentUser!.id;
    // lat, lng, uuid, note
    // get_stores_with_category
    final resp = await supabase.rpc('get_stores_with_note',
        params: {'my_lat': 37.4839901, 'my_lng': 126.9014494, 'my_id': userId, 'my_note': '학원'});
    print(resp);
    return resp;
  }

  Future<List> getPickedStores() async {
    final userId = supabase.auth.currentUser!.id;
    // lat, lng, uuid
    // get_picked_stores
    final resp = await supabase.rpc('get_picked_stores',
        params: {'my_lat': 37.4839901, 'my_lng': 126.9014494, 'my_id': userId});
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
                  future: getPickedStores(),
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

// lat, lng, uuid
// get_stores


// lat, lng, uuid, category
// get_stores_with_category