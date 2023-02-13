import 'package:cleanutter/presentation/bloc/clubs/clubs_bloc.dart';
import 'package:cleanutter/presentation/bloc/clubs/clubs_event.dart';
import 'package:cleanutter/presentation/bloc/clubs/clubs_state.dart';
import 'package:cleanutter/presentation/pages/add_update_page.dart';
import 'package:cleanutter/presentation/widgets/message_widget.dart';
import 'package:cleanutter/presentation/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/clubs_widget.dart';

class ClubsPage extends StatefulWidget {
  const ClubsPage({Key? key}) : super(key: key);

  @override
  State<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClubsBloc>(context).add(GetAllClubsEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Clubs")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: BlocBuilder<ClubsBloc, ClubsState>(
            builder: (context, state) {
              if (state is LoadingClubState) {
                return const LoadingWidget();
              } else if (state is SuccessClubsState) {
                state.clubs.sort((a,b) => a.position.compareTo(b.position));
                return ClubsWidget(clubs: state.clubs);
              } else if (state is ErrorClubsState) {
                return MessageWidget(message: state.message);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const AddUpdatePage(isForUpdate: false,club: null)));
          }, child: const Icon(Icons.add)),
    );
  }
}
