import 'package:flutter/material.dart';
import 'package:login_localmarket/pages/story_detail.dart';

import '../main.dart';

class StoryList extends StatelessWidget {
  const StoryList({super.key});

  Future<List> getStory() async {
    // 이야기 최신순
    // get_stories
    final resp = await supabase.rpc('get_stories');
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
                  future: getStory(),
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
                                  builder: (_) => StoryDetail(id: item['story_id'], item: item),
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
