import 'dart:convert';

import 'package:accordion_challenge/model/groupModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'accordionState.dart';

class AccordionBloc extends Cubit<AccordionState> {
  AccordionBloc() : super(AccordionInitial());
  int totalValue = 0;
  int totalSelectedValue = 0;
  List<GroupModel> list = [];
  Future<void> getGroupTaskList() async {
    emit(AccordionLoading());
    final response = await http.get(Uri.parse(
        'https://gist.githubusercontent.com/huvber/ba0d534f68e34f1be86d7fe7eff92c96/raw/508f46dbf6535f830aa92cf97359853c5700bab1/mock-progress'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      json.decode(response.body).forEach((v) {
        list.add(new GroupModel.fromJson(v));
      });
      if (list.length > 0) {
        double percentage = await calculatePercentageCompletion(list);
        emit(AccordionSuccess(list, percentage));
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<void> setGroupShowHideFlag(bool show, int index) async {
    emit(AccordionLoading());
    emit(AccordionGroupShowHidePressed(!show, index));
  }

  Future<void> setIsCheckedFlag(
      bool isChecked, int groupIndex, int taskIndex) async {
    emit(AccordionLoading());
    double percentage = await calculateNormalizedValue(groupIndex, taskIndex);
    emit(AccordionRadioTaskPressed(
        !isChecked, percentage, groupIndex, taskIndex));
  }

  Future<double> calculatePercentageCompletion(List<GroupModel> list) async {
    int totalSelectedValue = 0;

    list.forEach((element) {
      element.tasks!.forEach((element) {
        totalValue += element.value!;
        if (element.checked!) {
          totalSelectedValue += element.value!;
        }
      });
    });
    double percentage = double.parse(
        (totalSelectedValue * 100 / totalValue).toStringAsFixed(1));
    return percentage;
  }

  Future<double> calculateNormalizedValue(int groupIndex, int taskIndex) async {
    int selectedValue = list[groupIndex].tasks![taskIndex].value!;
    double normalizedValue =
        double.parse((selectedValue * 100 / totalValue).toStringAsFixed(1));
    return normalizedValue;
  }
}
