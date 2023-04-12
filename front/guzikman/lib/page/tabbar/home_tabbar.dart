import 'package:flutter/material.dart';

import '../widget/post_card.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 14,
        itemBuilder: ((context, index) {
          return PostCard();
        }));
  }
}
