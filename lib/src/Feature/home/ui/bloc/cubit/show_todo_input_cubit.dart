import 'package:bloc/bloc.dart';

class ShowTodoInputCubit extends Cubit<bool> {
  ShowTodoInputCubit() : super(false);

  void toggleShowInput(bool value) => emit(value);
}
