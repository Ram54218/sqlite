import 'package:flutter/material.dart';
import 'package:sqlite/app_constant/app_constant.dart';
import 'package:sqlite/app_model/app_model.dart';
import 'package:sqlite/person_detail/person_controller.dart';
import 'package:sqlite/widget/cm_textedit_field.dart';
import 'package:sqlite/widget/common_widget.dart';

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  PersonController personController = PersonController();
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController district = TextEditingController();

  @override
  void initState() {
    getPersonDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("homepage".toUpperCase()),
      ),
      body: AppConstant.personList.isNotEmpty
          ? homeWidget(context)
          : const Center(
              child: Text(
              "No Records Found",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addPersonWidget(context, true);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  homeWidget(BuildContext context) {
    return ListView.builder(
        itemCount: AppConstant.personList.length,
        itemBuilder: (context, index) {
          return listViewWidget(index);
        });
  }

  listViewWidget(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Icon(
                Icons.account_circle,
                size: 40.0,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppConstant.personList[index].name!,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                        color: Colors.green),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    AppConstant.personList[index].mobileNumber!.toString(),
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis, fontSize: 16.0),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setControllerValue(AppConstant.personList[index]);
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 40.0,
                      color: Colors.cyan,
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await personController
                          .deletePerson(AppConstant.personList[index].id!);
                      getPersonDetails();
                    },
                    child: const Icon(
                      Icons.delete,
                      size: 40.0,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

// this method used for both "Add person" and "Edit person".
// "isAdd" == true means add the person.
// "isAdd" == false means Edit the person.
// "id" is an optional parameter for "Edit Person" with their ID.

  addPersonWidget(BuildContext context, bool isAdd, [int? id]) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                top: 10.0,
                left: 10.0,
                right: 10.0,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: (Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  isAdd
                      ? const Text(
                          'Add Person',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        )
                      : const Text(
                          'Edit Person',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                  const SizedBox(height: 20.0),
                  CmTextEditField(textController: name, labelText: 'Name'),
                  const SizedBox(height: 10.0),
                  CmTextEditField(textController: gender, labelText: 'Gender'),
                  const SizedBox(height: 10.0),
                  CmTextEditField(
                      textController: address, labelText: 'Address'),
                  const SizedBox(height: 10.0),
                  CmTextEditField(textController: dob, labelText: 'DOB'),
                  const SizedBox(height: 10.0),
                  CmTextEditField(
                      textController: emailAddress, labelText: 'Email Address'),
                  const SizedBox(height: 10.0),
                  CmTextEditField(
                      textController: mobileNo, labelText: 'Mobile No'),
                  const SizedBox(height: 10.0),
                  CmTextEditField(textController: state, labelText: 'State'),
                  const SizedBox(height: 10.0),
                  CmTextEditField(
                      textController: district, labelText: 'District'),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                      onPressed: () {
                        saveData(isAdd, id);
                      },
                      child:
                          isAdd ? const Text('Submit') : const Text('Update'))
                ],
              )),
            ),
          );
        });
  }

  saveData(bool isAdd, [int? id]) async {
    PersonDetail personDetail = PersonDetail(
        name: await personController.encryption(name.text, true),
        gender: await personController.encryption(gender.text, true),
        address: await personController.encryption(address.text, true),
        dob: await personController.encryption(dob.text, true),
        emailAddress:
            await personController.encryption(emailAddress.text, true),
        mobileNumber: await personController.encryption(mobileNo.text, true),
        state: await personController.encryption(state.text, true),
        district: await personController.encryption(district.text, true));
    if (isAdd) {
      personController.addPersonDetails(personDetail);
    } else {
      personDetail.id = id;
      personController.updatePerson(personDetail);
    }
    clearController(); // clear the controller value
  }

  getPersonDetails() async {
    List<PersonDetail> personDetail = await personController.getPersonDetail();
    setState(() {
      AppConstant.personList = personDetail;
    });
  }

  clearController() {
    name.clear();
    gender.clear();
    address.clear();
    dob.clear();
    emailAddress.clear();
    mobileNo.clear();
    state.clear();
    district.clear();
    Navigator.pop(context); // close the bottom sheet
    ScaffoldMessenger.of(context)
        .showSnackBar(CommonWidget.showSnackBar("Person Successfully Added"));
    getPersonDetails();
  }

  setControllerValue(PersonDetail personList) async {
    name.text =
        await personController.encryption(personList.name.toString(), false);
    gender.text =
        await personController.encryption(personList.gender.toString(), false);
    address.text =
        await personController.encryption(personList.address.toString(), false);
    dob.text =
        await personController.encryption(personList.dob.toString(), false);
    emailAddress.text = await personController.encryption(
        personList.emailAddress.toString(), false);
    mobileNo.text = await personController.encryption(
        personList.mobileNumber.toString(), false);
    state.text =
        await personController.encryption(personList.state.toString(), false);
    district.text = await personController.encryption(
        personList.district.toString(), false);
    callAddPerson(personList.id);
  }

  callAddPerson(int? id) {
    addPersonWidget(context, false, id);
  }
}
