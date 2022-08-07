import 'package:flutter_course_a/data/data_source/ApiProvider.dart';
import 'package:flutter_course_a/data/models/CryptoModel/AllCryptoModel.dart';

class CryptoDataRepository {
  var response;
  late AllCryptoModel dataFuture;
  ApiProvider apiProvider = ApiProvider();

  Future<AllCryptoModel> getTopGainersData() async {
    response = await apiProvider.getTopGainerData();
    dataFuture = AllCryptoModel.fromJson(response.data);

    return dataFuture;
  }
}
