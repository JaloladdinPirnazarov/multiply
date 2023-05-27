import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiply/service/functions_service.dart';
import 'package:multiply/service/shared_preferences_service.dart';
import 'package:multiply/ui/others/colors.dart';
import 'package:multiply/ui/screens/list.dart';
import 'package:multiply/ui/others/ui_components.dart';
import 'package:multiply/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UIComponents components = UIComponents();
  FunctionsService functions = FunctionsService();
  late HomeViewModel viewModel;

  @override
  void initState() {
    viewModel = Provider.of<HomeViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.readAll();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Multiply",
          style: TextStyle(color: Colors.black54),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: () async {
              components.multiplyEditAlert(viewModel.amount, viewModel.increment, viewModel.decrement, context);
            },
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Calendar()));
              },
              icon: const Icon(
                Icons.calendar_month,
                color: Colors.black,
              )),
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          return Container(
            color: homeBackGroundColor,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                components.buildDisplay(value.amount),
                components.buildButtons(
                    value.increment, value.decrement, context),
              ],
            ),
          );
        },
      ),
    );
  }
}
