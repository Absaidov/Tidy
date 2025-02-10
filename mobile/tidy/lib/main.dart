import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tidy/Appointments/appointments.dart';
import 'package:tidy/Contacts/сontacts.dart';
import 'package:tidy/Notes/notes.dart';
import 'package:tidy/base_provider.dart';
import 'utils.dart' as utils;

//* Главный виджет MAIN, где стартует приложение
void main() {
  //* Эта строка нужна для работы async  в последних версиях Flutter
  WidgetsFlutterBinding.ensureInitialized();
  startMeUp() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    utils.docsDir = docsDir;
    runApp(const Tidy());
  }

  startMeUp();
}

class Tidy extends StatelessWidget {
  const Tidy({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BaseProvider(),
        )
      ],
      child: MaterialApp(
        home: DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Tidy'),
                bottom: const TabBar(tabs: [
                  Tab(
                    icon: Icon(
                      Icons.date_range,
                    ),
                    text: "Appointments",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.contacts,
                    ),
                    text: "Contacts",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.note,
                    ),
                    text: "Notes",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.assignment_turned_in,
                    ),
                    text: "Tasks",
                  ),
                ]),
              ),
              body: TabBarView(children: [
                const Appointments(),
                const Contacts(),
                Notes(),
                // Tasks(),
              ]),
            )),
      ),
    );
  }
}
