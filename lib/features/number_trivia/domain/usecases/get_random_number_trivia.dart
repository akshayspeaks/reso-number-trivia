import 'package:injectable/injectable.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

@lazySingleton
class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  NumberTriviaRepository _repository;
  GetRandomNumberTrivia(this._repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(params) async {
    return await _repository.getRandomNumberTrivia();
  }
}
