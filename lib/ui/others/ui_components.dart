import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:multiply/model/list_model.dart';
import 'package:multiply/service/functions_service.dart';
import 'package:multiply/ui/others/colors.dart';
import 'package:multiply/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../view_model/list_view_model.dart';

class UIComponents {
  FunctionsService functions = FunctionsService();

  Widget buildDisplay(int txt) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 36),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.2),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: Colors.white,
            ),
            child: Text(
              functions.numberFormatter(txt),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
        )
      ],
    );
  }

  Widget buildButtons(int increment, int decrement, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 18.0)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(incrementButtonColor),
                  ),
                  onPressed: () {
                    int newAmount = context.read<HomeViewModel>().amount +
                        context.read<HomeViewModel>().increment;
                    context.read<HomeViewModel>().setAmount(newAmount);
                    context.read<HomeViewModel>().readAmount();
                  },
                  child: Text(
                    functions.numberFormatter(increment),
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 18.0)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(decrementButtonColor),
                  ),
                  onPressed: () {
                    int newAmount = context.read<HomeViewModel>().amount -
                        context.read<HomeViewModel>().decrement;
                    context.read<HomeViewModel>().setAmount(newAmount);
                    context.read<HomeViewModel>().readAmount();
                  },
                  child: Text(
                    functions.numberFormatter(decrement),
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> multiplyEditAlert(
      int amount, int increment, int decrement, BuildContext context) async {
    TextEditingController amountController = TextEditingController();
    TextEditingController incrementController = TextEditingController();
    TextEditingController decrementController = TextEditingController();
    List<TextInputFormatter> formatter = [
      FilteringTextInputFormatter.digitsOnly,
    ];
    amountController.text = amount.toString();
    incrementController.text = increment.toString();
    decrementController.text = increment.toString();
    TextInputType keyboard = TextInputType.number;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Edit"),
            content: SizedBox(
              height: 290,
              child: Column(
                children: [
                  TextField(
                    controller: amountController,
                    inputFormatters: formatter,
                    keyboardType: keyboard,
                    decoration: InputDecoration(
                        labelText: "Amount",
                        hintText: "Enter amount",
                        suffix: IconButton(
                            onPressed: () => amountController.text = "",
                            icon: const Icon(Icons.clear))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: incrementController,
                    inputFormatters: formatter,
                    keyboardType: keyboard,
                    style: const TextStyle(color: Colors.green),
                    decoration: InputDecoration(
                        labelText: "Increment sum",
                        labelStyle: const TextStyle(color: Colors.green),
                        hintText: "Enter increment sum",
                        hintStyle: const TextStyle(color: Colors.green),
                        suffix: IconButton(
                            onPressed: () => incrementController.text = "",
                            icon: const Icon(Icons.clear))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: decrementController,
                    inputFormatters: formatter,
                    keyboardType: keyboard,
                    style: const TextStyle(color: Colors.red),
                    decoration: InputDecoration(
                        labelText: "Decrement sum",
                        labelStyle: const TextStyle(color: Colors.red),
                        hintText: "Enter decrement sum",
                        hintStyle: const TextStyle(color: Colors.red),
                        suffix: IconButton(
                            onPressed: () => decrementController.text = "",
                            icon: const Icon(Icons.clear))),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                child: const Text(
                  "edit",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  bool correct = false;
                  if (amountController.text.isNotEmpty) {
                    context
                        .read<HomeViewModel>()
                        .setAmount(int.parse(amountController.text));
                    correct = true;
                  }

                  if (incrementController.text.isNotEmpty) {
                    context
                        .read<HomeViewModel>()
                        .setIncrement(int.parse(incrementController.text));
                    correct = true;
                  }

                  if (decrementController.text.isNotEmpty) {
                    context
                        .read<HomeViewModel>()
                        .setDecrement(int.parse(decrementController.text));
                    correct = true;
                  }

                  if (correct) {
                    Navigator.pop(context);
                    context.read<HomeViewModel>().readAll();
                  }
                },
              ),
            ],
          );
        });
  }

  Future<void> deleteWarningAlert(int id, int position ,BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: const [
              Icon(
                Icons.warning,
                color: Colors.red,
              ),
              SizedBox(width: 8),
              Text("Warning"),
            ],
          ),
          content: const Text(
              "Are you sure that you want to delete it? Then it can't be reversed."),
          actions: [
            TextButton(
              onPressed: () {
                context.read<ListViewModel>().listItems[position].isDeleted = false;
                context.read<ListViewModel>().notifyListeners();
                Navigator.pop(context);
              },
              child: const Text(
                "No",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<ListViewModel>().deleteItem(id);
                context.read<ListViewModel>().readItems();
                Navigator.pop(context);
              },
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> listAddEditAlert(
      ListModel listModel, bool isEdit, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController controller = TextEditingController();
          controller.text = isEdit ? listModel.title : "";
          return AlertDialog(
            title: Text(isEdit ? "Edit" : "Create"),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                  labelText: "Title", hintText: "Enter title"),
            ),
            actions: [
              TextButton(
                child: const Text("cancel", style: TextStyle(color: Colors.red),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(isEdit ? "edit" : "create", style: TextStyle(color: Colors.green),),
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    listModel.title = controller.text;
                    if (isEdit) {
                      context.read<ListViewModel>().updateItem(listModel);
                    } else {
                      context.read<ListViewModel>().addItem(listModel);
                    }
                    Navigator.pop(context);
                    context.read<ListViewModel>().readItems();
                  }
                },
              ),
            ],
          );
        });
  }

  Widget buildListItem(
      ListModel listModel, int position, BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: listModel.isDeleted ? Colors.grey : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(3, 3),
            blurRadius: 2,
            spreadRadius: 2,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          listAddEditAlert(listModel, true, context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                child: Row(
              children: [
                buildStick(),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  listModel.title,
                  style: const TextStyle(color: Colors.black54, fontSize: 20),
                ),
              ],
            )),
            SizedBox(
              child: Row(
                children: [
                  Checkbox(
                      value: listModel.isClicked == 1 ? true : false,
                      onChanged: (value) {
                        listModel.isClicked = value! ? 1 : 0;
                        context.read<ListViewModel>().updateItem(listModel);
                        context.read<ListViewModel>().readItems();
                      }),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListItem2(
      ListModel listModel, int position, BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
              backgroundColor: Colors.redAccent,
              icon: Icons.delete,
              label: "Delete",
              onPressed: (context) {
                deleteWarningAlert(listModel.id, position,context);
              }),
        ],
      ),
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
              backgroundColor: Colors.redAccent,
              icon: Icons.delete,
              label: "Delete",
              onPressed: (context) {
                deleteWarningAlert(listModel.id, position,context);
              }),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          listAddEditAlert(listModel, true, context);
        },
        child: Container(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(3, 3),
                blurRadius: 2,
                spreadRadius: 2,
              ),
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  child: Row(
                children: [
                  buildStick(),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    listModel.title,
                    style: const TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                ],
              )),
              SizedBox(
                child: Row(
                  children: [
                    Checkbox(
                        value: listModel.isClicked == 1 ? true : false,
                        onChanged: (value) {
                          listModel.isClicked = value! ? 1 : 0;
                          context.read<ListViewModel>().updateItem(listModel);
                          context.read<ListViewModel>().readItems();
                        }),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListItem3(
      ListModel listModel, int position, BuildContext context) {
    return Dismissible(
      key: Key(""),
      onDismissed: (_) {
        context.read<ListViewModel>().listItems[position].isDeleted = true;
        deleteWarningAlert(listModel.id, position,context);
      },
      child: GestureDetector(
        onTap: () {
          listAddEditAlert(listModel, true, context);
        },
        child: Container(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(3, 3),
                blurRadius: 2,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    buildStick(),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      listModel.title,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  children: [
                    Checkbox(
                      value: listModel.isClicked == 1 ? true : false,
                      onChanged: (value) {
                        listModel.isClicked = value! ? 1 : 0;
                        context
                            .read<ListViewModel>()
                            .updateItem(listModel);
                        context.read<ListViewModel>().readItems();
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildStick() {
    return Container(
      width: 8,
      decoration: const BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
    );
  }
}
