import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/list_model.dart';
import '../../service/functions_service.dart';
import '../../view_model/list_view_model.dart';
import '../others/ui_components.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  UIComponents components = UIComponents();
  FunctionsService functions = FunctionsService();
  late ListViewModel viewModel;

  @override
  void initState() {
    viewModel = Provider.of<ListViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.readItems();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Calendar",
          style: TextStyle(color: Colors.black54),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              components.listAddEditAlert(
                  ListModel(id: -1, title: "", isClicked: 0), false, context);
            },
          ),
        ],
      ),
      body: Consumer<ListViewModel>(
        builder: (context, value, child) {
          return value.listItems.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.listItems.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, position) {
                    return components.buildListItem2(
                        value.listItems[position], position, context);
                  })
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            "assets/no_data.png",
                            width: 200,
                            height: 200,
                          ),
                          const SizedBox(height: 20,),
                          Text(
                            "Data has not been added yet",
                            style:
                                TextStyle(fontSize: 22, color: Colors.black87),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10,),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
