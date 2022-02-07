class GroupModel {
  String? name;
  List<Tasks>? tasks;
  bool? show = false;
  bool? allSelected = false;
  GroupModel({this.name, this.tasks, this.show});

  GroupModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(new Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tasks {
  String? description;
  int? value;
  bool? checked;

  Tasks({this.description, this.value, this.checked});

  Tasks.fromJson(Map<String, dynamic> json) {
    description = json['description'] != null
        ? json['description']
        : json['name'] != null
        ? json['name']
        : '';
    value = json['value'];
    checked = json['checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['value'] = this.value;
    data['checked'] = this.checked;
    return data;
  }
}
