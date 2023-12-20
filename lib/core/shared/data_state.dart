import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioError? error;

  const DataState({this.data, this.error});
}

// get data successful
class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

// get data failed
class DataFailed<T> extends DataState<T> {
  const DataFailed(DioError error) : super(error: error);
}
