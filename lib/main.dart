import 'package:cleanutter/presentation/bloc/clubs/clubs_bloc.dart';
import 'package:cleanutter/presentation/bloc/clubs/clubs_event.dart';
import 'package:cleanutter/presentation/bloc/detail/detail_bloc.dart';
import 'package:cleanutter/presentation/pages/clubs_page.dart';
import 'package:flutter/material.dart';
import 'di/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ClubsBloc>()..add(GetAllClubsEvent())),
        BlocProvider(create: (_) => di.sl<DetailBloc>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const ClubsPage(),
      ),
    );
  }
}

