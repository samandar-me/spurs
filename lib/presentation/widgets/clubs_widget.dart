import 'package:cleanutter/domain/model/club.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClubsWidget extends StatelessWidget {
  final List<Club> clubs;

  const ClubsWidget({Key? key, required this.clubs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          var club = clubs[index];
          return ListTile(
            leading: Image.network("https://cdne-totv8-prod.azureedge.net/media/40307/spurs-blue-compressed.png"),
            title: Text(club.clubName),
            subtitle: Text(club.shortName),
            trailing:
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            onTap: () {},
          );
        },
        separatorBuilder: (context, index) => const Divider(thickness: 1),
        itemCount: clubs.length);
  }
}
