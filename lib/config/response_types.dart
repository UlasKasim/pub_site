class ListApiResponse<T> {
  int statusCode;
  String message;
  List<T> data;

  ListApiResponse(this.statusCode, this.message, this.data);
}

class ListOfListApiResponse<T> {
  int statusCode;
  String message;
  List<List<T>> data;
  ListOfListApiResponse({
    this.statusCode,
    this.message,
    this.data,
  });
}
