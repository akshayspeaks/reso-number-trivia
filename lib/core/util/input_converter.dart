import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:number_trivia/core/error/failures.dart';

@lazySingleton
class InputConverter {
  Either<Failure, int> stringToUnsignedInt(String str) {
    try {
      int num = int.parse(str);
      if (num < 0) throw FormatException();
      return Right(num);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
