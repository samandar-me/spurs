import 'package:cleanutter/domain/model/club.dart';
import 'package:cleanutter/presentation/bloc/detail/detail_bloc.dart';
import 'package:cleanutter/presentation/bloc/detail/detail_event.dart';
import 'package:cleanutter/presentation/bloc/detail/detail_state.dart';
import 'package:cleanutter/presentation/pages/clubs_page.dart';
import 'package:cleanutter/presentation/widgets/loading_widget.dart';
import 'package:cleanutter/presentation/widgets/snackbar_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatelessWidget {
  final Club club;

  const DetailPage({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Club Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100),
              Container(
                  height: 100, width: 100, child: Image.network(club.image)),
              SizedBox(height: 20),
              Text(club.clubName,
                  style: const TextStyle(
                      fontSize: 22, color: CupertinoColors.black)),
              SizedBox(height: 20),
              Text("${club.shortName}\n${club.league}\n${club.position}"),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent)),
                onPressed: () => deleteDialog(context),
                icon: Icon(Icons.delete_outline),
                label: Text("Delete"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<DetailBloc, DetailState>(
              listener: (context, state) {
            if (state is MessageDetailState) {
              SnackBarMessage().showSuccessSnackBar(
                  message: state.message, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const ClubsPage()),
                  (route) => false);
            } else if (state is ErrorDetailState) {
              Navigator.pop(context);
              SnackBarMessage()
                  .showErrorSnackBar(message: state.message, context: context);
            }
          }, builder: (context, state) {
            if (state is LoadingDetailState) {
              return const AlertDialog(
                title: LoadingWidget(),
              );
            }
            return AlertDialog(
              title: Text("Do you want to delete?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No")),
                TextButton(
                    onPressed: () {
                      print(club.id);
                      BlocProvider.of<DetailBloc>(context).add(DeleteClubEvent(club.id));
                    },
                    child: Text("Yes")),
              ],
            );
          });
        });
  }
}
