import 'package:flutter/material.dart';
import 'package:sqlite/app_model/app_model.dart';
import 'package:sqlite/widget/common_widget.dart';

class PersonDetailScreen extends StatelessWidget {
  final PersonDetail personDetail;

  const PersonDetailScreen({super.key, required this.personDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person Detail'),
      ),
      body: homeWidget(context),
    );
  }

  Widget homeWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100.0))),
                  child: const Icon(Icons.account_circle, size: 200.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  personDetail.name!,
                  style: CommonWidget.detailScreenTextStyle,
                ),
                const SizedBox(height: 10.0),
                Text(personDetail.mobileNumber!,
                    style: CommonWidget.detailScreenTextStyle),
                const SizedBox(height: 10.0),
                Text(personDetail.emailAddress!,
                    style: CommonWidget.detailScreenTextStyle),
                const SizedBox(height: 10.0),
                Text(personDetail.district!,
                    style: CommonWidget.detailScreenTextStyle),
                const SizedBox(height: 10.0),
                Text(personDetail.state!,
                    style: CommonWidget.detailScreenTextStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
