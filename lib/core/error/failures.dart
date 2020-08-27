import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure();
  @override
  List<Object> get props => [const <dynamic>[]];
  
}

//General Failures
class ServerFailure extends Failure{}

class CacheFailure extends Failure{}