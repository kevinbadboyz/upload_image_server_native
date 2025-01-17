import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../repo/user_repository.dart';
import 'user_create_page.dart';
import 'user_detail_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final userRepository = UserRepository();
  late final Future<List<UserModel>> futureUsers;
  String blankImage =
      'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty-300x240.jpg';

  @override
  void initState() {
    futureUsers = userRepository.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of User'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserCreatePage()));
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: futureUsers,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    UserModel userModel = snapshot.data![index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UserDetailPage(userModel: userModel)));
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(userModel.image != null
                            ? userModel.image!
                            : blankImage),
                      ),
                      title:
                          Text('${userModel.firstName} ${userModel.lastName}'),
                      subtitle: Text(userModel.gender),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                        thickness: 1,
                      ),
                  itemCount: snapshot.data!.length);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
