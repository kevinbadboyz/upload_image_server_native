import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upload_image_server_native/models/user_model.dart';

import '../params/user_param.dart';
import '../repo/user_repository.dart';
import '../responses/user_create_response.dart';

class UserUpdatePage extends StatefulWidget {
  UserModel userModel;

  UserUpdatePage({super.key, required this.userModel});

  @override
  State<UserUpdatePage> createState() => _UserUpdatePageState();
}

class _UserUpdatePageState extends State<UserUpdatePage> {
  final userRepository = UserRepository();
  late final Future<UserCreateResponse> futureUserUpdate;
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
  void initState() {
    tecFirstname.text = widget.userModel.firstName;
    tecLastname.text = widget.userModel.lastName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Update User'),
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
                  value: widget.userModel.gender == null
                      ? dropDownValue
                      : widget.userModel.gender,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 150,
                    child: CircleAvatar(
                      backgroundImage: widget.userModel.image == null
                          ? NetworkImage(blankImage)
                          : NetworkImage(widget.userModel.image.toString()),
                    ),
                  ),
                  file == null
                      ? Text('Silahkan upload gambar')
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: 150,
                          child: Image.file(file!, fit: BoxFit.contain)),
                ],
              ),
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
                              futureUserUpdate = userRepository.updateUser(
                                  UserParam(
                                      id: widget.userModel.id,
                                      firstName: tecFirstname.text,
                                      lastName: tecLastname.text,
                                      gender: dropDownValue,
                                      image: file));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Data berhasil diubah...')));
                            }
                          },
                          child: Text('Ubah')),
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
