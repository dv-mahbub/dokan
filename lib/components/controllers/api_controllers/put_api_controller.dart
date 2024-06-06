import 'dart:convert';
import 'dart:developer';
import 'package:dokan/components/controllers/api_controllers/api_response_data.dart';
import 'package:dokan/components/controllers/shared_preference/token_store.dart';
import 'package:http/http.dart' as http;

Future<ApiResponseData> putApiController(
  String endpoint,
  bool isTokenNeeded,
  Map? body,
) async {
  Map<String, String> header = {
    'Content-Type': 'application/json',
  };
  if (isTokenNeeded) {
    final token = await TokenStore.getBearerToken();
    header["Authorization"] = "Bearer $token";
  }
  ApiResponseData result = ApiResponseData();
  try {
    final response = await http.put(
      Uri.parse(endpoint),
      headers: header,
      body: jsonEncode(body),
    );
    result.statusCode = response.statusCode;
    result.responseBody = response.body;
    return result;
  } catch (e) {
    result.responseBody = jsonEncode({"message": "Failed to connect"});
    log('Failed to connect with $endpoint');
  }
  return result;
}
