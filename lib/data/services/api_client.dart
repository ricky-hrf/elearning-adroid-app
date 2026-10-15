import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'token_storage.dart';
import 'package:flutter/foundation.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? errors;
  ApiException(this.message, {this.statusCode, this.errors});

  @override
  String toString() => message;
}

class ApiClient {
  ApiClient._();
  static final ApiClient instance = ApiClient._();

  final _tokens = TokenStorage.instance;

  void Function()? onUnauthorized;

  Future<Map<String, dynamic>> get(String path, {bool auth = true}) =>
      _send('GET', path, auth: auth);

  Future<Map<String, dynamic>> post(String path,
      {Map<String, dynamic>? body, bool auth = true}) =>
      _send('POST', path, body: body, auth: auth);

  Future<Map<String, dynamic>> _send(String method, String path,
      {Map<String, dynamic>? body, required bool auth}) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}$path');
    if (kDebugMode) debugPrint('→ $method $uri');
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'User-Agent': 'ElearningApp/1.0 (Android)',
    };
    if (auth) {
      final token = await _tokens.read();
      if (token != null) headers['Authorization'] = 'Bearer $token';
    }

    try {
      final http.Response res = method == 'GET'
          ? await http.get(uri, headers: headers).timeout(ApiConfig.timeout)
          : await http
          .post(uri, headers: headers, body: jsonEncode(body ?? {}))
          .timeout(ApiConfig.timeout);

      Map<String, dynamic> json;
      try {
        json = jsonDecode(res.body) as Map<String, dynamic>;
      } catch (_) {
        throw ApiException('Respons server tidak valid',
            statusCode: res.statusCode);
      }

      if (res.statusCode >= 200 && res.statusCode < 300) return json;

      if (res.statusCode == 401 && auth) {
        await _tokens.clear();
        onUnauthorized?.call();
      }
      throw ApiException(
        json['message']?.toString() ?? 'Terjadi kesalahan',
        statusCode: res.statusCode,
        errors: json['errors'] is Map
            ? Map<String, dynamic>.from(json['errors'])
            : null,
      );
    } on SocketException {
      throw ApiException('Tidak dapat terhubung ke server');
    } on TimeoutException {
      throw ApiException('Koneksi timeout, coba lagi');
    }
  }
}