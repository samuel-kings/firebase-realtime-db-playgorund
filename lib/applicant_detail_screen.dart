import 'package:fb_rtdb_pg/applicant.dart';
import 'package:fb_rtdb_pg/applicant_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicantDetailScreen extends StatelessWidget {
  final String id;
  const ApplicantDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ApplicantProvider>();

    return FutureBuilder(
      future: provider.getApplicant(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          Applicant data = snapshot.data!;
          List<({String key, String value})> infoPairs = [
            (key: "Name", value: data.name),
            (key: "Country", value: data.country),
            (key: "Gender", value: data.gender),
            (key: "Current Occupation", value: data.occupation),
            (key: "Qualification", value: data.cert),
            (key: "Age", value: "${data.age} years old"),
            (key: "Yrs. of experience", value: data.xpYrs.toString()),
          ];
          return Scaffold(
            appBar: AppBar(
              title: Text(data.name),
              actions: [
                IconButton(
                    onPressed: () async {
                      bool isDeleted = await provider.deleteApplicant(data.id);
                      if (!context.mounted) return;

                      if (isDeleted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("Applicant deleted successfuly"),
                          ),
                        );
                        Navigator.of(context, rootNavigator: true).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(provider.error),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.delete_outline))
              ],
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: infoPairs.map((e) {
                      return _infoRow(e.key, e.value);
                    }).toList())),
          );
        }
      },
    );
  }

  Widget _infoRow(String key, String value) {
    return Card(
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [Text(key), const SizedBox(width: 8), Text(value)],
        ),
      ),
    );
  }
}
