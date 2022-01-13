class AuthModel {
  AuthModel({this.statusCode, this.message, this.errorMessage, this.data});
  final int? statusCode;
  final String? message;
  final String? errorMessage;
  final Map<String, dynamic>? data;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        statusCode: json['statusCode'],
        message: json['message'],
        errorMessage: json['errorMessage'],
        data: json['data'],
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'message': message,
        'errorMessage': errorMessage,
        'data': data,
      };
}
