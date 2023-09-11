import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_providers.g.dart';
//esto mantiene vivo el estado obtenido
@Riverpod(keepAlive: true) 
class Counter extends _$Counter {
  @override
  int build() => 5;
  void increaseByOne(){
    state = state +5;
  }
}
@riverpod 
class DarkMode extends _$DarkMode {
  @override
  bool build() => false;
  void toggleDarkMode(){
    state = !state;
   }
  
}
@Riverpod(keepAlive: true) 
class UserName extends _$UserName {
  @override
  String build() => 'melissa flores';
  void changeName(String name){
    state = name;
  }
  
}