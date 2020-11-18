import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hues_dovui/src/config/app_endpoint.dart';
import 'package:hues_dovui/src/resource/model/question.dart';
import 'package:hues_dovui/src/resource/service/DioService.dart';

class QuestionRepository {
  Future<List<Question>> getQuestions(int id) async {
    final _ques = <Question>[];
    Response response = await DioService()
        .get(AppEndpoint.QUESTION, queryParameters: {'id': id-1});
    List.from(response.data).forEach((element) {
      _ques.add(Question.fromJson(element));
    });

    return _ques;
  }
}
