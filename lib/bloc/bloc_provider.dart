import 'package:flutter/widgets.dart';

Type _typeOf<T>() => T;

abstract class BlocBase {
  void dispose(); 
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }): super(key: key);

  final Widget child;
  final T bloc;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context){
    final type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited<T> provider = 
    /*
     * Why using the ancestorInheritedElementForWidgetOfExactType ?
     * You might have noticed that I use the ancestorInheritedElementForWidgetOfExactType method instead of the usual inheritFromWidgetOfExactType.
     * The reason comes from the fact that I do not want the context that invokes the BlocProvider to be registered as a dependency of the InheritedWidget since I do not need it.
     * 
    */
            context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.bloc;
  }
}


class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>>{
  @override
  void dispose(){
    widget.bloc?.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    return new _BlocProviderInherited<T>(
      bloc: widget.bloc,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}
