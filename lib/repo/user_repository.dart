import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../params/user_param.dart';
import '../responses/user_create_response.dart';

class UserRepository {
  Future<List<UserModel>> getUsers() async {
    try {
      // var response = await Dio().get('http://54.243.8.93:8000/api/users');
      var response = await Dio().get('http://10.0.2.2:8000/api/users');
      debugPrint('GET All User Response : ${response.data}');
      List list = response.data;
      List<UserModel> listUser =
          list.map((element) => UserModel.fromJson(element)).toList();
      return listUser;
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCreateResponse> createUser(UserParam userParam) async {
    File? file;

    if (userParam.image != null) {
      file = userParam.image!;
    }

    FormData formData = FormData.fromMap({
      'firstName': userParam.firstName,
      'lastName': userParam.lastName,
      'gender': userParam.gender,
      'image': await MultipartFile.fromFile(file!.path,
          filename: file.path.split('/').last),
    });
    try {
      // var response =
      //     await Dio().post('http://54.243.8.93:8000/api/users', data: formData);
      var response =
          await Dio().post('http://10.0.2.2:8000/api/users', data: formData);
      debugPrint('POST Response : ${response.data}');
      return UserCreateResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCreateResponse> updateUser(UserParam userParam) async {
    File? file;

    if (userParam.image != null) {
      file = userParam.image!;
    }

    FormData formData = FormData.fromMap({
      'firstName': userParam.firstName,
      'lastName': userParam.lastName,
      'gender': userParam.gender,
      'image': await MultipartFile.fromFile(file!.path,
          filename: file.path.split('/').last),
    });
    try {
      // var response =
      //     await Dio().post('http://54.243.8.93:8000/api/users', data: formData);
      var response = await Dio()
          .put('http://10.0.2.2:8000/api/user/${userParam.id}', data: formData);
      debugPrint('POST Response : ${response.data}');
      return UserCreateResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
