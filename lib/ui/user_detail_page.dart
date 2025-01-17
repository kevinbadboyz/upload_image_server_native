import 'package:flutter/material.dart';
import 'package:upload_image_server_native/models/user_model.dart';
import 'package:upload_image_server_native/ui/user_update_page.dart';

class UserDetailPage extends StatelessWidget {
  UserModel userModel;
  String blankImage =
      'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty-300x240.jpg';

  UserDetailPage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${userModel.firstName} ${userModel.lastName}'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  userModel.image != null ? userModel.image! : blankImage),
              radius: 80,
            ),
            ListTile(
              title: Text('Nama Depan'),
              subtitle: Text('${userModel.firstName}'),
            ),
            ListTile(
              title: Text('Nama Belakang'),
              subtitle: Text('${userModel.lastName}'),
            ),
            ListTile(
              title: Text('Jenis Kelamin'),
              subtitle: Text('${userModel.gender}'),
            ),
            Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserUpdatePage(userModel: userModel)));
                    },
                    child: Text('Ubah')),
                OutlinedButton(onPressed: () {}, child: Text('Hapus'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
