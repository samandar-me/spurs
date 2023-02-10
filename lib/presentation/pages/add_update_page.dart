import 'package:cleanutter/domain/model/club.dart';
import 'package:cleanutter/presentation/bloc/detail/detail_bloc.dart';
import 'package:cleanutter/presentation/bloc/detail/detail_state.dart';
import 'package:cleanutter/presentation/widgets/loading_widget.dart';
import 'package:cleanutter/presentation/widgets/snackbar_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../widgets/form_widget.dart';

class AddUpdatePage extends StatelessWidget {
  final bool isForUpdate;
  final Club? club;
  const AddUpdatePage({Key? key, required this.isForUpdate, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isForUpdate ? 'Edit Club' : 'Add Club')),
      body: _buildBody(),
    );
  }
  Widget _buildBody() {
    return Center(
      child: Padding(
        padding:const  EdgeInsets.all(10),
        child: BlocConsumer<DetailBloc, DetailState>(
          listener: (context, state) {
            if(state is MessageDetailState) {
              SnackBarMessage().showSuccessSnackBar(message: state.message, context: context);
              Navigator.pop(context);
            } else if (state is ErrorDetailState) {
              SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
            }
          },
          builder: (context, state) {
            if (state is LoadingDetailState) {
              return const LoadingWidget();
            }
            return FormWidget(
                isForUpdate: isForUpdate, club: isForUpdate ? club : null
            );
          },
        ),
      ),
    );
  }
}
