import 'package:flutter/material.dart';
import 'package:flutter_course_a/data/data_source/ApiProvider.dart';
import 'package:flutter_course_a/data/data_source/ResponseModel.dart';
import 'package:flutter_course_a/data/models/UserModel.dart';

class UserDataProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();

  late dynamic dataFuture;
  ResponseModel? registerStatus;
  var error;
  var response;

  callRegister(name, email, password) async {
    //start loading api
    registerStatus = ResponseModel.loading("is Loading ...");
    notifyListeners();

    try {
      // fetch data from api and goto mainWrapper
      response = await apiProvider.callRegisterApi(name, email, password);
      if (response.statusCode == 201) {
        dataFuture = UserModel.fromJson(response.data);
        registerStatus = ResponseModel.completed(dataFuture);
      } else if (response.statusCode == 200) {
        dataFuture = ApiStatus.fromJson(response.data);
        registerStatus = ResponseModel.error(dataFuture.message);
      }
      notifyListeners();
    } catch (e) {
      // catch any error and show error
      registerStatus = ResponseModel.error("please check your connection...");
      notifyListeners();
      print(e.toString());
    }
  }
// callLoginApi(email, password) async {
//
//   loginStatus = Status.LOADING;
//   notifyListeners();
//
//
//   try{
//     response = await apiProvider.loginApi(email, password);
//     if(response.statusCode == 201){
//       dataFuture = UserModel.fromJson(response.data);
//       loginStatus = Status.COMPLETED;
//     }else{
//       dataFuture = ApiStatus.fromJson(response.data);
//       loginStatus = Status.ERROR;
//       error = dataFuture.message;
//     }
//
//     notifyListeners();
//
//
//   }catch(e) {
//     loginStatus = Status.ERROR;
//     error = "please check your connection...";
//     notifyListeners();
//
//     print(e.toString());
//   }
// }

// @override
// void dispose() {
//   loginStatus = null;
// }
}
