part of 'accordionBloc.dart';

@immutable
abstract class AccordionState {}

class AccordionInitial extends AccordionState {}

class AccordionLoading extends AccordionState {}

class AccordionGroupShowHidePressed extends AccordionState {
  final bool show;
  final int groupIndex;
  AccordionGroupShowHidePressed(this.show, this.groupIndex);
}

class AccordionRadioTaskPressed extends AccordionState {
  final bool isChecked;
  final int groupIndex;
  final int taskIndex;
  final double percentageCompleted;

  AccordionRadioTaskPressed(this.isChecked, this.percentageCompleted,
      this.groupIndex, this.taskIndex);
}

class AccordionSuccess extends AccordionState {
  final List<GroupModel> list;
  final double percentageCompleted;
  AccordionSuccess(this.list, this.percentageCompleted);
}
