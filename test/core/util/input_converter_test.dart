import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/util/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  test(
      'should return an integer when the string represents an unsigned integer',
      () async {
    //arrange
    final str = '123';
    //act
    final result = inputConverter.stringToUnsignedInt(str);
    //assert
    expect(result, Right(123));
  });

  test('should return a failure when string is not an integer', () async {
    //arrange
    final str = '1.23';
    //act
    final result = inputConverter.stringToUnsignedInt(str);
    //assert
    expect(result, Left(InvalidInputFailure()));
  });
  test('should return a Failure when the string is a negative integer',
      () async {
    //arrange
    final str = '-123';
    //act
    final result = inputConverter.stringToUnsignedInt(str);
    //assert
    expect(result, Left(InvalidInputFailure()));
  });
}
