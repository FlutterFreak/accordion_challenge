import 'package:accordion_challenge/bloc/accordionBloc.dart';
import 'package:accordion_challenge/model/groupModel.dart';
import 'package:accordion_challenge/widgets/taskWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupWidget extends StatelessWidget {
  final List<GroupModel> list;
  final BuildContext context;

  const GroupWidget({
    Key? key,
    required this.list,
    required this.context,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFCCCCCC))),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: list.length,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return Divider(
            color: Color(0xFFCCCCCC),
            height: 1,
            thickness: 0.5,
          );
        },
        itemBuilder: (context, index) {
          return Column(
            children: [
              groupTile(list[index], index),
              list[index].show!
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: list[index].tasks!.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return TaskWidget(
                          task: list[index].tasks![i],
                          context: context,
                          groupIndex: index,
                          taskIndex: i,
                        );
                      },
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  Container groupTile(GroupModel groupModel, int groupIndex) {
    return Container(
      key: Key('groupTile'),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 24),
      child: InkWell(
        onTap: () {
          BlocProvider.of<AccordionBloc>(context)
              .setGroupShowHideFlag(groupModel.show!, groupIndex);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Image.asset(
                    groupModel.allSelected!
                        ? 'assets/booking-ok.png'
                        : 'assets/groupIcon.png',
                    width: 13.6,
                    height: 16.07,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                      groupModel.name!,
                      style: TextStyle(
                          fontSize: 18,
                          color: groupModel.allSelected!
                              ? Color(0xFF00B797)
                              : Color(0xFF333333),
                          height: 22 / 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  groupModel.show! ? 'Hide' : 'Show',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF999999),
                      height: 20.11 / 16,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 16,
                ),
                Image.asset(
                  groupModel.show!
                      ? 'assets/arrowUp.png'
                      : 'assets/arrowDown.png',
                  width: 13.6,
                  height: 16.07,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
