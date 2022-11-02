import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../models/news.dart';
import 'package:http/http.dart' as http;

abstract class NewsRepository {
  Future<NewsModel> GetNews();
}

class ImpNewRepository implements NewsRepository {
  final baseUrl =
      'https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=5750df9119a1460baccd624d6ae5b67f';

  @override
  Future<NewsModel> GetNews() async {
    final response = await Dio().get(baseUrl);
    print(response.data);
      
      switch (response.statusCode) {
      case HttpStatus.ok:
        return NewsModel.fromJson(response.data);
      default:
        throw NetworkError(response.statusCode.toString(), response.statusCode.toString());
    }
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;

  NetworkError(this.statusCode, this.message);
}
