class BaseResponse {
  dynamic data;
  List? error;
  int? success;

  BaseResponse({this.data, this.error, this.success});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      data: json['data'],
      error: json['error'] != null
          ? (json['error'] as List).map((i) => i).toList()
          : null,
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }

    if (error != null) {
      data['error'] = error!.map((v) => v).toList();
    }
    return data;
  }
}
