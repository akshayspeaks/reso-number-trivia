// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:http/http.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'core/util/input_converter.dart';
import 'core/network/network_info.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'features/number_trivia/data/sources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/sources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'ext_dependencies/external.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<Client>(() => registerModule.client);
  gh.lazySingleton<DataConnectionChecker>(() => registerModule.checker);
  gh.lazySingleton<InputConverter>(() => InputConverter());
  gh.lazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(get<DataConnectionChecker>()));
  gh.lazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: get<Client>()));
  gh.lazySingleton<NumberTriviaLocalDataSource>(() =>
      NumberTriviaLocalDataSourceImpl(
          sharedPreferences: get<SharedPreferences>()));
  gh.lazySingleton<NumberTriviaRepository>(() => NumberTriviaRepositoryImpl(
        remoteDataSource: get<NumberTriviaRemoteDataSource>(),
        localDataSource: get<NumberTriviaLocalDataSource>(),
        networkInfo: get<NetworkInfo>(),
      ));
  gh.lazySingleton<GetConcreteNumberTrivia>(
      () => GetConcreteNumberTrivia(get<NumberTriviaRepository>()));
  gh.lazySingleton<GetRandomNumberTrivia>(
      () => GetRandomNumberTrivia(get<NumberTriviaRepository>()));
  gh.factory<NumberTriviaBloc>(() => NumberTriviaBloc(
        concrete: get<GetConcreteNumberTrivia>(),
        random: get<GetRandomNumberTrivia>(),
        inputConverter: get<InputConverter>(),
      ));

  // Eager singletons must be registered in the right order
  final sharedPreferences = await registerModule.prefs;
  gh.singleton<SharedPreferences>(sharedPreferences);
  return get;
}

class _$RegisterModule extends RegisterModule {}
