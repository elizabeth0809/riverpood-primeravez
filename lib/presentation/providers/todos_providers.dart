import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/domain/domain.dart';
import 'package:uuid/uuid.dart';
part 'todos_providers.g.dart';
const uuid = Uuid();
enum FilterType{all, completed, pending}
@Riverpod(keepAlive: true)
class TodoCurrentFilter extends _$TodoCurrentFilter{
  @override
  FilterType build() => FilterType.all;
  void setCurrentFilter(FilterType newFilter){
    state = newFilter;
  }
}

@Riverpod(keepAlive: true)
class Todos extends _$Todos {
  @override
   List<Todo> build() => [
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),

   ];
   void toggleTodo(String id){
    state = state.map((todo){
      if(todo.id == id){
        todo = todo.copyWith(
          //se usa el copywith para modifical una propiedad con el valor final, em este caso es completeAt
          completedAt: todo.done ? null : DateTime.now()
        );
      }
      return todo;
    }).toList();
   }
   void createTodo(String description){
    state =[...state, Todo(id: uuid.v4(), description: description, completedAt: null)];
   }
}

@riverpod 
List<Todo> filteredTodos(FilteredTodosRef ref) {
  final currentFilter = ref.watch(todoCurrentFilterProvider);
  final todos = ref.watch(todosProvider);

  switch (currentFilter) {
    case FilterType.all:
      return todos;
  case FilterType.completed:
      return todos.where((todo) => todo.done).toList();
    case FilterType.pending:
      return todos.where((todo) => !todo.done).toList();

    default:
      throw Exception("Filtro no válido: $currentFilter");
  }
}
