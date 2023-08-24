import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:fb_rtdb_pg/applicant.dart';
import 'package:fb_rtdb_pg/applicant_detail_screen.dart';
import 'package:fb_rtdb_pg/applicant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool>? _future;
  ApplicantProvider _provider = ApplicantProvider();

  @override
  void initState() {
    super.initState();
    _provider = context.read<ApplicantProvider>();
    _future = _provider.listApplicants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase RTDB Playground"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      final formKey = GlobalKey<FormState>();
                      final name = TextEditingController();
                      final gender = TextEditingController();
                      final country = TextEditingController();
                      final occupation = TextEditingController();
                      final qualification = TextEditingController();
                      final age = TextEditingController();
                      final xpYrs = TextEditingController();
                      bool isCreating = false;

                      return AlertDialog.adaptive(
                        title: const Text("Create a new applicant"),
                        actionsAlignment: MainAxisAlignment.spaceBetween,
                        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        content: BlurryModalProgressHUD(
                          inAsyncCall: isCreating,
                          blurEffectIntensity: 1.0,
                          progressIndicator: const SpinKitFadingCircle(
                            color: Colors.purple,
                            size: 90.0,
                          ),
                          dismissible: false,
                          opacity: 0.2,
                          color: Colors.black54,
                          child: SingleChildScrollView(
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // name
                                  TextFormField(
                                      controller: name,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.length < 6) {
                                          return "cannot be less than 6 characters";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                          labelText: "Name",
                                          hintText: 'John Doe')),
                                  const SizedBox(height: 10),
                                  // gender
                                  TextFormField(
                                      controller: gender,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.length < 4) {
                                          return "cannot be less than 4 characters";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                          labelText: "Gender",
                                          hintText: 'Male/Female')),
                                  const SizedBox(height: 10),
                                  // country
                                  TextFormField(
                                      controller: country,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "cannot be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                          labelText: "Country",
                                          hintText: 'Nigeria')),
                                  const SizedBox(height: 10),
                                  // occupation
                                  TextFormField(
                                      controller: occupation,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "cannot be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                          labelText: "Occupation",
                                          hintText: 'Software Dev')),
                                  const SizedBox(height: 10),
                                  // qualification
                                  TextFormField(
                                      controller: qualification,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "cannot be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                          labelText: "Qualification",
                                          hintText: 'BSc')),
                                  const SizedBox(height: 10),
                                  // age
                                  TextFormField(
                                      controller: age,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "cannot be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                          labelText: "Age",
                                          hintText: '28')),
                                  const SizedBox(height: 10),
                                  // xp
                                  TextFormField(
                                      controller: xpYrs,
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "cannot be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                          labelText: "Years of experience",
                                          hintText: '4')),
                                ],
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          Visibility(
                            visible: !isCreating,
                            child: TextButton(
                                onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                                child: const Text("Cancel")),
                          ),
                          Visibility(
                              visible: !isCreating,
                              child: TextButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      setState(() {
                                        isCreating = true;
                                      });

                                      Applicant applicant = Applicant(
                                          name: name.text.trim(),
                                          id: id(name.text.trim()),
                                          cert: qualification.text.trim(),
                                          country: country.text.trim(),
                                          occupation: occupation.text.trim(),
                                          gender: gender.text.trim(),
                                          age: int.parse(age.text.trim()),
                                          xpYrs: int.parse(xpYrs.text.trim()));

                                      final isCreated = await _provider.createApplicant(applicant);

                                      setState(() {
                                        isCreating = false;
                                      });

                                      if (!mounted) return;

                                      if (isCreated) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text("Applicant created successfuly"),
                                          ),
                                        );
                                        Navigator.of(context, rootNavigator: true).pop();
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(_provider.error),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: const Text("Create")))
                        ],
                      );
                    },
                  );
                });
          },
          label: const Text("Add applicant"),
          icon: const Icon(Icons.person_add)),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else {
            return Selector<ApplicantProvider, List<Applicant>>(
              selector: (_, provider) => provider.applicants,
              builder: (context, applicants, child) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16).copyWith(bottom: 0),
                  child: Column(
                      children: applicants.map((e) {
                    return Card(
                      margin: const EdgeInsets.all(5),
                      child: ListTile(
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => ApplicantDetailScreen(id: e.id))),
                        contentPadding: const EdgeInsets.all(5),
                        title: Text(e.name),
                        subtitle: Text(e.cert),
                        trailing: Text("${e.xpYrs.toString()}\nExp"),
                      ),
                    );
                  }).toList()),
                );
              },
            );
          }
        },
      ),
    );
  }
}
