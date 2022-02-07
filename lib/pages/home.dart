import 'package:accordion_challenge/bloc/accordionBloc.dart';
import 'package:accordion_challenge/model/groupModel.dart';
import 'package:accordion_challenge/widgets/groupWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<GroupModel> list = [];

  double percentageCompletion = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFE5E5E5),
        child: BlocProvider<AccordionBloc>(
          create: (context) => AccordionBloc()..getGroupTaskList(),
          child: BlocConsumer<AccordionBloc, AccordionState>(
            listener: (context, state) {
              if (state is AccordionGroupShowHidePressed) {
                list[state.groupIndex].show = state.show;
              } else if (state is AccordionRadioTaskPressed) {
                list[state.groupIndex].tasks![state.taskIndex].checked =
                    state.isChecked;
                if (state.isChecked) {
                  percentageCompletion += state.percentageCompleted;
                } else {
                  percentageCompletion -= state.percentageCompleted;
                }
                list[state.groupIndex].allSelected = list[state.groupIndex]
                    .tasks!
                    .every((element) => element.checked == true);
              }
            },
            builder: (context, state) {
              if (state is AccordionLoading || state is AccordionInitial) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF00B797),
                  ),
                );
              } else if (state is AccordionSuccess) {
                list = state.list;
                percentageCompletion = state.percentageCompleted;
                list.forEach((element) {
                  element.allSelected = element.tasks!
                      .every((element) => element.checked == true);
                });

                return accordionWidget(context);
              }
              return accordionWidget(context);
            },
          ),
        ),
      ),
    );
  }

  SingleChildScrollView accordionWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Flex(
        direction: Axis.vertical,
        children: [
          Container(
            margin: EdgeInsets.only(top: 70, right: 20, left: 20, bottom: 30),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFCCCCCC))),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Lodgify Grouped Tasks',
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF333333),
                      height: 24 / 22,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 16,
                ),
                LinearPercentIndicator(
                  padding: EdgeInsets.zero,
                  animation: true,
                  lineHeight: 24.0,
                  animationDuration: 2000,
                  animateFromLastPercent: true,
                  percent: percentageCompletion / 100,
                  center: Text(
                    "${percentageCompletion.toStringAsFixed(1)}%",
                    style: TextStyle(fontSize: 16, color: Colors.greenAccent),
                  ),
                  barRadius: Radius.circular(16),
                  progressColor: Color(0xFF00B797),
                  backgroundColor: Color(0xFFFFFFFF),
                ),
                SizedBox(
                  height: 32,
                ),
                GroupWidget(
                  list: list,
                  context: context,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
