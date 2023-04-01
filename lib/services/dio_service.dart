// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';

import '../utility/myconstant.dart';

Dio dio = Dio();

class DioService {
  static Future createDio({String? path, var body, var option}) async {
    try {
      final req = body;
      print('dio_data_post ===> ${req}');

      dio.options.connectTimeout = MyConstant.connectTimeout;
      var response = await dio.post<Map>(
        path!,
        data: req,
        options: Options(headers: option),
      );

      var data = response.data;
      print('dio_response_data ===> ${data}');
      return data;
    } on DioError catch (e) {
      var data = {'resultCode': e.message, 'resultDesc': 'Dio catch error'};
      print('dio_err_data ===> ${e}');
      return data;
    }
  }
}
