class ChecklistModel {
  ChecklistModel({this.statusCode, this.message, this.errorMessage, this.data});
  final int? statusCode;
  final String? message;
  final String? errorMessage;
  final List<Checklist>? data;

  factory ChecklistModel.fromJson(Map<String, dynamic> json) => ChecklistModel(
        statusCode: json['statusCode'],
        message: json['message'],
        errorMessage: json['errorMessage'],
        data: List<Checklist>.from(
            json['data'].map((x) => Checklist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'message': message,
        'errorMessage': errorMessage,
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Checklist {
  Checklist({this.id, this.name, this.items, this.checklistCompletionStatus});

  int? id;
  String? name;
  List<ChecklistItems>? items;
  bool? checklistCompletionStatus;

  factory Checklist.fromJson(Map<String, dynamic> json) => Checklist(
        id: json['id'],
        name: json['name'],
        items: json['items'] == null
            ? null
            : List<ChecklistItems>.from(
                json['items'].map((x) => ChecklistItems.fromJson(x))),
        checklistCompletionStatus: json['checklistCompletionStatus'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'items': items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        'checklistCompletionStatus': checklistCompletionStatus,
      };
}

class ChecklistItems {
  ChecklistItems({this.id, this.name, this.itemCompletionStatus});

  int? id;
  String? name;
  bool? itemCompletionStatus;

  factory ChecklistItems.fromJson(Map<String, dynamic> json) => ChecklistItems(
        id: json['id'],
        name: json['name'],
        itemCompletionStatus: json['itemCompletionStatus'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'itemCompletionStatus': itemCompletionStatus,
      };
}
