import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upload_image_server_native/params/user_param.dart';
import 'package:upload_image_server_native/repo/user_repository.dart';
import 'package:upload_image_server_native/responses/user_create_response.dart';

class UserCreatePage extends StatefulWidget {
  const UserCreatePage({super.key});

  @override
  State<UserCreatePage> createState() => _UserCreatePageState();
}

class _UserCreatePageState extends State<UserCreatePage> {
  final userRepository = UserRepository();
  late final Future<UserCreateResponse> futureUserCreate;
  final tecFirstname = TextEditingController();
  final tecLastname = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  List<String> listStatus = ['Male', 'Female'];
  String dropDownValue = 'Male';
  File? file;
  final ImagePicker picker = ImagePicker();
  final blankImage =
      'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty-300x240.jpg';

  Future getImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        file = File(image.path);
      } else {
        debugPrint('No image...');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Add User'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: globalKey,
          child: Column(
            children: [
              TextFormField(
                controller: tecFirstname,
                decoration: InputDecoration(
                    labelText: 'Nama Depan', hintText: 'Masukkan nama depan'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Nama depan masih kosong'
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: tecLastname,
                decoration: InputDecoration(
                    labelText: 'Nama Belakang',
                    hintText: 'Masukkan nama belakang'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Nama belakang masih kosong'
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                  value: dropDownValue,
                  items: listStatus
                      .map((element) => DropdownMenuItem(
                            child: Text(element),
                            value: element,
                          ))
                      .toList(),
                  onChanged: (value) {
                    dropDownValue = value!;
                  }),
              const SizedBox(
                height: 20,
              ),
              file == null
                  ? Text('Silahkan upload gambar')
                  : Container(
                      width: double.infinity,
                      height: 200,
                      child: Image.file(file!, fit: BoxFit.contain)),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  file == null
                      ? ElevatedButton(
                          onPressed: () {
                            getImage();
                          },
                          child: Text('Ambil Gambar'))
                      : ElevatedButton(
                          onPressed: () {
                            if (globalKey.currentState!.validate()) {
                              futureUserCreate = userRepository.createUser(
                                  UserParam(
                                      firstName: tecFirstname.text,
                                      lastName: tecLastname.text,
                                      gender: dropDownValue,
                                      image: file));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Data berhasil disimpan...')));
                            }
                          },
                          child: Text('Simpan')),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Batal'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
