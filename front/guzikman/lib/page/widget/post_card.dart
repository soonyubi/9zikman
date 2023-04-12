import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // navigate to detail page
        },
        child: Column(
          children: [
            SizedBox(height: 10),
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    CircleAvatar(),
                    SizedBox(width: 10),
                    Text("nickname.lv3"),
                  ]),
                  SizedBox(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Main Text",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text("sub text")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text("약속잡기"),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("이 사람 팔로우"),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.ads_click_rounded, size: 20),
                          SizedBox(width: 5),
                          Text(
                            "3",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                      Text(
                        "3 시간 전",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      PopupMenuButton(itemBuilder: (BuildContext context) {
                        return const [
                          PopupMenuItem(
                            child: Text("나중에 보기"),
                          ),
                          PopupMenuItem(
                            child: Text("신고하기"),
                          ),
                        ];
                      })
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
