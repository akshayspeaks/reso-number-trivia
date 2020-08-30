import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/util/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('Initial state should be empty', () {
    //assert
    expect(bloc.state, Empty());
  });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    test(
        'should call InputConverter to validate/convert string to unsigned integer ',
        () async {
      //arrange
      when(mockInputConverter.stringToUnsignedInt(any))
          .thenReturn(Right(tNumberParsed));
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInt(any));
      //assert
      verify(mockInputConverter.stringToUnsignedInt(tNumberString));
    });

    test('OLD WAY should emit [Error] when the input is invalid', () async {
      //arrange
      when(mockInputConverter.stringToUnsignedInt(any))
          .thenReturn(Left(InvalidInputFailure()));
      //assert later
      final expected = [
        Error(message: INVALID_INPUT_FAILURE_MESSAGE),
      ];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    blocTest(
      'bloc_test emits [Error] when the input is invalid',
      build: () {
        when(mockInputConverter.stringToUnsignedInt(any))
            .thenReturn(Left(InvalidInputFailure()));
        return bloc;
      },
      act: (bloc) {
        bloc.add(GetTriviaForConcreteNumber(tNumberString));
      },
      expect: [Error(message: INVALID_INPUT_FAILURE_MESSAGE)],
    );
  });
}
