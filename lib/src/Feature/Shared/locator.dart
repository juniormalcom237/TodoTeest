import 'package:get_it/get_it.dart';
import 'package:todo_test_app/src/Feature/home/domain/usecase/create_todo_usecase.dart';
import 'package:todo_test_app/src/Feature/home/domain/usecase/delete_todo_usecase.dart';
import 'package:todo_test_app/src/Feature/home/domain/usecase/get_all_todo_usecase.dart';

import 'package:todo_test_app/src/Feature/home/domain/usecase/update_todo_usecase.dart';
import '../home/data/local/database.dart';
import '../home/data/repository/todo_repository_impl.dart';
import '../home/domain/repository/todo_repository.dart';
import '../home/ui/bloc/todo_bloc.dart';

final GetIt locator = GetIt.instance;

Future<void> init() async {
  // BLoC
  locator.registerFactory(
    () => TodoBloc(
      getAllTodoUseCase: locator(),
      createTodoUseCase: locator(),
      updateTodoUseCase: locator(),
      deleteTodoUseCase: locator(),
    ),
  );

  // Use cases
  locator.registerLazySingleton(() => GetAllTodoUseCase(locator()));

  locator.registerLazySingleton(() => CreateTodoUseCase(locator()));
  locator.registerLazySingleton(() => UpdateTodoUseCase(locator()));
  locator.registerLazySingleton(() => DeleteTodoUseCase(locator()));

  locator.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(locator()),
  );

  // Data sources
  locator.registerLazySingleton(() => AppDatabase());
}
