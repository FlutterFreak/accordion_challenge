import 'package:accordion_challenge/bloc/accordionBloc.dart';
import 'package:accordion_challenge/model/groupModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskWidget extends StatelessWidget {
  final Tasks task;
  final BuildContext context;
  final int groupIndex;
  final int taskIndex;
  const TaskWidget(
      {Key? key,
      required this.task,
      required this.context,
      required this.groupIndex,
      required this.taskIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('taskWidget'),
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              BlocProvider.of<AccordionBloc>(context)
                  .setIsCheckedFlag(task.checked!, groupIndex, taskIndex);
            },
            child: Image.asset(
              task.checked!
                  ? 'assets/radiocheckedBox.png'
                  : 'assets/radiocheckBox.png',
              width: 13.6,
              height: 16.07,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Text(
              task.description!,
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF333333),
                  height: 22 / 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
