import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_tape/pages/main_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../DI/dependency-provider.dart';
import '../bloc/main_bloc.dart';
import '../bloc/main_state.dart';
import '../elements/bloc/bloc_screen.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  MainBloc? mainBloc;
  bool isLoading = false;
  bool isGetCode = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocScreen<MainBloc, MainState>(
      bloc: mainBloc,
      listener: _listener,
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Visibility(
                  visible: isLoading,
                  child: Center(
                      child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset('assets/loading.gif'),
                  )))
            ],
          ),
        );
      },
    );
  }

  _listener(BuildContext context, MainState state) {
    isLoading = state.loading!;
    if (state.loading == true) {
      return;
    }
    if (state.alert != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text("Авторизация"),
                content: SizedBox(
                    height: 50,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.alert!,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16.0)),
                        ])),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MainPage()),
                        (route) => false),
                    child: const Text('OK'),
                  ),
                ],
              ));
    }
    if (state.accessTokenUrl != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text("Авторизация"),
                content: SizedBox(
                    height: 100,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Введите код",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 16.0)),
                          TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                                hintText: "000-000-000",
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey))),
                          )
                        ])),
                actions: [
                  TextButton(
                    onPressed: () {
                      mainBloc!.getRequestToken(controller.text);
                      Navigator.pop(context, 'Cancel');
                    },
                    child: const Text('OK'),
                  ),
                ],
              ));
      launchUrl(Uri.parse(state.accessTokenUrl!));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainBloc ??= DependencyProvider.of(context)!.mainBloc;
    mainBloc!.getAccessToken();
  }
}
